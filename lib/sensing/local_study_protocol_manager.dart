part of carp_study_app;

/// The local [StudyProtocolManager].
///
/// This is used for loading the [StudyProtocol] from a local in-memory
/// Dart definition.
/// Later, this protocol is to be downloaded from the CARP web service,
/// using a [CARPStudyProtocolManager].
class LocalStudyProtocolManager implements StudyProtocolManager {
  CAMSStudyProtocol _protocol;

  Future initialize() async {}

  Future<bool> saveStudyProtocol(String studyId, StudyProtocol protocol) async {
    throw UnimplementedError();
  }

  /// Create a new CAMS study protocol.
  Future<StudyProtocol> getStudyProtocol(String ignored) async =>
      _protocol ??= await _getPatientWristWatch(ignored);

  Future<StudyProtocol> _getPatientWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = CAMSStudyProtocol()
        ..name = 'Wrist Angel: Patient'
        ..studyId = studyId
        ..description = 'Protocol testing for patients'
        ..protocolDescription = StudyProtocolDescription(
          title: "Wrist Angel: A Wearable AI Feedback Tool for OCD Treatment and Research",
          purpose:
              "We aim to improve assessment and psychotherapy for pediatric obsessive-compulsive disorder (OCD).",
          description:
              "Hormone levels, measured in saliva, and physiological indicators of stress from children and parents are used as input to privacy preserving signal processing and machine learning algorithms. Signal processing will be used to extract acoustic and physiological features of importance for therapeutic response. The study includes children with an OCD diagnosis and children without a psychiatric diagnosis and their parents.",
        )
        ..responsible = StudyProtocolReponsible(
          name:
              "Professor Anne Katrine Pagsberg1, Associate Professor Line Katrine Harder Clemmensen2 and Senior Researcher Nicole Nadine Lønfeldt",
          title: ' ',
          email: 'nicole.nadine.loenfeldt@regionh.dk',
          affiliation:
              'Børne- og Ungdomspsykiatrisk Center – Forskningsenheden, Region Hovedstadens Psykiatri\nDTU Compute',
          address: 'Gentoftehospitalsvej 28, 2900 Hellerup',
        );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol.addMasterDevice(phone);

      // Biosensor experience: collect wristband UX - triggers on week 7 (TODO)
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patient.title,
            description: surveys.patient.description,
            minutesToComplete: surveys.patient.minutesToComplete,
            expire: surveys.patient.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.patient.title,
              enabled: true,
              surveyTask: surveys.patient.survey,
            )),
          phone);

      /// collect exposure exercises - triggers daily
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(type: RecurrentType.daily, time: Time(hour: 7, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.exposure.title,
            description: surveys.exposure.description,
            minutesToComplete: surveys.exposure.minutesToComplete,
            expire: surveys.exposure.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.exposure.title,
              enabled: true,
              surveyTask: surveys.exposure.survey,
            )),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling - triggers randomly  - TODO: use random trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecological.title,
            description: surveys.ecological.description,
            minutesToComplete: surveys.ecological.minutesToComplete,
            expire: surveys.ecological.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.ecological.title,
              enabled: true,
              surveyTask: surveys.ecological.survey,
            )),
          phone);

      // collect symptoms hierarchy (obsessions)
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyObsessions.title,
            description: surveys.symptomHierarchyObsessions.description,
            minutesToComplete: surveys.symptomHierarchyObsessions.minutesToComplete,
            expire: surveys.symptomHierarchyObsessions.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.symptomHierarchyObsessions.title,
              enabled: true,
              surveyTask: surveys.symptomHierarchyObsessions.survey,
            )),
          phone);

      // collect symptoms hierarchy (compulsions)
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptomHierarchyCoumpulsions.title,
            description: surveys.symptomHierarchyCoumpulsions.description,
            minutesToComplete: surveys.symptomHierarchyCoumpulsions.minutesToComplete,
            expire: surveys.symptomHierarchyCoumpulsions.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.symptomHierarchyCoumpulsions.title,
              enabled: true,
              surveyTask: surveys.symptomHierarchyCoumpulsions.survey,
            )),
          phone);

      // Audio task: Exposure exercise
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(type: RecurrentType.daily, time: Time(hour: 7, minute: 00)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "Exposure exercise",
            description: 'Describe the exposure exercise you are working on',
            instructions: 'Describe the exposure exercise: how will you work on the obsession or compulsion?',
            minutesToComplete: 5,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "Exposure exercise",
            )),
          phone);

      // Audio task: Wristband UX -  triggers on week 7 (TODO)
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "User Experience with the Wristband",
            description: 'Record yourself talking about how the wristband makes you feel',
            instructions: 'Tell us about your experience wearing the wristband',
            minutesToComplete: 5,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "User Experience with the Wristband",
            )),
          phone);
    }

    return _protocol;
  }

  Future<StudyProtocol> _getPatientParentsWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = CAMSStudyProtocol()
        ..name = 'Wrist Angel'
        ..protocolDescription = StudyProtocolDescription(
          title: "Wrist Angel: A Wearable AI Feedback Tool for OCD Treatment and Research",
          purpose:
              "We aim to improve assessment and psychotherapy for pediatric obsessive-compulsive disorder (OCD).",
          description:
              "Hormone levels, measured in saliva, and physiological indicators of stress from children and parents are used as input to privacy preserving signal processing and machine learning algorithms. Signal processing will be used to extract acoustic and physiological features of importance for therapeutic response. The study includes children with an OCD diagnosis and children without a psychiatric diagnosis and their parents.",
        )
        ..responsible = StudyProtocolReponsible(
          name:
              "Professor Anne Katrine Pagsberg1, Associate Professor Line Katrine Harder Clemmensen2 and Senior Researcher Nicole Nadine Lønfeldt1",
          title: '',
          email: 'nicole.nadine.loenfeldt@regionh.dk',
          affiliation:
              'Børne- og Ungdomspsykiatrisk Center – Forskningsenheden, Region Hovedstadens Psykiatri\nDTU Compute',
          address: 'Gentoftehospitalsvej 28, 2900 Hellerup',
        );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol.addMasterDevice(phone);

      // collect informed consent once when the study starts - W0
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.informedConsent.title,
            description: surveys.informedConsent.description,
            minutesToComplete: surveys.informedConsent.minutesToComplete,
            expire: surveys.informedConsent.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.informedConsent.title,
              enabled: true,
              surveyTask: surveys.informedConsent.survey,
            )),
          phone);

      // collect trust scale - triggers on W4 (TODO: use scheduled trigger)
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.trustScale.title,
            description: surveys.trustScale.description,
            minutesToComplete: surveys.trustScale.minutesToComplete,
            expire: surveys.trustScale.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.trustScale.title,
              enabled: true,
              surveyTask: surveys.trustScale.survey,
            )),
          phone);

      // collect App UX - triggers on W1, W8 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.appUX.title,
              enabled: true,
              surveyTask: surveys.appUX.survey,
            )),
          phone);

      // Biosensor experience: collect wristband UX - triggers W7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.patientParents.title,
            description: surveys.patientParents.description,
            minutesToComplete: surveys.patientParents.minutesToComplete,
            expire: surveys.patientParents.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.patientParents.title,
              enabled: true,
              surveyTask: surveys.patientParents.survey,
            )),
          phone);

      // Ecological Momentary Assesment: collect how are you feeling - triggers randomly  - TODO: use random trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecologicalParents.title,
            description: surveys.ecologicalParents.description,
            minutesToComplete: surveys.ecologicalParents.minutesToComplete,
            expire: surveys.ecologicalParents.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.ecologicalParents.title,
              enabled: true,
              surveyTask: surveys.ecologicalParents.survey,
            )),
          phone);

      // Audio task: Wristband UX - triggers W7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(days: 7)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "User Experience with the Wristband",
            description: "Record yourself talking about how the wristband makes you feel",
            instructions: "Tell us about your experience wearing the wristband",
            minutesToComplete: 5,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "User Experience with the Wristband",
            )),
          phone);
    }

    return _protocol;
  }

  Future<StudyProtocol> _getControlWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = CAMSStudyProtocol()
        ..name = 'Wrist Angel'
        ..protocolDescription = StudyProtocolDescription(
          title: "Wrist Angel: A Wearable AI Feedback Tool for OCD Treatment and Research",
          purpose:
              "We aim to improve assessment and psychotherapy for pediatric obsessive-compulsive disorder (OCD).",
          description:
              "Hormone levels, measured in saliva, and physiological indicators of stress from children and parents are used as input to privacy preserving signal processing and machine learning algorithms. Signal processing will be used to extract acoustic and physiological features of importance for therapeutic response. The study includes children with an OCD diagnosis and children without a psychiatric diagnosis and their parents.",
        )
        ..responsible = StudyProtocolReponsible(
          name:
              "Professor Anne Katrine Pagsberg1, Associate Professor Line Katrine Harder Clemmensen2 and Senior Researcher Nicole Nadine Lønfeldt1",
          title: '',
          email: 'nicole.nadine.loenfeldt@regionh.dk',
          affiliation:
              'Børne- og Ungdomspsykiatrisk Center – Forskningsenheden, Region Hovedstadens Psykiatri\nDTU Compute',
          address: 'Gentoftehospitalsvej 28, 2900 Hellerup',
        );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol.addMasterDevice(phone);

      // collect wristband UX - - triggers W7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.control.title,
            description: surveys.control.description,
            minutesToComplete: surveys.control.minutesToComplete,
            expire: surveys.control.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.control.title,
              enabled: true,
              surveyTask: surveys.control.survey,
            )),
          phone);

      // collect how are you feeling - triggers randomly  - TODO: use random trigger
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(minutes: 5)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecological.title,
            description: surveys.ecological.description,
            minutesToComplete: surveys.ecological.minutesToComplete,
            expire: surveys.ecological.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.ecological.title,
              enabled: true,
              surveyTask: surveys.ecological.survey,
            )),
          phone);

      // Audio task: Wristband UX - triggers W7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(days: 7)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "User Experience with the Wristband",
            description: 'Record yourself talking about how the wristband makes you feel',
            instructions: 'Tell us about your experience wearing the wristband',
            minutesToComplete: 5,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "User Experience with the Wristband",
            )),
          phone);
    }
    return _protocol;
  }

  Future<StudyProtocol> _getControlParentWristWatch(String studyId) async {
    if (_protocol == null) {
      _protocol = CAMSStudyProtocol()
        ..name = 'Wrist Angel'
        ..protocolDescription = StudyProtocolDescription(
          title: "Wrist Angel: A Wearable AI Feedback Tool for OCD Treatment and Research",
          purpose:
              "We aim to improve assessment and psychotherapy for pediatric obsessive-compulsive disorder (OCD).",
          description:
              "Hormone levels, measured in saliva, and physiological indicators of stress from children and parents are used as input to privacy preserving signal processing and machine learning algorithms. Signal processing will be used to extract acoustic and physiological features of importance for therapeutic response. The study includes children with an OCD diagnosis and children without a psychiatric diagnosis and their parents.",
        )
        ..responsible = StudyProtocolReponsible(
          name:
              "Professor Anne Katrine Pagsberg1, Associate Professor Line Katrine Harder Clemmensen2 and Senior Researcher Nicole Nadine Lønfeldt1",
          title: '',
          email: 'nicole.nadine.loenfeldt@regionh.dk',
          affiliation:
              'Børne- og Ungdomspsykiatrisk Center – Forskningsenheden, Region Hovedstadens Psykiatri\nDTU Compute',
          address: 'Gentoftehospitalsvej 28, 2900 Hellerup',
        );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol.addMasterDevice(phone);

      // collect informed consent once when the study starts - W0
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.informedConsent.title,
            description: surveys.informedConsent.description,
            minutesToComplete: surveys.informedConsent.minutesToComplete,
            expire: surveys.informedConsent.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.informedConsent.title,
              enabled: true,
              surveyTask: surveys.informedConsent.survey,
            )),
          phone);

      // collect trust scale - triggers on W4 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.trustScale.title,
            description: surveys.trustScale.description,
            minutesToComplete: surveys.trustScale.minutesToComplete,
            expire: surveys.trustScale.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.trustScale.title,
              enabled: true,
              surveyTask: surveys.trustScale.survey,
            )),
          phone);

      // collect App UX - triggers on W1, W8 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.appUX.title,
            description: surveys.appUX.description,
            minutesToComplete: surveys.appUX.minutesToComplete,
            expire: surveys.appUX.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.appUX.title,
              enabled: true,
              surveyTask: surveys.appUX.survey,
            )),
          phone);

      // Biosensor experience: collect wristband UX - triggers w7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          RecurrentScheduledTrigger(
              type: RecurrentType.weekly, dayOfWeek: DateTime.sunday, time: Time(hour: 8, minute: 00)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.controlParents.title,
            description: surveys.controlParents.description,
            minutesToComplete: surveys.controlParents.minutesToComplete,
            expire: surveys.controlParents.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.controlParents.title,
              enabled: true,
              surveyTask: surveys.controlParents.survey,
            )),
          phone);

      // collect how are you feeling - triggers randomly  - TODO: use random trigger
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.ecologicalParents.title,
            description: surveys.ecologicalParents.description,
            minutesToComplete: surveys.ecologicalParents.minutesToComplete,
            expire: surveys.ecologicalParents.expire,
          )..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.ecologicalParents.title,
              enabled: true,
              surveyTask: surveys.ecologicalParents.survey,
            )),
          phone);

      // Audio task: Wristband UX - triggers w7 - TODO: use scheduled trigger
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(days: 7)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "User Experience with the Wristband",
            description: 'Record yourself talking about how the wristband makes you feel',
            instructions: 'Tell us about your experience wearing the wristband',
            minutesToComplete: 5,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "User Experience with the Wristband",
            )),
          phone);
    }

    return _protocol;
  }

  // GENERIC STUDY FOR TESTING
  // Future<Study> _getWristWatchStudy(String studyId) async {
  //   if (_study == null) {
  //     _study = Study(id: studyId, userId: await settings.userId)
  //       ..name = 'Wrist Angel'
  //       ..title =
  //           "Wrist Angel: A Wearable AI Feedback Tool for OCD Treatment and Research"
  //       ..purpose =
  //           "We aim to improve assessment and psychotherapy for pediatric obsessive-compulsive disorder (OCD)."
  //       ..pi = PrincipalInvestigator(
  //         name:
  //             "Professor Anne Katrine Pagsberg1, Associate Professor Line Katrine Harder Clemmensen2 and Senior Researcher Nicole Nadine Lønfeldt1",
  //         title: '',
  //         email: 'nicole.nadine.loenfeldt@regionh.dk',
  //         affiliation:
  //             'Børne - og Ungdomspsykiatrisk Center – Forskningsenheden, Region Hovedstadens Psykiatri\nDTU Compute',
  //         address: 'Gentoftehospitalsvej 28, 2900 Hellerup',
  //       )
  //       ..description =
  //           "Hormone levels, measured in saliva, and physiological indicators of stress from children and parents are used as input to privacy preserving signal processing and machine learning algorithms. Signal processing will be used to extract acoustic and physiological features of importance for therapeutic response. The study includes children with an OCD diagnosis and children without a psychiatric diagnosis and their parents."
  //       ..dataEndPoint = getDataEndpoint(DataEndPointTypes.FILE)
  //       // Audio task: Wristband UX - TODO: TRIGGER AFTER CHECKING RESULT FROM SURVEY
  //       ..addTriggerTask(
  //           PeriodicTrigger(period: Duration(days: 7)),
  //           AppTask(
  //             type: AudioUserTask.AUDIO_TYPE,
  //             title: "User Experience: wristband",
  //             description:
  //                 'Record yourself talking about how the wristband makes you feel',
  //             instructions:
  //                 'Tell us about your experience wearing the wristband',
  //             minutesToComplete: 5,
  //           )..measures.add(AudioMeasure(
  //               type: MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
  //               name: "UX_wristband",
  //               studyId: studyId,
  //             )))
  //       // Audio task: Exposure exercise - TODO: TRIGGER AFTER CHECKING RESULT FROM SURVEY
  //       ..addTriggerTask(
  //           PeriodicTrigger(period: Duration(days: 7)),
  //           AppTask(
  //             type: AudioUserTask.AUDIO_TYPE,
  //             title: "Exposure exercise",
  //             description: 'Describe the exposure exercise you are working on',
  //             instructions:
  //                 'Describe the exposure exercise: how will you work on the obsession or compulsion?',
  //             minutesToComplete: 5,
  //           )..measures.add(AudioMeasure(
  //               type: MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
  //               name: "Exposure_exercise_description",
  //               studyId: studyId,
  //             )))

  //       /////////////////////////////////////////////////////////////////
  //       /// Depending on the user, show only 1 of this next 4 surveys ///
  //       /////////////////////////////////////////////////////////////////
  //       ..addTriggerTask(
  //           RecurrentScheduledTrigger(
  //               type: RecurrentType.weekly,
  //               dayOfWeek: DateTime.sunday,
  //               time: Time(hour: 8, minute: 00)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.control.title,
  //             description: surveys.control.description,
  //             minutesToComplete: surveys.control.minutesToComplete,
  //             expire: surveys.control.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.control.title,
  //               enabled: true,
  //               surveyTask: surveys.control.survey,
  //             )))
  //       ..addTriggerTask(
  //           PeriodicTrigger(period: Duration(days: 1)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.controlParents.title,
  //             description: surveys.controlParents.description,
  //             minutesToComplete: surveys.controlParents.minutesToComplete,
  //             expire: surveys.controlParents.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.controlParents.title,
  //               enabled: true,
  //               surveyTask: surveys.controlParents.survey,
  //             )))
  //       ..addTriggerTask(
  //           RecurrentScheduledTrigger(
  //               type: RecurrentType.weekly,
  //               dayOfWeek: DateTime.sunday,
  //               time: Time(hour: 8, minute: 00)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.patient.title,
  //             description: surveys.patient.description,
  //             minutesToComplete: surveys.patient.minutesToComplete,
  //             expire: surveys.patient.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.patient.title,
  //               enabled: true,
  //               surveyTask: surveys.patient.survey,
  //             )))
  //       ..addTriggerTask(
  //           RecurrentScheduledTrigger(
  //               type: RecurrentType.weekly,
  //               dayOfWeek: DateTime.sunday,
  //               time: Time(hour: 8, minute: 00)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.patientParents.title,
  //             description: surveys.patientParents.description,
  //             minutesToComplete: surveys.patientParents.minutesToComplete,
  //             expire: surveys.patientParents.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.patientParents.title,
  //               enabled: true,
  //               surveyTask: surveys.patientParents.survey,
  //             )))

  //       /// EXPOSURE at least 1/day
  //       ..addTriggerTask(
  //           PeriodicTrigger(period: Duration(minutes: 5)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.exposure.title,
  //             description: surveys.exposure.description,
  //             minutesToComplete: surveys.exposure.minutesToComplete,
  //             expire: surveys.exposure.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.exposure.title,
  //               enabled: true,
  //               surveyTask: surveys.exposure.survey,
  //             )))
  //       ..addTriggerTask(
  //           RandomRecurrentTrigger(
  //               startTime: Time(hour: 16, minute: 00),
  //               endTime: Time(hour: 22, minute: 00),
  //               minNumberOfSampling: 0,
  //               maxNumberOfSampling: 3),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.ecological.title,
  //             description: surveys.ecological.description,
  //             minutesToComplete: surveys.ecological.minutesToComplete,
  //             expire: surveys.ecological.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.ecological.title,
  //               enabled: true,
  //               surveyTask: surveys.ecological.survey,
  //             )))

  //       /// UX APP- TODO get datetimes for end of week 1, half of week 4 and beginning of week 8, create one for each
  //       ..addTriggerTask(
  //           PeriodicTrigger(period: Duration(minutes: 5)),
  //           //ScheduledTrigger(schedule: DateTime(2021, 3, 27, 08, 30), duration: Duration(days: 10)),
  //           AppTask(
  //             type: SurveyUserTask.SURVEY_TYPE,
  //             title: surveys.appUX.title,
  //             description: surveys.appUX.description,
  //             minutesToComplete: surveys.appUX.minutesToComplete,
  //             expire: surveys.appUX.expire,
  //           )..measures.add(RPTaskMeasure(
  //               type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
  //               name: surveys.appUX.title,
  //               enabled: true,
  //               surveyTask: surveys.appUX.survey,
  //             )));
  //   }

  //   return _study;
  // }

  Future<StudyProtocol> _getGenericCARPStudy(String studyId) async {
    if (_protocol == null) {
      _protocol = CAMSStudyProtocol()
        ..studyId = studyId
        ..name = 'CARP Study App 2nd Protocol'
        ..description = 'A super generic 2nd protocol testing different parts of the CAMS Study App.'
        ..protocolDescription = StudyProtocolDescription(
          title: 'CARP Study App Feasibility Study',
          purpose: 'To investigate the technical stability and usability of the CARP Generic Study App.',
          description:
              "We would like to have you help in testing the technical stability and the usability of the CARP Mobile Sensing app. "
              "Your data will be collected and store anonymously.",
        )
        ..responsible = StudyProtocolReponsible(
          name: 'Jakob E. Bardram',
          title: 'PhD, MSc',
          email: 'jakba@dtu.dk',
          affiliation: 'Technical University of Denmark',
          address: 'Ørsteds Plads, bygn. 349, DK-2800 Kg. Lyngby',
        );

      // Define which devices are used for data collection.
      Smartphone phone = Smartphone();
      _protocol.addMasterDevice(phone);

      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AutomaticTask()
            ..measures = SamplingPackageRegistry().common().getMeasureList(
              types: [
                SensorSamplingPackage.LIGHT,
                SensorSamplingPackage.PEDOMETER,
                DeviceSamplingPackage.MEMORY,
                DeviceSamplingPackage.DEVICE,
                DeviceSamplingPackage.BATTERY,
                DeviceSamplingPackage.SCREEN,
              ],
            ),
          phone);

      // collect location, weather and air quality every 5 minutes
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(minutes: 5)),
          AutomaticTask()
            ..measures = SamplingPackageRegistry().common().getMeasureList(
              types: [
                ContextSamplingPackage.LOCATION,
                ContextSamplingPackage.WEATHER,
                ContextSamplingPackage.AIR_QUALITY,
              ],
            ),
          phone);

      // collect location, activity, mobility measures continously (event-based)
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AutomaticTask()
            ..measures = SamplingPackageRegistry().common().getMeasureList(
              types: [
                ContextSamplingPackage.GEOLOCATION,
                ContextSamplingPackage.ACTIVITY,
                ContextSamplingPackage.MOBILITY,
              ],
            ),
          phone);

      // collect local weather and air quality as an app task
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SensingUserTask.ONE_TIME_SENSING_TYPE,
            title: "Weather & Air Quality",
            description: "Collect local weather and air quality",
          )..measures = SamplingPackageRegistry().common().getMeasureList(
              types: [
                ContextSamplingPackage.WEATHER,
                ContextSamplingPackage.AIR_QUALITY,
              ],
            ),
          phone);

      // collect demographics once when the study starts
      _protocol.addTriggeredTask(
          ImmediateTrigger(),
          AppTask(
            type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
            title: surveys.demographics.title,
            description: surveys.demographics.description,
            minutesToComplete: surveys.demographics.minutesToComplete,
            expire: surveys.demographics.expire,
          )
            ..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.demographics.title,
              enabled: true,
              surveyTask: surveys.demographics.survey,
            ))
            ..measures.add(SamplingPackageRegistry().common().measures[ContextSamplingPackage.LOCATION]),
          phone);

      // collect symptoms on a daily basis
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(days: 1)),
          AppTask(
            type: SurveyUserTask.SURVEY_TYPE,
            title: surveys.symptoms.title,
            description: surveys.symptoms.description,
            minutesToComplete: surveys.symptoms.minutesToComplete,
            expire: surveys.symptoms.expire,
          )
            ..measures.add(RPTaskMeasure(
              type: SurveySamplingPackage.SURVEY,
              name: surveys.symptoms.title,
              enabled: true,
              surveyTask: surveys.symptoms.survey,
            ))
            ..measures.add(SamplingPackageRegistry().common().measures[ContextSamplingPackage.LOCATION]),
          phone);

      // collect a coughing sample on a daily basis
      // also collect location, and local weather and air quality of this sample
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(minutes: 1)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "Coughing",
            description: 'In this small exercise we would like to collect sound samples of coughing.',
            instructions: 'Please cough 5 times.',
            minutesToComplete: 1,
          )
            ..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "Coughing",
            ))
            ..measures.add(SamplingPackageRegistry().common().measures[ContextSamplingPackage.LOCATION])
            ..measures.add(SamplingPackageRegistry().common().measures[ContextSamplingPackage.WEATHER])
            ..measures.add(SamplingPackageRegistry().common().measures[ContextSamplingPackage.AIR_QUALITY]),
          phone);

      // collect a reading / audio sample on a daily basis
      _protocol.addTriggeredTask(
          PeriodicTrigger(period: Duration(minutes: 1)),
          AppTask(
            type: AudioUserTask.AUDIO_TYPE,
            title: "Reading",
            description: 'In this small exercise we would like to collect sound data while you are reading.',
            instructions: 'Please read the following text aloud.\n\n'
                'Many, many years ago lived an emperor, who thought so much of new clothes that he spent all his money in order to obtain them; his only ambition was to be always well dressed. '
                'He did not care for his soldiers, and the theatre did not amuse him; the only thing, in fact, he thought anything of was to drive out and show a new suit of clothes. '
                'He had a coat for every hour of the day; and as one would say of a king "He is in his cabinet," so one could say of him, "The emperor is in his dressing-room."',
            minutesToComplete: 3,
          )..measures.add(CAMSMeasure(
              type: AudioSamplingPackage.AUDIO,
              name: "Reading",
            )),
          phone);

      // when the reading (audio) measure is collected, the add a user task to
      // collect location, and local weather and air quality
      _protocol.addTriggeredTask(
          ConditionalSamplingEventTrigger(
            measureType: AudioSamplingPackage.AUDIO,
            resumeCondition: (DataPoint dataPoint) => true,
            pauseCondition: (DataPoint dataPoint) => true,
          ),
          AppTask(
            type: SensingUserTask.ONE_TIME_SENSING_TYPE,
            title: "Location, Weather & Air Quality",
            description: "Collect location, weather and air quality",
          )..measures = SamplingPackageRegistry().common().getMeasureList(
              types: [
                ContextSamplingPackage.LOCATION,
                ContextSamplingPackage.WEATHER,
                ContextSamplingPackage.AIR_QUALITY,
              ],
            ),
          phone);
    }

    return _protocol;
  }

//   Future<Study> _getConditionalStudy(String studyId) async {
//     if (_study == null) {
//       _study = Study(id: studyId, userId: await settings.userId)
//             ..name = 'Conditional Monitor'
//             ..description = 'This is a test study.'
//             ..dataEndPoint = getDataEndpoint(DataEndPointTypes.FILE)
//             ..addTriggerTask(
//                 ConditionalSamplingEventTrigger(
//                   measureType:
//                       MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
//                   resumeCondition: (Datum datum) => true,
//                   pauseCondition: (Datum datum) => true,
//                 ),
//                 AppTask(
//                   type: SensingUserTask.ONE_TIME_SENSING_TYPE,
//                   title: "Weather & Air Quality",
//                   description: "Collect local weather and air quality",
//                 )..measures = SamplingSchema.common().getMeasureList(
//                     namespace: NameSpace.CARP,
//                     types: [
//                       ContextSamplingPackage.WEATHER,
//                       ContextSamplingPackage.AIR_QUALITY,
//                     ],
//                   ))
//             ..addTriggerTask(
//                 ImmediateTrigger(),
//                 AppTask(
//                   type: SensingUserTask.ONE_TIME_SENSING_TYPE,
//                   title: "Location",
//                   description: "Collect current location",
//                 )..measures = SamplingSchema.common().getMeasureList(
//                     namespace: NameSpace.CARP,
//                     types: [
//                       ContextSamplingPackage.LOCATION,
//                     ],
//                   ))
//             ..addTriggerTask(
//                 ImmediateTrigger(),
//                 AppTask(
//                   type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
//                   title: surveys.demographics.title,
//                   description: surveys.demographics.description,
//                   minutesToComplete: surveys.demographics.minutesToComplete,
//                 )
//                   ..measures.add(RPTaskMeasure(
//                     type: MeasureType(
//                         NameSpace.CARP, SurveySamplingPackage.SURVEY),
//                     name: surveys.demographics.title,
//                     enabled: true,
//                     surveyTask: surveys.demographics.survey,
//                   ))
//                   ..measures.add(Measure(
//                     type: MeasureType(
//                         NameSpace.CARP, ContextSamplingPackage.LOCATION),
//                   )))
// //
//             ..addTriggerTask(
//                 PeriodicTrigger(period: Duration(minutes: 1)),
//                 AppTask(
//                   type: SurveyUserTask.SURVEY_TYPE,
//                   title: surveys.symptoms.title,
//                   description: surveys.symptoms.description,
//                   minutesToComplete: surveys.symptoms.minutesToComplete,
//                 )
//                   ..measures.add(RPTaskMeasure(
//                     type: MeasureType(
//                         NameSpace.CARP, SurveySamplingPackage.SURVEY),
//                     name: surveys.symptoms.title,
//                     enabled: true,
//                     surveyTask: surveys.symptoms.survey,
//                   ))
//                   ..measures.add(Measure(
//                     type: MeasureType(
//                         NameSpace.CARP, ContextSamplingPackage.LOCATION),
//                   )))
//           // ..addTriggerTask(
//           //     PeriodicTrigger(period: Duration(minutes: 2)),
//           //     AppTask(
//           //       type: AudioUserTask.AUDIO_TYPE,
//           //       title: "Coughing",
//           //       description:
//           //           'In this small exercise we would like to collect sound samples of coughing.',
//           //       instructions:
//           //           'Please press the record button below, and then cough 5 times.',
//           //       minutesToComplete: 3,
//           //     )
//           //       ..measures.add(AudioMeasure(
//           //         MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
//           //         name: "Coughing",
//           //         studyId: studyId,
//           //       ))
//           //       ..measures.add(Measure(
//           //         MeasureType(
//           //             NameSpace.CARP, ContextSamplingPackage.LOCATION),
//           //         name: "Current location",
//           //       )))
//           // ..addTriggerTask(
//           //     PeriodicTrigger(period: Duration(minutes: 2)),
//           //     AppTask(
//           //       type: AudioUserTask.AUDIO_TYPE,
//           //       title: "Reading",
//           //       description:
//           //           'In this small exercise we would like to collect sound data while you are reading.',
//           //       instructions:
//           //           'Please press the record button below, and then read the following text.\n\n'
//           //           'Many, many years ago lived an emperor, who thought so much of new clothes that he spent all his money in order to obtain them; his only ambition was to be always well dressed. '
//           //           'He did not care for his soldiers, and the theatre did not amuse him; the only thing, in fact, he thought anything of was to drive out and show a new suit of clothes. '
//           //           'He had a coat for every hour of the day; and as one would say of a king "He is in his cabinet," so one could say of him, "The emperor is in his dressing-room."',
//           //       minutesToComplete: 3,
//           //     )
//           //       ..measures.add(AudioMeasure(
//           //         MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
//           //         name: "Reading",
//           //         studyId: studyId,
//           //       ))
//           //       ..measures.add(Measure(
//           //         MeasureType(
//           //             NameSpace.CARP, ContextSamplingPackage.LOCATION),
//           //         name: "Current location",
//           //       )))

//           //
//           ;
//     }
//     return _study;
//   }

  /// Return a [DataEndPoint] of the specified type.
  DataEndPoint getDataEndpoint(String type) {
    assert(type != null);
    switch (type) {
      case DataEndPointTypes.PRINT:
        return new DataEndPoint(type: DataEndPointTypes.PRINT);
      case DataEndPointTypes.FILE:
        return FileDataEndPoint(
          bufferSize: 50 * 1000,
          zip: true,
          encrypt: false,
        );
      case DataEndPointTypes.CARP:
        // for now, upload each data point separately
        return CarpDataEndPoint(uploadMethod: CarpUploadMethod.DATA_POINT);
      // TODO - change to using batch upload once this is working (again)
      // return CarpDataEndPoint(
      //   uploadMethod: CarpUploadMethod.BATCH_DATA_POINT,
      //   bufferSize: 40 * 1000,
      //   zip: false,
      //   deleteWhenUploaded: false,
      // );
      //   return CarpDataEndPoint(
      //     uploadMethod: CarpUploadMethod.FILE,
      //     bufferSize: 20 * 1000,
      //     zip: true,
      //     deleteWhenUploaded: false,
      //   );
      default:
        return new DataEndPoint(type: DataEndPointTypes.PRINT);
    }
  }
}
