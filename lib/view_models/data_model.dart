part of carp_study_app;

/// An abstract view model used for all other view models in the app.
abstract class ViewModel {
  SmartphoneDeploymentController? _controller;

  SmartphoneDeploymentController? get controller => _controller;

  /// Initialize this view model before use.
  void init(SmartphoneDeploymentController ctrl) {
    this._controller = ctrl;
  }
}

/// The view model for the entire app.
class CarpStydyAppViewModel extends ViewModel {
  final DataVisualizationPageViewModel _dataVisualizationPageViewModel =
      DataVisualizationPageViewModel();
  final StudyPageViewModel _studyPageViewModel = StudyPageViewModel();
  final TaskListPageViewModel _taskListPageViewModel = TaskListPageViewModel();
  final ProfilePageViewModel _profilePageViewModel = ProfilePageViewModel();

  CarpStydyAppViewModel() : super();

  DataVisualizationPageViewModel get dataVisualizationPageViewModel =>
      _dataVisualizationPageViewModel;
  StudyPageViewModel get studyPageViewModel => _studyPageViewModel;
  TaskListPageViewModel get taskListPageViewModel => _taskListPageViewModel;
  ProfilePageViewModel get profilePageViewModel => _profilePageViewModel;

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
    _dataVisualizationPageViewModel.init(controller);
    _studyPageViewModel.init(controller);
    _taskListPageViewModel.init(controller);
    _profilePageViewModel.init(controller);
  }
}
