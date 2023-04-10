part of carp_study_app;

/// The local [StudyProtocolManager].
///
/// This is used for loading the [StudyProtocol] from a local in-memory
/// Dart definition.
class LocalStudyProtocolManager implements StudyProtocolManager {
  @override
  Future initialize() async {}

  @override
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String studyId) async {
    var protocol = demoStudy;

    // set the data endpoint based on the deployment mode (local or CARP)
    protocol.dataEndPoint = (bloc.deploymentMode == DeploymentMode.playground)
        ? SQLiteDataEndPoint()
        : CarpDataEndPoint(
            uploadMethod: CarpUploadMethod.datapoint,
          );

    return protocol;
  }

  @override
  Future<bool> saveStudyProtocol(
      String studyId, SmartphoneStudyProtocol protocol) async {
    throw UnimplementedError();
  }

  SmartphoneStudyProtocol get demoStudy {
    var protocol = SmartphoneStudyProtocol(
      name: 'CARP Study App Demo Protocol',
      ownerId: 'john_doe',
    );

    // add the localized description
    protocol.studyDescription = StudyDescription(
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

    // always add a participant role to the protocol
    protocol.participantRoles?.add(ParticipantRole('Participant', false));

    // Define which devices are used for data collection.
    Smartphone phone = Smartphone();

    var eSense = ESenseDevice();

    var polar = PolarDevice();

    protocol.addPrimaryDevice(phone);
    protocol.addConnectedDevice(eSense, phone);
    protocol.addConnectedDevice(polar, phone);

    // ONLINE SERVICES

    // Define online services and add them as connected 'devices'
    LocationService locationService = LocationService();
    protocol.addConnectedDevice(locationService, phone);

    WeatherService weatherService =
        WeatherService(apiKey: '12b6e28582eb9298577c734a31ba9f4f');
    protocol.addConnectedDevice(weatherService, phone);

    AirQualityService airQualityService =
        AirQualityService(apiKey: '9e538456b2b85c92647d8b65090e29f957638c77');
    protocol.addConnectedDevice(airQualityService, phone);

    // BACKGROUND SENSING

    protocol.addTaskControl(
        ImmediateTrigger(),
        BackgroundTask(measures: [
          Measure(type: SensorSamplingPackage.AMBIENT_LIGHT),
          Measure(type: SensorSamplingPackage.STEP_COUNT),
          Measure(type: DeviceSamplingPackage.FREE_MEMORY),
          Measure(type: DeviceSamplingPackage.DEVICE_INFORMATION),
          Measure(type: DeviceSamplingPackage.BATTERY_STATE),
          Measure(type: DeviceSamplingPackage.SCREEN_EVENT),
          Measure(type: ContextSamplingPackage.ACTIVITY),
        ]),
        phone);

    // a background task that collects location on a regular basis
    // using the location service
    protocol.addTaskControl(
        PeriodicTrigger(period: const Duration(minutes: 5)),
        BackgroundTask(
            measures: [Measure(type: ContextSamplingPackage.LOCATION)]),
        locationService);

    // a background task that continuously collects geo location and mobility
    // using the location service
    protocol.addTaskControl(
        ImmediateTrigger(),
        BackgroundTask(measures: [
          //Measure(type: ContextSamplingPackage.GEOLOCATION),
          Measure(type: ContextSamplingPackage.MOBILITY),
        ]),
        locationService);

    // a background task that collects weather every 30 minutes.
    // using the weather service
    protocol.addTaskControl(
        PeriodicTrigger(period: const Duration(minutes: 30)),
        BackgroundTask()
          ..addMeasure(Measure(type: ContextSamplingPackage.WEATHER)),
        weatherService);

    // a background task that air quality every 30 minutes.
    // using the air quality service
    protocol.addTaskControl(
        PeriodicTrigger(period: const Duration(minutes: 30)),
        BackgroundTask()
          ..addMeasure(Measure(type: ContextSamplingPackage.AIR_QUALITY)),
        airQualityService);

    // WEARABLE DEVICES

    // eSense
    protocol.addTaskControl(
        ImmediateTrigger(),
        BackgroundTask(measures: [
          Measure(type: ESenseSamplingPackage.ESENSE_BUTTON),
          Measure(type: ESenseSamplingPackage.ESENSE_SENSOR),
        ]),
        eSense);

    // Polar
    protocol.addTaskControl(
        ImmediateTrigger(),
        BackgroundTask(measures: [
          Measure(type: PolarSamplingPackage.HR),
          Measure(type: PolarSamplingPackage.ECG)
        ]),
        polar);

    // APP TASKS

    // Now creating a set of app tasks which are repeatedly added to the task
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
        type: AudioUserTask.audioType,
        title: "reading.title",
        description: 'reading.description',
        instructions: 'reading.instructions',
        minutesToComplete: 3,
        measures: [
          Measure(type: MediaSamplingPackage.AUDIO),
          Measure(type: ContextSamplingPackage.LOCATION)
        ]);

    var imageTask = AppTask(
        type: VideoUserTask.imageType,
        title: "wound.title",
        description: "wound.description",
        instructions: "wound.instructions",
        minutesToComplete: 3,
        measures: [Measure(type: MediaSamplingPackage.IMAGE)]);

    var parkinsonsTask = RPAppTask(
        type: SurveyUserTask.COGNITIVE_ASSESSMENT_TYPE,
        title: "parkinsons.title",
        description: "parkinsons.description",
        minutesToComplete: 3,
        rpTask: RPOrderedTask(
          identifier: "parkinsons_assessment",
          steps: [
            RPInstructionStep(
                identifier: 'parkinsons_instruction',
                title: "parkinsons.instructions.title",
                text: "parkinsons.instructions.text"),
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
          Measure(type: SensorSamplingPackage.ACCELERATION),
          Measure(type: SensorSamplingPackage.ROTATION),
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

    // Second, add all the tasks to the protocol to trigger once.

    protocol.addTaskControl(OneTimeTrigger(), environmentTask, phone);
    protocol.addTaskControl(OneTimeTrigger(), demographicsTask, phone);
    protocol.addTaskControl(OneTimeTrigger(), symptomsTask, phone);
    protocol.addTaskControl(OneTimeTrigger(), readingTask, phone);
    protocol.addTaskControl(OneTimeTrigger(), imageTask, phone);
    protocol.addTaskControl(OneTimeTrigger(), parkinsonsTask, phone);

    // Third, add a set of user task triggers to make sure that the
    // task are added to the queue again when done

    protocol.addTaskControl(
        UserTaskTrigger(
            taskName: environmentTask.name,
            triggerCondition: UserTaskState.done),
        environmentTask,
        phone);

    protocol.addTaskControl(
        UserTaskTrigger(
            taskName: demographicsTask.name,
            triggerCondition: UserTaskState.done),
        demographicsTask,
        phone);

    protocol.addTaskControl(
        UserTaskTrigger(
          taskName: symptomsTask.name,
          triggerCondition: UserTaskState.done,
        ),
        symptomsTask,
        phone);

    protocol.addTaskControl(
        UserTaskTrigger(
          taskName: readingTask.name,
          triggerCondition: UserTaskState.done,
        ),
        readingTask,
        phone);

    protocol.addTaskControl(
        UserTaskTrigger(
          taskName: imageTask.name,
          triggerCondition: UserTaskState.done,
        ),
        imageTask,
        phone);

    protocol.addTaskControl(
        UserTaskTrigger(
          taskName: parkinsonsTask.name,
          triggerCondition: UserTaskState.done,
        ),
        parkinsonsTask,
        phone);

    // Fourth, also trigger the Parkinson's survey, when the task is done
    protocol.addTaskControl(
        UserTaskTrigger(
          taskName: parkinsonsTask.name,
          triggerCondition: UserTaskState.done,
        ),
        parkinsonsSurvey,
        phone);

    return protocol;
  }
}
