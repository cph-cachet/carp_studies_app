part of carp_study_app;

class DataVisualizationPageModel extends DataModel {
  final ActivityCardDataModel _activityCardDataModel = ActivityCardDataModel();
  final StepsCardDataModel _stepsCardDataModel = StepsCardDataModel();
  final MeasuresCardDataModel _measuresCardDataModel = MeasuresCardDataModel();
  final MobilityCardDataModel _mobilityCardDataModel = MobilityCardDataModel();
  final TaskCardDataModel _surveysCardDataModel =
      TaskCardDataModel(SurveyUserTask.SURVEY_TYPE);
  final TaskCardDataModel _audioCardDataModel =
      TaskCardDataModel(AudioUserTask.AUDIO_TYPE);
  final StudyProgressCardDataModel _studyProgressCardDataModel =
      StudyProgressCardDataModel();

  ActivityCardDataModel get activityCardDataModel => _activityCardDataModel;
  StepsCardDataModel get stepsCardDataModel => _stepsCardDataModel;
  MeasuresCardDataModel get measuresCardDataModel => _measuresCardDataModel;
  MobilityCardDataModel get mobilityCardDataModel => _mobilityCardDataModel;
  TaskCardDataModel get surveysCardDataModel => _surveysCardDataModel;
  TaskCardDataModel get audioCardDataModel => _audioCardDataModel;
  StudyProgressCardDataModel get studyProgressCardDataModel =>
      _studyProgressCardDataModel;

  /// A stream of [UserTask]s as they are generated.
  Stream<UserTask> get userTaskEvents => AppTaskController().userTaskEvents;

  /// The number of days the user has been part of this study.
  int get daysInStudy => (bloc.studyStartTimestamp != null)
      ? DateTime.now().difference(bloc.studyStartTimestamp).inDays + 1
      : 0;

  /// The number of tasks completed so far.
  int get taskCompleted => AppTaskController()
      .userTaskQueue
      .where((task) => task.state == UserTaskState.done)
      .length;

  DataVisualizationPageModel();

  void init(StudyDeploymentController controller) {
    super.init(controller);
    _activityCardDataModel.init(controller);
    _stepsCardDataModel.init(controller);
    _measuresCardDataModel.init(controller);
    _mobilityCardDataModel.init(controller);
    _surveysCardDataModel.init(controller);
    _audioCardDataModel.init(controller);
    _studyProgressCardDataModel.init(controller);
  }
}
