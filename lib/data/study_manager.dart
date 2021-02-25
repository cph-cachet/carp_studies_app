part of carp_study_app;

class LocalStudyManager implements StudyManager {
  Study _study;

  Future<void> initialize() => null;

  Future<Study> getStudy(String studyId) async =>
      _study ??= await _getGenericCARPStudy(studyId); // _getWristWatchStudy(studyId);

  Future<Study> _getGenericCARPStudy(String studyId) async {
    if (_study == null) {
      _study = Study(id: studyId, userId: await settings.userId)
        ..name = 'CARP Study'
        ..title = 'CARP Study App Feasibility Study'
        ..purpose = 'To investigate the technical stability and usability of the CARP Generic Study App.'
        ..pi = PrincipalInvestigator(
          name: 'Jakob E. Bardram',
          title: 'PhD, MSc',
          email: 'jakba@dtu.dk',
          affiliation: 'Technical University of Denmark',
          address: 'Ørsteds Plads, bygn. 349, DK-2800 Kg. Lyngby',
        )
        ..description =
            "We would like to have you help in testing the technical stability and the usability of the CARP Mobile Sensing app. "
                "Your data will be collected and store anonymously."
        ..dataEndPoint = getDataEndpoint(DataEndPointTypes.CARP)
        // collect basic device measures
        ..addTriggerTask(
            ImmediateTrigger(),
            AutomaticTask()
              ..measures = SamplingSchema.debug().getMeasureList(
                namespace: NameSpace.CARP,
                types: [
                  SensorSamplingPackage.LIGHT,
                  SensorSamplingPackage.PEDOMETER,
                  DeviceSamplingPackage.MEMORY,
                  DeviceSamplingPackage.DEVICE,
                  DeviceSamplingPackage.BATTERY,
                  DeviceSamplingPackage.SCREEN,
                ],
              ))
        // collect location, weather and air quality every 5 minutes
        ..addTriggerTask(
            PeriodicTrigger(period: Duration(minutes: 5)),
            Task()
              ..measures = SamplingSchema.common().getMeasureList(
                namespace: NameSpace.CARP,
                types: [
                  ContextSamplingPackage.LOCATION,
                  ContextSamplingPackage.WEATHER,
                  ContextSamplingPackage.AIR_QUALITY,
                ],
              ))
        // collect location, activity, mobility measures continously (event-based)
        ..addTriggerTask(
            ImmediateTrigger(),
            Task()
              ..measures = SamplingSchema.common().getMeasureList(
                namespace: NameSpace.CARP,
                types: [
                  ContextSamplingPackage.GEOLOCATION,
                  ContextSamplingPackage.ACTIVITY,
                  ContextSamplingPackage.MOBILITY,
                ],
              ))
        // collect local weather and air quality as an app task
        ..addTriggerTask(
            ImmediateTrigger(),
            AppTask(
              type: SensingUserTask.ONE_TIME_SENSING_TYPE,
              title: "Weather & Air Quality",
              description: "Collect local weather and air quality",
            )..measures = SamplingSchema.common().getMeasureList(
                namespace: NameSpace.CARP,
                types: [
                  ContextSamplingPackage.WEATHER,
                  ContextSamplingPackage.AIR_QUALITY,
                ],
              ))
        // collect demographics once when the study starts
        ..addTriggerTask(
            ImmediateTrigger(),
            AppTask(
              type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
              title: surveys.demographics.title,
              description: surveys.demographics.description,
              minutesToComplete: surveys.demographics.minutesToComplete,
              expire: surveys.demographics.expire,
            )
              ..measures.add(RPTaskMeasure(
                type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                name: surveys.demographics.title,
                enabled: true,
                surveyTask: surveys.demographics.survey,
              ))
              ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.LOCATION]))
        // collect symptoms on a daily basis
        ..addTriggerTask(
            PeriodicTrigger(period: Duration(days: 1)),
            AppTask(
              type: SurveyUserTask.SURVEY_TYPE,
              title: surveys.symptoms.title,
              description: surveys.symptoms.description,
              minutesToComplete: surveys.symptoms.minutesToComplete,
              expire: surveys.symptoms.expire,
            )
              ..measures.add(RPTaskMeasure(
                type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                name: surveys.symptoms.title,
                enabled: true,
                surveyTask: surveys.symptoms.survey,
              ))
              ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.LOCATION]))
        // collect a coughing sample on a daily basis
        // also collect location, and local weather and air quality of this sample
        ..addTriggerTask(
            PeriodicTrigger(period: Duration(minutes: 1)),
            AppTask(
              type: AudioUserTask.AUDIO_TYPE,
              title: "Coughing",
              description: 'In this small exercise we would like to collect sound samples of coughing.',
              instructions: 'Please cough 5 times.',
              minutesToComplete: 1,
            )
              ..measures.add(AudioMeasure(
                type: MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
                name: "Coughing",
                studyId: studyId,
              ))
              ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.LOCATION])
              ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.WEATHER])
              ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.AIR_QUALITY]))
        // collect a reading / audio sample on a daily basis
        ..addTriggerTask(
            PeriodicTrigger(period: Duration(minutes: 1)),
            AppTask(
              type: AudioUserTask.AUDIO_TYPE,
              title: "Reading",
              description:
                  'In this small exercise we would like to collect sound data while you are reading.',
              instructions: 'Please read the following text aloud.\n\n'
                  'Many, many years ago lived an emperor, who thought so much of new clothes that he spent all his money in order to obtain them; his only ambition was to be always well dressed. '
                  'He did not care for his soldiers, and the theatre did not amuse him; the only thing, in fact, he thought anything of was to drive out and show a new suit of clothes. '
                  'He had a coat for every hour of the day; and as one would say of a king "He is in his cabinet," so one could say of him, "The emperor is in his dressing-room."',
              minutesToComplete: 3,
            )..measures.add(AudioMeasure(
                type: MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
                name: "Reading",
                studyId: studyId,
              )))
        // when the reading (audio) measure is collected, the add a user task to
        // collect location, and local weather and air quality
        ..addTriggerTask(
            ConditionalSamplingEventTrigger(
              measureType: MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
              resumeCondition: (Datum datum) => true,
              pauseCondition: (Datum datum) => true,
            ),
            AppTask(
              type: SensingUserTask.ONE_TIME_SENSING_TYPE,
              title: "Location, Weather & Air Quality",
              description: "Collect location, weather and air quality",
            )..measures = SamplingSchema.common().getMeasureList(
                namespace: NameSpace.CARP,
                types: [
                  ContextSamplingPackage.LOCATION,
                  ContextSamplingPackage.WEATHER,
                  ContextSamplingPackage.AIR_QUALITY,
                ],
              ));
    }

    return _study;
  }

  Future<Study> _getWristWatchStudy(String studyId) async {
    if (_study == null) {
      _study = Study(id: studyId, userId: await settings.userId)
            ..name = 'ERP App'
            ..description =
                "Dette skema skal hjælpe dig at gennemføre en eksponeringsopgave for at få styr på OCD’en. I terapi, har du måske lært at for at få styr på OCD’en skal du sige fra overfor tvangstanker og tvangshandlinger. Det bliver du bedre til ved at øve dig i at gøre noget der fremkalder tvangstanker og lade være med at udføre tvangshandlinger. Hvis du ikke har gennemgået eksponeringsøvelser med din behandler, skal du ikke bruge denne app."
            ..dataEndPoint = getDataEndpoint(DataEndPointTypes.FILE)
            // collect basic device measures continously
            ..addTriggerTask(
                ImmediateTrigger(),
                AutomaticTask()
                  ..measures = SamplingSchema.debug().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      SensorSamplingPackage.LIGHT,
                      SensorSamplingPackage.PEDOMETER,
                      // DeviceSamplingPackage.MEMORY,
                      DeviceSamplingPackage.DEVICE,
                      DeviceSamplingPackage.BATTERY,
                      DeviceSamplingPackage.SCREEN,
                    ],
                  ))
            // collect location, weather and air quality every 5 minutes
            ..addTriggerTask(
                PeriodicTrigger(period: Duration(minutes: 5)),
                Task()
                  ..measures = SamplingSchema.common().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      ContextSamplingPackage.LOCATION,
                      ContextSamplingPackage.WEATHER,
                      ContextSamplingPackage.AIR_QUALITY,
                    ],
                  ))
            // collect location and activity measures continously (event-based)
            ..addTriggerTask(
                ImmediateTrigger(),
                Task()
                  ..measures = SamplingSchema.common().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      ContextSamplingPackage.GEOLOCATION,
                      ContextSamplingPackage.ACTIVITY,
                    ],
                  ))
            // collect local weather and air quality as an app task
            ..addTriggerTask(
                ImmediateTrigger(),
                AppTask(
                  type: SensingUserTask.ONE_TIME_SENSING_TYPE,
                  title: "Weather & Air Quality",
                  description: "Collect local weather and air quality",
                )..measures = SamplingSchema.common().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      ContextSamplingPackage.WEATHER,
                      ContextSamplingPackage.AIR_QUALITY,
                    ],
                  ))
            // collect demographics once when the study starts
            ..addTriggerTask(
                ImmediateTrigger(),
                AppTask(
                  type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
                  title: surveys.demographics.title,
                  description: surveys.demographics.description,
                  minutesToComplete: surveys.demographics.minutesToComplete,
                  expire: surveys.demographics.expire,
                )
                  ..measures.add(RPTaskMeasure(
                    type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                    name: surveys.demographics.title,
                    enabled: true,
                    surveyTask: surveys.demographics.survey,
                  ))
                  ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.LOCATION]))
            // collect symptoms on a daily basis
            ..addTriggerTask(
                PeriodicTrigger(period: Duration(minutes: 5)),
                AppTask(
                  type: SurveyUserTask.SURVEY_TYPE,
                  title: surveys.parnas.title,
                  description: surveys.parnas.description,
                  minutesToComplete: surveys.parnas.minutesToComplete,
                  expire: surveys.parnas.expire,
                )
                  ..measures.add(RPTaskMeasure(
                    type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                    name: surveys.parnas.title,
                    enabled: true,
                    surveyTask: surveys.parnas.survey,
                  ))
                  ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.LOCATION])
                  ..measures.add(SamplingSchema.common().measures[ContextSamplingPackage.WEATHER]))
            ..addTriggerTask(
                PeriodicTrigger(period: Duration(minutes: 5)),
                AppTask(
                  type: SurveyUserTask.SURVEY_TYPE,
                  title: surveys.exposure.title,
                  description: surveys.exposure.description,
                  minutesToComplete: surveys.exposure.minutesToComplete,
                  expire: surveys.exposure.expire,
                )..measures.add(RPTaskMeasure(
                    type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                    name: surveys.exposure.title,
                    enabled: true,
                    surveyTask: surveys.exposure.survey,
                  )))
          //
          ;
    }

    return _study;
  }

  Future<Study> _getConditionalStudy(String studyId) async {
    if (_study == null) {
      _study = Study(id: studyId, userId: await settings.userId)
            ..name = 'Conditional Monitor'
            ..description = 'This is a test study.'
            ..dataEndPoint = getDataEndpoint(DataEndPointTypes.FILE)
            ..addTriggerTask(
                ConditionalSamplingEventTrigger(
                  measureType: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                  resumeCondition: (Datum datum) => true,
                  pauseCondition: (Datum datum) => true,
                ),
                AppTask(
                  type: SensingUserTask.ONE_TIME_SENSING_TYPE,
                  title: "Weather & Air Quality",
                  description: "Collect local weather and air quality",
                )..measures = SamplingSchema.common().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      ContextSamplingPackage.WEATHER,
                      ContextSamplingPackage.AIR_QUALITY,
                    ],
                  ))
            ..addTriggerTask(
                ImmediateTrigger(),
                AppTask(
                  type: SensingUserTask.ONE_TIME_SENSING_TYPE,
                  title: "Location",
                  description: "Collect current location",
                )..measures = SamplingSchema.common().getMeasureList(
                    namespace: NameSpace.CARP,
                    types: [
                      ContextSamplingPackage.LOCATION,
                    ],
                  ))
            ..addTriggerTask(
                ImmediateTrigger(),
                AppTask(
                  type: SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE,
                  title: surveys.demographics.title,
                  description: surveys.demographics.description,
                  minutesToComplete: surveys.demographics.minutesToComplete,
                )
                  ..measures.add(RPTaskMeasure(
                    type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                    name: surveys.demographics.title,
                    enabled: true,
                    surveyTask: surveys.demographics.survey,
                  ))
                  ..measures.add(Measure(
                    type: MeasureType(NameSpace.CARP, ContextSamplingPackage.LOCATION),
                  )))
//
            ..addTriggerTask(
                PeriodicTrigger(period: Duration(minutes: 1)),
                AppTask(
                  type: SurveyUserTask.SURVEY_TYPE,
                  title: surveys.symptoms.title,
                  description: surveys.symptoms.description,
                  minutesToComplete: surveys.symptoms.minutesToComplete,
                )
                  ..measures.add(RPTaskMeasure(
                    type: MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY),
                    name: surveys.symptoms.title,
                    enabled: true,
                    surveyTask: surveys.symptoms.survey,
                  ))
                  ..measures.add(Measure(
                    type: MeasureType(NameSpace.CARP, ContextSamplingPackage.LOCATION),
                  )))
          // ..addTriggerTask(
          //     PeriodicTrigger(period: Duration(minutes: 2)),
          //     AppTask(
          //       type: AudioUserTask.AUDIO_TYPE,
          //       title: "Coughing",
          //       description:
          //           'In this small exercise we would like to collect sound samples of coughing.',
          //       instructions:
          //           'Please press the record button below, and then cough 5 times.',
          //       minutesToComplete: 3,
          //     )
          //       ..measures.add(AudioMeasure(
          //         MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
          //         name: "Coughing",
          //         studyId: studyId,
          //       ))
          //       ..measures.add(Measure(
          //         MeasureType(
          //             NameSpace.CARP, ContextSamplingPackage.LOCATION),
          //         name: "Current location",
          //       )))
          // ..addTriggerTask(
          //     PeriodicTrigger(period: Duration(minutes: 2)),
          //     AppTask(
          //       type: AudioUserTask.AUDIO_TYPE,
          //       title: "Reading",
          //       description:
          //           'In this small exercise we would like to collect sound data while you are reading.',
          //       instructions:
          //           'Please press the record button below, and then read the following text.\n\n'
          //           'Many, many years ago lived an emperor, who thought so much of new clothes that he spent all his money in order to obtain them; his only ambition was to be always well dressed. '
          //           'He did not care for his soldiers, and the theatre did not amuse him; the only thing, in fact, he thought anything of was to drive out and show a new suit of clothes. '
          //           'He had a coat for every hour of the day; and as one would say of a king "He is in his cabinet," so one could say of him, "The emperor is in his dressing-room."',
          //       minutesToComplete: 3,
          //     )
          //       ..measures.add(AudioMeasure(
          //         MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO),
          //         name: "Reading",
          //         studyId: studyId,
          //       ))
          //       ..measures.add(Measure(
          //         MeasureType(
          //             NameSpace.CARP, ContextSamplingPackage.LOCATION),
          //         name: "Current location",
          //       )))

          //
          ;
    }
    return _study;
  }

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

  @override
  Future<bool> saveStudy(Study study) {
    // TODO: implement saveStudy
    throw UnimplementedError();
  }
}
