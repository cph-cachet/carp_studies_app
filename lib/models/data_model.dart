part of carp_study_app;

/// An abstract data model used for all other data models in the app.
abstract class DataModel {
  StudyDeploymentController? _controller;

  StudyDeploymentController? get controller => _controller;
  DataModel();

  /// Call to initialize this data model
  void init(StudyDeploymentController ctrl) {
    this._controller = ctrl;
  }
}

/// The data model for the entire app.
class CarpStydyAppDataModel extends DataModel {
  final DataVisualizationPageModel _dataPageModel =
      DataVisualizationPageModel();
  final StudyPageModel _studyPageModel = StudyPageModel();
  final TaskListPageModel _taskListPageModel = TaskListPageModel();
  final ProfilePageModel _profilePageModel = ProfilePageModel();

  CarpStydyAppDataModel() : super();

  DataVisualizationPageModel get dataPageModel => _dataPageModel;
  StudyPageModel get studyPageModel => _studyPageModel;
  TaskListPageModel get taskListPageModel => _taskListPageModel;
  ProfilePageModel get profilePageModel => _profilePageModel;

  void init(StudyDeploymentController controller) {
    super.init(controller);
    _dataPageModel.init(controller);
    _studyPageModel.init(controller);
    _taskListPageModel.init(controller);
    _profilePageModel.init(controller);
  }
}
