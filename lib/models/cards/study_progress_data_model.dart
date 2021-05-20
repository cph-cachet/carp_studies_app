part of carp_study_app;

class StudyProgressCardDataModel extends DataModel {
  final Map<String, int> _progressTable = {};

  /// A stream of [UserTask]s as they are generated.
  Stream<UserTask> get userTaskEvents => AppTaskController().userTaskEvents;

  /// The number of tasks completed so far.
  int get taskCompleted =>
      AppTaskController().userTaskQueue.where((task) => task.state == UserTaskState.done).length;

  /// The number of tasks expired so far.
  int get taskExpired =>
      AppTaskController().userTaskQueue.where((task) => task.state == UserTaskState.dequeued).length;

  /// The number of tasks pending so far.
  int get taskPending =>
      AppTaskController().userTaskQueue.where((task) => task.state == UserTaskState.enqueued).length;

  /// A table with sampling size of each measure type
  Map<String, int> get progressTable => _progressTable;

  /// The list of measures
  List<StudyProgress> get progress =>
      _progressTable.entries.map((entry) => StudyProgress(entry.key, entry.value)).toList();

  StudyProgressCardDataModel() : super();

  void init(StudyController controller) {
    super.init(controller);
    updateProgress();
  }

  String toString() {
    String _str = 'TASKS PROGRESS\t| #\n';
    _progressTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }

  void updateProgress() {
    _progressTable['completed'] = taskCompleted;
    _progressTable['expired'] = taskExpired;
    _progressTable['pending'] = taskPending;
  }
}

class StudyProgress {
  final String state;
  final int value;
  StudyProgress(this.state, this.value);
}
