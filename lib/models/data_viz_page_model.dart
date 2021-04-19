part of carp_study_app;

class DataVisualizationPageModel extends DataModel {
  final ActivityCardDataModel _activityCardDataModel = ActivityCardDataModel();
  final StepsCardDataModel _stepsCardDataModel = StepsCardDataModel();
  final MeasuresCardDataModel _measuresCardDataModel = MeasuresCardDataModel();
  final MobilityCardDataModel _mobilityCardDataModel = MobilityCardDataModel();
  final SurveysCardDataModel _surveysCardDataModel = SurveysCardDataModel();
  final AudioCardDataModel _audioCardDataModel = AudioCardDataModel();

  ActivityCardDataModel get activityCardDataModel => _activityCardDataModel;
  StepsCardDataModel get stepsCardDataModel => _stepsCardDataModel;
  MeasuresCardDataModel get measuresCardDataModel => _measuresCardDataModel;
  MobilityCardDataModel get mobilityCardDataModel => _mobilityCardDataModel;
  SurveysCardDataModel get surveysCardDataModel => _surveysCardDataModel;
  AudioCardDataModel get audioCardDataModel => _audioCardDataModel;

  DataVisualizationPageModel();

  void init(StudyController controller) {
    super.init(controller);
    _activityCardDataModel.init(controller);
    _stepsCardDataModel.init(controller);
    _measuresCardDataModel.init(controller);
    _mobilityCardDataModel.init(controller);
    _surveysCardDataModel.init(controller);
    _audioCardDataModel.init(controller);
  }
}
