part of carp_study_app;

class AppBLoC {
  Study _study;
  StudyController controller;
  StudyManager studyManager = LocalStudyManager();
  DateTime _studyStartTimestamp;
  DateTime get studyStartTimestamp => _studyStartTimestamp;

  /// TODO REMOVE THIS LINE
  List<UserTask> get tasks => AppTaskController().userTaskQueue;

  AppBLoC() : super() {
    // create and register external sampling packages
    //SamplingPackageRegistry.register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    //SamplingPackageRegistry.register(CommunicationSamplingPackage());
    SamplingPackageRegistry().register(AudioSamplingPackage());
    SamplingPackageRegistry().register(SurveySamplingPackage());
    //SamplingPackageRegistry.register(HealthSamplingPackage());

    // create and register external data managers
    DataManagerRegistry().register(CarpDataManager());
  }

  Future<void> init() async {
    // Get the study from the study manager
    _study = await studyManager.getStudy(settings.studyId);

    // Create a Study Controller that can manage this study and initialize it.
    controller = StudyController(
      _study,
      debugLevel: DebugLevel.DEBUG,
    );
    await controller.initialize();

    // This show how an app can listen to user task events.
    // Is not used right now.
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

  Study get study => _study;

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning => (controller != null) && controller.executor.state == ProbeState.resumed;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes => (controller != null) ? controller.executor.probes : List();

  /// Start sensing. Should only be called once.
  /// Use [resume] and [pause] if pausing/resuming sensing.
  Future<void> start() async {
    // check the start time for this study on this phone
    _studyStartTimestamp = await settings.studyStartTimestamp;
    info('Study was started on this phone on ${_studyStartTimestamp.toUtc()}');

    controller.resume();

    // listening on all data events from the study and print it (for debugging purpose).
    controller.events.forEach(print);
  }

  void pause() => controller.pause();

  void resume() => controller.resume();

  /// Stop sensing.
  /// Once sensing is stopped, it cannot be (re)started.
  void stop() {
    controller.stop();
    _study = null;
  }

  void dispose() => stop();

  /// Add a [Datum] object to the stream of events.
  void addDatum(Datum datum) => controller.executor.addDatum(datum);

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace stacktrace]) => controller.executor.addError(error, stacktrace);
}

final bloc = AppBLoC();
