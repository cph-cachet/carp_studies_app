part of carp_study_app;

class TaskListPageViewModel extends ViewModel {
  TaskListPageViewModel();

  List<UserTask> get tasks => AppTaskController().userTaskQueue;

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
}
