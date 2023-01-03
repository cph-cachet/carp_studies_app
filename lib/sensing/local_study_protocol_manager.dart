part of carp_study_app;

/// The local [StudyProtocolManager].
///
/// This is used for loading the [StudyProtocol] from a local in-memory
/// Dart definition.
class LocalStudyProtocolManager implements StudyProtocolManager {
  SmartphoneStudyProtocol? _protocol;

  Future initialize() async {}

  /// Create a new CAMS study protocol.
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String ignored) async {
    if (_protocol == null) {
      _protocol ??= await _getGenericCARPStudy(ignored);
      // _protocol ??= await _getPatientWristWatch(ignored);
      // _protocol = await _getTestWristWatch(ignored);

      // set the data endpoint based on the deployment mode (local or CARP)
      _protocol!.dataEndPoint = (bloc.deploymentMode == DeploymentMode.LOCAL)
          ? SQLiteDataEndPoint()
          : CarpDataEndPoint(
              uploadMethod: CarpUploadMethod.DATA_POINT,
              name: 'CARP Server',
            );
    }

    return _protocol;
  }

  Future<bool> saveStudyProtocol(
      String studyId, SmartphoneStudyProtocol protocol) async {
    throw UnimplementedError();
  }

  Future<SmartphoneStudyProtocol?> _getGenericCARPStudy(String studyId) async {
    if (_protocol == null) {
      if (_protocol == null) {
        _protocol = SmartphoneStudyProtocol(
          name: 'CARP Demo Protocol',
          ownerId: 'jakba',
        );

        // add the localized description
        _protocol!.protocolDescription = StudyDescription(
            title: 'study.description.title',
            description: 'study.description.description',
            purpose: 'study.description.purpose',
            studyDescriptionUrl: 'study.description.url',
            privacyPolicyUrl: 'study.description.privacy',
            responsible: StudyResponsible(
              id: 'study.responsible.id',
              title: 'study.responsible.title',
              address: 'study.responsible.address',
              affiliation: 'study.responsible.affiliation',
              email: 'study.responsible.email',
              name: 'study.responsible.name',
            ));

        // add CARP as the data endpoint
        //  * w/o authentication info - we expect to be authenticated
        //  * upload each data point as it is collected
        _protocol!.dataEndPoint = CarpDataEndPoint(
          uploadMethod: CarpUploadMethod.DATA_POINT,
          name: 'CARP Service',
        );

        // Define which devices are used for data collection.
        Smartphone phone = Smartphone();

        var eSense = ESenseDevice(
            // deviceName: '',
            // samplingRate: 10,
            );

        var polar = PolarDevice(
          roleName: 'hr-sensor',
          // identifier: 'B5FC172F',
          // name: 'H10',
          // polarDeviceType: PolarDeviceType.H10,
        );

        _protocol!.addMasterDevice(phone);
        _protocol!.addConnectedDevice(eSense);
        _protocol!.addConnectedDevice(polar);

        // ONLINE SERVICES
        //
        // Define online services and add them as connected 'devices'
        LocationService locationService = LocationService();
        _protocol!.addConnectedDevice(locationService);

        WeatherService weatherService =
            WeatherService(apiKey: '12b6e28582eb9298577c734a31ba9f4f');
        _protocol!.addConnectedDevice(weatherService);

        AirQualityService airQualityService = AirQualityService(
            apiKey: '9e538456b2b85c92647d8b65090e29f957638c77');
        _protocol!.addConnectedDevice(airQualityService);

        // BACKGROUND SENSING

        _protocol!.addTriggeredTask(
            ImmediateTrigger(),
            BackgroundTask(measures: [
              Measure(type: SensorSamplingPackage.LIGHT),
              Measure(type: SensorSamplingPackage.PEDOMETER),
              Measure(type: DeviceSamplingPackage.MEMORY),
              Measure(type: DeviceSamplingPackage.DEVICE),
              Measure(type: DeviceSamplingPackage.BATTERY),
              Measure(type: DeviceSamplingPackage.SCREEN),
              Measure(type: ContextSamplingPackage.ACTIVITY),
            ]),
            phone);

        // a background task that collects location on a regular basis
        // using the location service
        _protocol?.addTriggeredTask(
            IntervalTrigger(period: Duration(minutes: 5)),
            BackgroundTask(
                measures: [Measure(type: ContextSamplingPackage.LOCATION)]),
            locationService);

        // a background task that continously collects geolocation and mobility
        // using the location service
        _protocol?.addTriggeredTask(
            ImmediateTrigger(),
            BackgroundTask(measures: [
              //Measure(type: ContextSamplingPackage.GEOLOCATION),
              Measure(type: ContextSamplingPackage.MOBILITY),
            ]),
            locationService);

        // a background task that collects weather every 30 miutes.
        // using the weather service
        _protocol?.addTriggeredTask(
            IntervalTrigger(period: Duration(minutes: 30)),
            BackgroundTask()
              ..addMeasure(Measure(type: ContextSamplingPackage.WEATHER)),
            weatherService);

        // a background task that air quality every 30 miutes.
        // using the air quality service
        _protocol?.addTriggeredTask(
            IntervalTrigger(period: Duration(minutes: 30)),
            BackgroundTask()
              ..addMeasure(Measure(type: ContextSamplingPackage.AIR_QUALITY)),
            airQualityService);

        // WEARABLE DEVICES

        // eSense
        _protocol!.addTriggeredTask(
            ImmediateTrigger(),
            BackgroundTask(measures: [
              Measure(type: ESenseSamplingPackage.ESENSE_BUTTON),
              Measure(type: ESenseSamplingPackage.ESENSE_SENSOR),
            ]),
            eSense);

        // Polar
        _protocol!.addTriggeredTask(
            ImmediateTrigger(),
            BackgroundTask(measures: [
              Measure(type: PolarSamplingPackage.POLAR_HR),
              Measure(type: PolarSamplingPackage.POLAR_ECG)
            ]),
            polar);

        // APP TASKS
        //
        // Now creating a set of app tasks which are repeately added to the task
        // queue again after they are done by the user.
        // This is useful for demo purposes, so that the app tasks are always available.

        // First create all the tasks.

        var environmentTask = AppTask(
            type: BackgroundSensingUserTask.ONE_TIME_SENSING_TYPE,
            title: "environment.title",
            description: "environment.description",
            measures: [
              Measure(type: ContextSamplingPackage.LOCATION),
              Measure(type: ContextSamplingPackage.WEATHER),
              Measure(type: ContextSamplingPackage.AIR_QUALITY),
            ]);

        var demographicsTask = RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.demographics.title,
            description: surveys.demographics.description,
            minutesToComplete: surveys.demographics.minutesToComplete,
            expire: surveys.demographics.expire,
            rpTask: surveys.demographics.survey,
            measures: [Measure(type: ContextSamplingPackage.LOCATION)]);

        var symptomsTask = RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptoms.title,
            description: surveys.symptoms.description,
            minutesToComplete: surveys.symptoms.minutesToComplete,
            expire: surveys.symptoms.expire,
            notification: true,
            rpTask: surveys.symptoms.survey,
            measures: [Measure(type: ContextSamplingPackage.LOCATION)]);

        var readingTask = AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "reading.title",
            description: 'reading.description',
            instructions: 'reading.instructions',
            minutesToComplete: 3,
            measures: [
              Measure(type: MediaSamplingPackage.AUDIO),
              Measure(type: ContextSamplingPackage.LOCATION)
            ]);

        var imageTask = AppTask(
            type: VideoUserTask.IMAGE_TYPE,
            title: "wound.title",
            description: "wound.description",
            instructions: "wound.instructions",
            minutesToComplete: 3,
            measures: [Measure(type: MediaSamplingPackage.IMAGE)]);

        var parkinsonsTask = RPAppTask(
            type: SurveyUserTask.COGNITIVE_ASSESSMENT_TYPE,
            title: "Parkinsons Assessment",
            description:
                "A simple task assessing cognitive functioning and finger tapping speed.",
            minutesToComplete: 3,
            rpTask: RPOrderedTask(
              identifier: "parkinsons_assessment",
              steps: [
                RPInstructionStep(
                    identifier: 'parkinsons_instruction',
                    title: "Parkinsons Disease Assessment",
                    text:
                        "In the following pages, you will be asked to solve two simple test which will help assess your symptoms on a daily basis. "
                        "Each test has an instruction page, which you should read carefully before starting the test.\n\n"
                        "Please sit down comfortably and hold the phone in one hand while performing the test with the other."),
                RPFlankerActivity(
                  identifier: 'flanker_1',
                  lengthOfTest: 30,
                  numberOfCards: 10,
                ),
                RPTappingActivity(
                  identifier: 'tapping_1',
                  lengthOfTest: 10,
                )
              ],
            ),
            measures: [
              Measure(type: SensorSamplingPackage.ACCELEROMETER),
              Measure(type: SensorSamplingPackage.GYROSCOPE),
            ]);

        var parkinsonsSurvey = RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.parkinsons.title,
            description: surveys.parkinsons.description,
            minutesToComplete: surveys.parkinsons.minutesToComplete,
            expire: surveys.parkinsons.expire,
            notification: true,
            rpTask: surveys.parkinsons.survey,
            measures: [Measure(type: ContextSamplingPackage.LOCATION)]);

        // Then add all the tasks to the protocol to trigger once.

        _protocol!.addTriggeredTask(OneTimeTrigger(), environmentTask, phone);
        _protocol!.addTriggeredTask(OneTimeTrigger(), demographicsTask, phone);
        _protocol!.addTriggeredTask(OneTimeTrigger(), symptomsTask, phone);
        _protocol!.addTriggeredTask(OneTimeTrigger(), readingTask, phone);
        _protocol!.addTriggeredTask(OneTimeTrigger(), imageTask, phone);
        _protocol!.addTriggeredTask(OneTimeTrigger(), parkinsonsTask, phone);

        // And then add a set of user task triggers to make sure that the
        // task are added to the queque again when done

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: environmentTask.name,
                resumeCondition: UserTaskState.done),
            environmentTask,
            phone);

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: demographicsTask.name,
                resumeCondition: UserTaskState.done),
            demographicsTask,
            phone);

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: symptomsTask.name,
                resumeCondition: UserTaskState.done),
            symptomsTask,
            phone);

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: readingTask.name,
                resumeCondition: UserTaskState.done),
            readingTask,
            phone);

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: imageTask.name, resumeCondition: UserTaskState.done),
            imageTask,
            phone);

        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: parkinsonsTask.name,
                resumeCondition: UserTaskState.done),
            parkinsonsTask,
            phone);

        // also trigger the Parkinsons survey, when the task is done
        _protocol!.addTriggeredTask(
            UserTaskTrigger(
                taskName: parkinsonsTask.name,
                resumeCondition: UserTaskState.done),
            parkinsonsSurvey,
            phone);
      }
    }
    return _protocol;
  }
}
