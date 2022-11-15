part of carp_study_app;

class DataVisualizationPageViewModel extends ViewModel {
  final ActivityCardViewModel _activityCardDataModel = ActivityCardViewModel();
  final StepsCardViewModel _stepsCardDataModel = StepsCardViewModel();
  final MeasuresCardViewModel _measuresCardDataModel = MeasuresCardViewModel();
  final MobilityCardViewModel _mobilityCardDataModel = MobilityCardViewModel();
  final TaskCardViewModel _surveysCardDataModel = TaskCardViewModel(SurveyUserTask.SURVEY_TYPE);
  final TaskCardViewModel _audioCardDataModel = TaskCardViewModel(AudioUserTask.AUDIO_TYPE);
  final TaskCardViewModel _videoCardDataModel = TaskCardViewModel(VideoUserTask.VIDEO_TYPE);
  final TaskCardViewModel _imageCardDataModel = TaskCardViewModel(VideoUserTask.IMAGE_TYPE);
  final StudyProgressCardViewModel _studyProgressCardDataModel = StudyProgressCardViewModel();

  ActivityCardViewModel get activityCardDataModel => _activityCardDataModel;
  StepsCardViewModel get stepsCardDataModel => _stepsCardDataModel;
  MeasuresCardViewModel get measuresCardDataModel => _measuresCardDataModel;
  MobilityCardViewModel get mobilityCardDataModel => _mobilityCardDataModel;
  TaskCardViewModel get surveysCardDataModel => _surveysCardDataModel;
  TaskCardViewModel get audioCardDataModel => _audioCardDataModel;
  TaskCardViewModel get videoCardDataModel => _videoCardDataModel;
  TaskCardViewModel get imageCardDataModel => _imageCardDataModel;

  StudyProgressCardViewModel get studyProgressCardDataModel => _studyProgressCardDataModel;

  /// A stream of [UserTask]s as they are generated.
  Stream<UserTask> get userTaskEvents => AppTaskController().userTaskEvents;

  /// The number of days the user has been part of this study.
  int get daysInStudy => (bloc.studyStartTimestamp != null)
      ? DateTime.now().difference(bloc.studyStartTimestamp!).inDays + 1
      : 0;

  /// The number of tasks completed so far.
  int get taskCompleted =>
      AppTaskController().userTaskQueue.where((task) => task.state == UserTaskState.done).length;

  DataVisualizationPageViewModel();

  @override
  void init(SmartphoneDeploymentController ctrl) {
    super.init(ctrl);
    _activityCardDataModel.init(ctrl);
    _stepsCardDataModel.init(ctrl);
    _measuresCardDataModel.init(ctrl);
    _mobilityCardDataModel.init(ctrl);
    _surveysCardDataModel.init(ctrl);
    _audioCardDataModel.init(ctrl);
    _videoCardDataModel.init(ctrl);
    _imageCardDataModel.init(ctrl);
    _studyProgressCardDataModel.init(ctrl);
  }
}
