part of carp_study_app;

class DataVisualizationPageModel extends DataModel {
  final ActivityCardDataModel _activityCardDataModel = ActivityCardDataModel();
  final StepsCardDataModel _stepsCardDataModel = StepsCardDataModel();
  final MeasuresCardDataModel _measuresCardDataModel = MeasuresCardDataModel();
  final MobilityCardDataModel _mobilityCardDataModel = MobilityCardDataModel();

  ActivityCardDataModel get activityCardDataModel => _activityCardDataModel;
  StepsCardDataModel get stepsCardDataModel => _stepsCardDataModel;
  MeasuresCardDataModel get measuresCardDataModel => _measuresCardDataModel;
  MobilityCardDataModel get mobilityCardDataModel => _mobilityCardDataModel;

  DataVisualizationPageModel();

  void init(StudyController controller) {
    super.init(controller);
    _activityCardDataModel.init(controller);
    _stepsCardDataModel.init(controller);
    _measuresCardDataModel.init(controller);
    _mobilityCardDataModel.init(controller);
  }
}
