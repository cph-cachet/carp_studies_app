part of carp_study_app;

/// An abstract data model used for all other data models in the app.
abstract class DataModel {
  StudyController _controller;

  StudyController get controller => _controller;
  DataModel();

  /// Call to initialize this data model
  void init(StudyController ctrl) {
    this._controller = ctrl;
  }
}

/// The data model for the entire app.
class CarpStydyAppDataModel extends DataModel {
  final DataPageModel _dataPageModel = DataPageModel();
  final StudyPageModel _studyPageModel = StudyPageModel();
  final TaskListPageModel _taskListPageModel = TaskListPageModel();

  CarpStydyAppDataModel() : super();

  DataPageModel get dataPageModel => _dataPageModel;
  StudyPageModel get studyPageModel => _studyPageModel;
  TaskListPageModel get taskListPageModel => _taskListPageModel;

  void init(StudyController controller) {
    super.init(controller);
    _dataPageModel.init(controller);
    _studyPageModel.init(controller);
    _taskListPageModel.init(controller);
  }
}
