part of carp_study_app;

class AppBLoC {
  static const INFORMED_CONSENT_ACCEPTED_KEY = 'informed_consent_accepted';

  final CARPBackend _backend = CARPBackend();
  CARPBackend get backend => _backend;
  final CarpStydyAppDataModel _data = CarpStydyAppDataModel();
  Study _study;
  StudyController controller;
  DateTime _studyStartTimestamp;
  DateTime get studyStartTimestamp => _studyStartTimestamp;
  List<Message> _messages;
  List<Message> get messages => _messages;

  /// The overall data model for this app
  CarpStydyAppDataModel get data => _data;

  String get _informedConsentAcceptedKey =>
      '${settings.appName}.$INFORMED_CONSENT_ACCEPTED_KEY'.toLowerCase();

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

    // register the special-purpose audio user task factory
    AppTaskController().registerUserTaskFactory(AudioUserTaskFactory());
  }

  Future<void> init() async {
    globalDebugLevel = DebugLevel.DEBUG;
    await settings.init();
    await backend.init();
    info('$runtimeType initialized');
  }

  Future<void> initializeSensing() async {
    // Get the study from the study manager
    _study = await backend.getStudy();

    // Create a Study Controller that can manage this study and initialize it.
    controller = StudyController(_study);
    data.init(controller);
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
        case UserTaskState.canceled:
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

  Future<void> leaveStudy() async {
    controller.stop();
    bloc.informedConsentAccepted = false;
    await backend.leaveStudy();
  }

  Future<void> leaveStudyAndSignOut() async {
    await leaveStudy();
    await backend.signOut();
  }

  Future<void> getMessages() async =>
      _messages ??= await backend?.messageManager?.messages;

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted =>
      settings.preferences.getBool(_informedConsentAcceptedKey) ?? false;

  /// Has the informed consent been handled?
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  ///  * successfully uploaded to CARP
  set informedConsentAccepted(bool accepted) =>
      settings.preferences.setBool(_informedConsentAcceptedKey, accepted);

  /// The currently running [Study].
  Study get study => _study;

  /// The signed in user. Returns null if no user is signed in.
  CarpUser get user => backend?.user;

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning =>
      (controller != null) && controller.executor.state == ProbeState.resumed;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes =>
      (controller != null) ? controller.executor.probes : List();

  /// Start sensing. Should only be called once.
  /// Use [resume] and [pause] if pausing/resuming sensing.
  Future<void> start() async {
    controller.resume();
    _studyStartTimestamp = await settings.studyStartTimestamp;

    // listening on all data events from the study and print it (for debugging purpose).
    controller.events.forEach(print);
  }

  // Pause sensing.
  void pause() => controller.pause();

  /// Resume sensing.
  void resume() => controller.resume();

  /// Stop sensing.
  /// Once sensing is stopped, it cannot be (re)started.
  void stop() {
    controller.stop();
    _study = null;
  }

  // Dispose the entire sensing.
  void dispose() => stop();

  /// Add a [Datum] object to the stream of events.
  void addDatum(Datum datum) => controller.executor.addDatum(datum);

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace stacktrace]) =>
      controller.executor.addError(error, stacktrace);
}

final bloc = AppBLoC();
