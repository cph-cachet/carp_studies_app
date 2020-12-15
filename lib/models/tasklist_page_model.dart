part of carp_study_app;

class TaskListPageModel {
  TaskListPageModel();

  /// The list of available app tasks for the user to address.
  List<UserTask> get tasks => AppTaskController().userTaskQueue;

  /// A stream of [UserTask]s as they are generated.
  Stream<UserTask> get userTaskEvents => AppTaskController().userTaskEvents;

  /// The number of day the user has been part of this study.
  int get daysInStudy => 0;

  /// The number of tasks completed so far.
  int get taskCompleted => 0;
}
