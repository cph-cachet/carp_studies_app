part of carp_study_app;

class DataVisualizationPageViewModel extends ViewModel {
  final ActivityCardViewModel _activityCardDataModel = ActivityCardViewModel();
  final StepsCardViewModel _stepsCardDataModel = StepsCardViewModel();
  final MeasuresCardViewModel _measuresCardDataModel = MeasuresCardViewModel();
  final MobilityCardViewModel _mobilityCardDataModel = MobilityCardViewModel();
  final TaskCardViewModel _surveysCardDataModel =
      TaskCardViewModel(SurveyUserTask.SURVEY_TYPE);
  final TaskCardViewModel _audioCardDataModel =
      TaskCardViewModel(AudioUserTask.AUDIO_TYPE);
  final TaskCardViewModel _videoCardDataModel =
      TaskCardViewModel(VideoUserTask.VIDEO_TYPE);
  final TaskCardViewModel _imageCardDataModel =
      TaskCardViewModel(VideoUserTask.IMAGE_TYPE);
  final StudyProgressCardViewModel _studyProgressCardDataModel =
      StudyProgressCardViewModel();
  final HeartRateCardViewModel _heartRateCardDataModel =
      HeartRateCardViewModel();

  ActivityCardViewModel get activityCardDataModel => _activityCardDataModel;
  StepsCardViewModel get stepsCardDataModel => _stepsCardDataModel;
  MeasuresCardViewModel get measuresCardDataModel => _measuresCardDataModel;
  MobilityCardViewModel get mobilityCardDataModel => _mobilityCardDataModel;
  TaskCardViewModel get surveysCardDataModel => _surveysCardDataModel;
  TaskCardViewModel get audioCardDataModel => _audioCardDataModel;
  TaskCardViewModel get videoCardDataModel => _videoCardDataModel;
  TaskCardViewModel get imageCardDataModel => _imageCardDataModel;
  HeartRateCardViewModel get heartRateCardDataModel => _heartRateCardDataModel;

  StudyProgressCardViewModel get studyProgressCardDataModel =>
      _studyProgressCardDataModel;

  /// A stream of [UserTask]s as they are generated.
  Stream<UserTask> get userTaskEvents => AppTaskController().userTaskEvents;

  /// The number of days the user has been part of this study.
  int get daysInStudy => (bloc.studyStartTimestamp != null)
      ? DateTime.now().difference(bloc.studyStartTimestamp!).inDays + 1
      : 0;

  /// The number of tasks completed so far.
  int get taskCompleted => AppTaskController()
      .userTaskQueue
      .where((task) => task.state == UserTaskState.done)
      .length;

  DataVisualizationPageViewModel();

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
    _activityCardDataModel.init(controller);
    _stepsCardDataModel.init(controller);
    _measuresCardDataModel.init(controller);
    _mobilityCardDataModel.init(controller);
    _surveysCardDataModel.init(controller);
    _audioCardDataModel.init(controller);
    _videoCardDataModel.init(controller);
    _imageCardDataModel.init(controller);
    _studyProgressCardDataModel.init(controller);
  }
}
