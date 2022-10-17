part of carp_study_app;

/// The local [StudyProtocolManager].
///
/// This is used for loading the [StudyProtocol] from a local in-memory
/// Dart definition.
class LocalStudyProtocolManager implements StudyProtocolManager {
  SmartphoneStudyProtocol? _protocol;
  static const String VIDEO_TYPE = 'video';
  static const String IMAGE_TYPE = 'image';

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

  /// ALL SURVEYS STUDY (FOR TESTING)
  Future<SmartphoneStudyProtocol?> _getTestWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
        name: 'Wrist Angel: All surveys immediate triggered',
        ownerId: studyId,
      );

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

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol!.addMasterDevice(phone);

      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patient.title,
            description: surveys.patient.description,
            minutesToComplete: surveys.patient.minutesToComplete,
            expire: surveys.patient.expire,
            rpTask: surveys.patient.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patientParents.title,
            description: surveys.patientParents.description,
            minutesToComplete: surveys.patientParents.minutesToComplete,
            expire: surveys.patientParents.expire,
            rpTask: surveys.patientParents.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.control.title,
            description: surveys.control.description,
            minutesToComplete: surveys.control.minutesToComplete,
            expire: surveys.control.expire,
            rpTask: surveys.control.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.controlParents.title,
            description: surveys.controlParents.description,
            minutesToComplete: surveys.controlParents.minutesToComplete,
            expire: surveys.controlParents.expire,
            rpTask: surveys.controlParents.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecological.title,
            description: surveys.ecological.description,
            minutesToComplete: surveys.ecological.minutesToComplete,
            expire: surveys.ecological.expire,
            rpTask: surveys.ecological.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecologicalParents.title,
            description: surveys.ecologicalParents.description,
            minutesToComplete: surveys.ecologicalParents.minutesToComplete,
            expire: surveys.ecologicalParents.expire,
            rpTask: surveys.ecologicalParents.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
            rpTask: surveys.appUX.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.exposure.title,
            description: surveys.exposure.description,
            minutesToComplete: surveys.exposure.minutesToComplete,
            expire: surveys.exposure.expire,
            rpTask: surveys.exposure.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.informedConsent.title,
            description: surveys.informedConsent.description,
            minutesToComplete: surveys.informedConsent.minutesToComplete,
            expire: surveys.informedConsent.expire,
            rpTask: surveys.informedConsent.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyCoumpulsions.title,
            description: surveys.symptomHierarchyCoumpulsions.description,
            minutesToComplete:
                surveys.symptomHierarchyCoumpulsions.minutesToComplete,
            expire: surveys.symptomHierarchyCoumpulsions.expire,
            rpTask: surveys.symptomHierarchyCoumpulsions.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyObsessions.title,
            description: surveys.symptomHierarchyObsessions.description,
            minutesToComplete:
                surveys.symptomHierarchyObsessions.minutesToComplete,
            expire: surveys.symptomHierarchyObsessions.expire,
            rpTask: surveys.symptomHierarchyObsessions.survey,
          ),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.exposure.title",
            description: "audio.exposure.description",
            instructions: "audio.exposure.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(seconds: 15)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.biosensor.title",
            description: "audio.biosensor.description",
            instructions: "audio.biosensor.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
    }
    return _protocol;
  }

  Future<SmartphoneStudyProtocol?> _getPatientWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
        name: 'Wrist Angel: Patient (TEST with new triggers)',
        ownerId: studyId,
      );

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

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol!.addMasterDevice(phone);

      // Biosensor experience: collect wristband UX - triggers on week 7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patient.title,
            description: surveys.patient.description,
            minutesToComplete: surveys.patient.minutesToComplete,
            expire: surveys.patient.expire,
            rpTask: surveys.patient.survey,
          ),
          phone);

      /// collect exposure exercises - triggers daily
      _protocol!.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.daily, time: TimeOfDay(hour: 6, minute: 00)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.exposure.title,
            description: surveys.exposure.description,
            minutesToComplete: surveys.exposure.minutesToComplete,
            expire: surveys.exposure.expire,
            rpTask: surveys.exposure.survey,
          ),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling - triggers randomly
      _protocol!.addTriggeredTask(
          //ImmediateTrigger(),
          RandomRecurrentTrigger(
              maxNumberOfTriggers: 3,
              minNumberOfTriggers: 0,
              startTime: TimeOfDay(hour: 16, minute: 00),
              endTime: TimeOfDay(hour: 20, minute: 00)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecological.title,
            description: surveys.ecological.description,
            minutesToComplete: surveys.ecological.minutesToComplete,
            expire: surveys.ecological.expire,
            notification: true,
            rpTask: surveys.ecological.survey,
          ),
          phone);

      // collect symptoms hierarchy (obsessions) - triggers weekly
      _protocol!.addTriggeredTask(
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly,
              time: TimeOfDay(hour: 6, minute: 00),
              dayOfWeek: DateTime.monday),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyObsessions.title,
            description: surveys.symptomHierarchyObsessions.description,
            minutesToComplete:
                surveys.symptomHierarchyObsessions.minutesToComplete,
            expire: surveys.symptomHierarchyObsessions.expire,
            notification: true,
            rpTask: surveys.symptomHierarchyObsessions.survey,
          ),
          phone);

      // collect symptoms hierarchy (compulsions) - triggers weekly
      _protocol!.addTriggeredTask(
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly,
              time: TimeOfDay(hour: 6, minute: 00),
              dayOfWeek: DateTime.monday),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyCoumpulsions.title,
            description: surveys.symptomHierarchyCoumpulsions.description,
            minutesToComplete:
                surveys.symptomHierarchyCoumpulsions.minutesToComplete,
            expire: surveys.symptomHierarchyCoumpulsions.expire,
            notification: true,
            rpTask: surveys.symptomHierarchyCoumpulsions.survey,
          ),
          phone);

      // Audio task: Exposure exercise
      _protocol!.addTriggeredTask(
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.DAILY),
          // ),
          RecurrentScheduledTrigger(
              type: RecurrentType.daily, time: TimeOfDay(hour: 6, minute: 00)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.exposure.title",
            description: "audio.exposure.description",
            instructions: "audio.exposure.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);

      // Audio task: Wristband UX -  triggers on week 7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          // RecurrentScheduledTrigger(
          //     type: RecurrentType.weekly, time: Time(hour: 6, minute: 00), dayOfWeek: DateTime.monday),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.biosensor.title",
            description: "audio.biosensor.description",
            instructions: "audio.biosensor.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
    }

    return _protocol;
  }

  Future<SmartphoneStudyProtocol?> _getPatientParentsWristWatch(
      String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
        name: 'Wrist Angel: Patient Parent',
        ownerId: studyId,
      );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol!.addMasterDevice(phone);

      // collect app consent UX - triggers when the study starts - W0
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(minutes: 1)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.informedConsent.title,
            description: surveys.informedConsent.description,
            minutesToComplete: surveys.informedConsent.minutesToComplete,
            expire: surveys.informedConsent.expire,
            notification: true,
            rpTask: surveys.informedConsent.survey,
          ),
          phone);

      // collect trust scale - triggers on W8
      _protocol!.addTriggeredTask(
          //ImmediateTrigger(),
          ElapsedTimeTrigger(elapsedTime: Duration(days: 56)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.trustScale.title,
            description: surveys.trustScale.description,
            minutesToComplete: surveys.trustScale.minutesToComplete,
            expire: surveys.trustScale.expire,
            notification: true,
            rpTask: surveys.trustScale.survey,
          ),
          phone);

      // collect App UX (I) - triggers on W1
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 7)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
            notification: true,
            rpTask: surveys.appUX.survey,
          ),
          phone);

      // collect App UX (II) - triggers on W8
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 56)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
            notification: true,
            rpTask: surveys.appUX.survey,
          ),
          phone);

      // Biosensor experience: collect wristband UX - triggers W7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          // RecurrentScheduledTrigger(
          //     type: RecurrentType.daily, time: Time(hour: 6, minute: 00), dayOfWeek: DateTime.monday),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patientParents.title,
            description: surveys.patientParents.description,
            minutesToComplete: surveys.patientParents.minutesToComplete,
            expire: surveys.patientParents.expire,
            notification: true,
            rpTask: surveys.patientParents.survey,
          ),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling - triggers randomly between 6am-11pm
      _protocol!.addTriggeredTask(
          //ImmediateTrigger(),
          RandomRecurrentTrigger(
              maxNumberOfTriggers: 3,
              minNumberOfTriggers: 0,
              startTime: TimeOfDay(hour: 6, minute: 00),
              endTime: TimeOfDay(hour: 23, minute: 00)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecologicalParents.title,
            description: surveys.ecologicalParents.description,
            minutesToComplete: surveys.ecologicalParents.minutesToComplete,
            expire: surveys.ecologicalParents.expire,
            notification: true,
            rpTask: surveys.ecologicalParents.survey,
          ),
          phone);

      // Audio task: Wristband UX -  triggers on week 7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.biosensor.title",
            description: "audio.biosensor.description",
            instructions: "audio.biosensor.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
    }

    return _protocol;
  }

  Future<SmartphoneStudyProtocol?> _getControlWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
        name: 'Wrist Angel: Control',
        ownerId: studyId,
      );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol!.addMasterDevice(phone);

      // collect Biosensor experience: - triggers W7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //     time: TimeOfDay(hour: 6, minute: 00), recurrenceRule: RecurrenceRule(Frequency.WEEKLY)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.control.title,
            description: surveys.control.description,
            minutesToComplete: surveys.control.minutesToComplete,
            expire: surveys.control.expire,
            notification: true,
            rpTask: surveys.control.survey,
          ),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling - triggers randomly
      _protocol!.addTriggeredTask(
          //PeriodicTrigger(period: Duration(minutes: 5)),
          RandomRecurrentTrigger(
              maxNumberOfTriggers: 3,
              minNumberOfTriggers: 0,
              startTime: TimeOfDay(hour: 16, minute: 00),
              endTime: TimeOfDay(hour: 20, minute: 00)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecological.title,
            description: surveys.ecological.description,
            minutesToComplete: surveys.ecological.minutesToComplete,
            expire: surveys.ecological.expire,
            notification: true,
            rpTask: surveys.ecological.survey,
          ),
          phone);

      // Audio task: Wristband UX -  triggers on week 7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.biosensor.title",
            description: "audio.biosensor.description",
            instructions: "audio.biosensor.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
    }
    return _protocol;
  }

  Future<SmartphoneStudyProtocol?> _getControlParentWristWatch(
      String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
        name: 'Wrist Angel: Control Parents',
        ownerId: studyId,
      );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol!.addMasterDevice(phone);

      // collect informed consent once when the study starts - W0
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(minutes: 1)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.informedConsent.title,
            description: surveys.informedConsent.description,
            minutesToComplete: surveys.informedConsent.minutesToComplete,
            expire: surveys.informedConsent.expire,
            notification: true,
            rpTask: surveys.informedConsent.survey,
          ),
          phone);

      // collect trust scale - triggers on W7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.trustScale.title,
            description: surveys.trustScale.description,
            minutesToComplete: surveys.trustScale.minutesToComplete,
            expire: surveys.trustScale.expire,
            notification: true,
            rpTask: surveys.trustScale.survey,
          ),
          phone);

      // collect App UX (I) - triggers on W1
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 7)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
            notification: true,
            rpTask: surveys.appUX.survey,
          ),
          phone);

      // collect App UX (II) - triggers on W8
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 56)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
            notification: true,
            rpTask: surveys.appUX.survey,
          ),
          phone);

      // Biosensor experience: collect wristband UX - triggers w7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.controlParents.title,
            description: surveys.controlParents.description,
            minutesToComplete: surveys.controlParents.minutesToComplete,
            expire: surveys.controlParents.expire,
            notification: true,
            rpTask: surveys.controlParents.survey,
          ),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling.
      // Triggers randomly  between 6am-11pm
      _protocol!.addTriggeredTask(
          //ImmediateTrigger(),
          RandomRecurrentTrigger(
              maxNumberOfTriggers: 3,
              minNumberOfTriggers: 0,
              startTime: TimeOfDay(hour: 6, minute: 00),
              endTime: TimeOfDay(hour: 23, minute: 00)),
          RPAppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecologicalParents.title,
            description: surveys.ecologicalParents.description,
            minutesToComplete: surveys.ecologicalParents.minutesToComplete,
            expire: surveys.ecologicalParents.expire,
            notification: true,
            rpTask: surveys.ecologicalParents.survey,
          ),
          phone);

      // Audio task: Wristband UX -  triggers on week 7
      _protocol!.addTriggeredTask(
          ElapsedTimeTrigger(elapsedTime: Duration(days: 49)),
          // ScheduledTrigger(
          //   time: TimeOfDay(hour: 6, minute: 00),
          //   recurrenceRule: RecurrenceRule(Frequency.WEEKLY),
          // ),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "audio.biosensor.title",
            description: "audio.biosensor.description",
            instructions: "audio.biosensor.instructions",
            minutesToComplete: 5,
            notification: true,
          )..addMeasure(Measure(type: MediaSamplingPackage.AUDIO)),
          phone);
    }

    return _protocol;
  }

  Future<SmartphoneStudyProtocol?> _getGenericCARPStudy(String studyId) async {
    if (_protocol == null) {
      _protocol = SmartphoneStudyProtocol(
          ownerId: studyId,
          name: 'CARP Study App Demo Protocol',
          protocolDescription: StudyDescription(
              title: 'CARP Study App Technical Study',
              description:
                  "We would like to have you help in testing the technical stability and the usability of the CARP Mobile Sensing app. "
                  "Your data will be collected and store anonymously.",
              purpose:
                  'To investigate the technical stability and usability of the CARP Generic Study App.',
              responsible: StudyResponsible(
                id: 'jakba',
                name: 'Jakob E. Bardram',
                title: 'PhD, MSc',
                email: 'jakba@dtu.dk',
                affiliation: 'Technical University of Denmark',
                address: 'Ørsteds Plads, bygn. 349, DK-2800 Kg. Lyngby',
              )));

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol?.addMasterDevice(phone);

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

      AirQualityService airQualityService =
          AirQualityService(apiKey: '9e538456b2b85c92647d8b65090e29f957638c77');
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
          title: "Location, Weather & Air Quality",
          description: "Collect location, weather and air quality",
          measures: [
            Measure(type: ContextSamplingPackage.LOCATION),
            Measure(type: ContextSamplingPackage.WEATHER),
            Measure(type: ContextSamplingPackage.AIR_QUALITY),
          ]);

      var demographicsTask = RPAppTask(
          type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
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
          title: "Reading",
          description:
              'In this small exercise we would like to collect sound data while you are reading.',
          instructions: 'Please read the following text aloud.\n\n'
              'Many, many years ago lived an emperor, who thought so much of new clothes that he spent all his money in order to obtain them; his only ambition was to be always well dressed. '
              'He did not care for his soldiers, and the theatre did not amuse him; the only thing, in fact, he thought anything of was to drive out and show a new suit of clothes. '
              'He had a coat for every hour of the day; and as one would say of a king "He is in his cabinet," so one could say of him, "The emperor is in his dressing-room."',
          minutesToComplete: 3,
          measures: [
            Measure(type: MediaSamplingPackage.AUDIO),
            Measure(type: ContextSamplingPackage.LOCATION)
          ]);

      var coughingTask = AppTask(
          type: AudioUserTask.AUDIO_TYPE,
          title: "Coughing",
          description:
              'In this small exercise we would like to collect sound samples of coughing.',
          instructions: 'Please cough 5 times.',
          minutesToComplete: 1,
          measures: [
            Measure(type: MediaSamplingPackage.AUDIO),
            Measure(type: ContextSamplingPackage.LOCATION),
            Measure(type: ContextSamplingPackage.WEATHER),
            Measure(type: ContextSamplingPackage.AIR_QUALITY)
          ]);

      var imageTask = AppTask(
          type: IMAGE_TYPE,
          title: "Scars",
          description: "Take a picture of your scars",
          instructions: "Please take a picture of the scars in your skin",
          minutesToComplete: 3,
          measures: [Measure(type: MediaSamplingPackage.IMAGE)]);

      var videoTask = AppTask(
          type: VIDEO_TYPE,
          title: "Surrounding",
          description: "Take a video of your surroundings",
          instructions: "Please take a video of whatever is next to you",
          minutesToComplete: 3,
          notification: true,
          measures: [Measure(type: MediaSamplingPackage.VIDEO)]);

      // Then add all the tasks to the protocol to trigger once.

      _protocol!.addTriggeredTask(OneTimeTrigger(), environmentTask, phone);
      _protocol!.addTriggeredTask(OneTimeTrigger(), demographicsTask, phone);
      _protocol!.addTriggeredTask(OneTimeTrigger(), symptomsTask, phone);
      _protocol!.addTriggeredTask(OneTimeTrigger(), readingTask, phone);
      _protocol!.addTriggeredTask(OneTimeTrigger(), coughingTask, phone);
      _protocol!.addTriggeredTask(OneTimeTrigger(), imageTask, phone);

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
              taskName: symptomsTask.name, resumeCondition: UserTaskState.done),
          symptomsTask,
          phone);

      _protocol!.addTriggeredTask(
          UserTaskTrigger(
              taskName: readingTask.name, resumeCondition: UserTaskState.done),
          readingTask,
          phone);

      _protocol!.addTriggeredTask(
          UserTaskTrigger(
              taskName: coughingTask.name, resumeCondition: UserTaskState.done),
          coughingTask,
          phone);

      _protocol!.addTriggeredTask(
          UserTaskTrigger(
              taskName: imageTask.name, resumeCondition: UserTaskState.done),
          imageTask,
          phone);
    }

    return _protocol;
  }
}
