part of carp_study_app;

class SensingBLoC {
  final Sensing sensing = Sensing();

  /// The list of available app tasks for the user to address.
  List<UserTask> get tasks => AppTaskController().userTaskQueue;

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning => (sensing.controller != null) && sensing.controller.executor.state == ProbeState.resumed;

  /// Get the study for this app.
  StudyModel get study => sensing.study != null ? StudyModel(sensing.study) : null;

  /// Get the data model for this study.
  DataModel get data => null;

  SensingBLoC();

  Future<void> init() async {
    // This show how an app can listen to user task events.
    // Is not used in this app.
    AppTaskController().userTaskEvents.listen((event) {
      switch (event.state) {
        case UserTaskState.initialized:
          //
          break;
        case UserTaskState.enqueued:
          //
          break;
        case UserTaskState.dequeued:
          //
          break;
        case UserTaskState.started:
          //
          break;
        case UserTaskState.onhold:
          //
          break;
        case UserTaskState.done:
          //
          break;
        case UserTaskState.undefined:
          //
          break;
      }
    });
  }

  Future<void> start() async => sensing.start();

  void pause() => sensing.controller.pause();

  void resume() async => sensing.controller.resume();

  void stop() async => sensing.stop();

  void dispose() async => sensing.stop();

  /// Add a [Datum] object to the stream of events.
  void addDatum(Datum datum) => sensing.controller.executor.addDatum(datum);

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace stacktrace]) => sensing.controller.executor.addError(error, stacktrace);
}

final bloc = SensingBLoC();
