part of '../main.dart';

class DataVisualizationPageViewModel extends ViewModel {
  final ActivityCardViewModel _activityCardDataModel = ActivityCardViewModel();
  final StepsCardViewModel _stepsCardDataModel = StepsCardViewModel();
  final MeasurementsCardViewModel _measuresCardDataModel =
      MeasurementsCardViewModel();
  final MobilityCardViewModel _mobilityCardDataModel = MobilityCardViewModel();
  final TaskCardViewModel _surveysCardDataModel =
      TaskCardViewModel(SurveyUserTask.SURVEY_TYPE);
  final TaskCardViewModel _audioCardDataModel =
      TaskCardViewModel(AudioUserTask.audioType);
  final TaskCardViewModel _videoCardDataModel =
      TaskCardViewModel(VideoUserTask.videoType);
  final TaskCardViewModel _imageCardDataModel =
      TaskCardViewModel(VideoUserTask.imageType);
  final StudyProgressCardViewModel _studyProgressCardDataModel =
      StudyProgressCardViewModel();
  final HeartRateCardViewModel _heartRateCardDataModel =
      HeartRateCardViewModel();

  ActivityCardViewModel get activityCardDataModel => _activityCardDataModel;
  StepsCardViewModel get stepsCardDataModel => _stepsCardDataModel;
  MeasurementsCardViewModel get measuresCardDataModel => _measuresCardDataModel;
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

  @override
  Future<int> init(SmartphoneDeploymentController ctrl) async {
    super.init(ctrl);
    await _activityCardDataModel.init(ctrl);
    await _stepsCardDataModel.init(ctrl);
    _measuresCardDataModel.init(ctrl);
    await _mobilityCardDataModel.init(ctrl);
    _surveysCardDataModel.init(ctrl);
    _audioCardDataModel.init(ctrl);
    _videoCardDataModel.init(ctrl);
    _imageCardDataModel.init(ctrl);
    _studyProgressCardDataModel.init(ctrl);
    await _heartRateCardDataModel.init(ctrl);
    return 1;
  }

  /// Delete all persistent view models.
  void delete(SmartphoneDeploymentController ctrl) {
    _activityCardDataModel.delete();
    _stepsCardDataModel.delete();
    _mobilityCardDataModel.delete();
    _heartRateCardDataModel.delete();
  }
}
