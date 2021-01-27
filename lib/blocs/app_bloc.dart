part of carp_study_app;

class AppBLoC {
  static final SHOW_INFORMED_CONSENT_KEY = 'show_informed_consent';

  CarpStydyAppDataModel _data = CarpStydyAppDataModel();
  Study _study;
  StudyController controller;
  StudyManager studyManager = LocalStudyManager();
  DateTime _studyStartTimestamp;
  DateTime get studyStartTimestamp => _studyStartTimestamp;
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  /// The persistent data model for this app
  CarpStydyAppDataModel get data => _data;

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
    await settings.init();

    // Get the study from the study manager
    _study = await studyManager.getStudy(studyId);

    // Create a Study Controller that can manage this study and initialize it.
    controller = StudyController(
      _study,
      debugLevel: DebugLevel.DEBUG,
    );
    data.init(controller);
    await controller.initialize();

    // wait 10 sec and the start sampling
    Timer(Duration(seconds: 10), () => controller.resume());

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

    _messages.add(LocalMessages.message1);
    _messages.add(LocalMessages.message2);
  }

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted {
    // bool show =
    //     settings.preferences.getBool(SHOW_INFORMED_CONSENT_KEY) ?? false;
    // print('>> show: $show');
    return true;
  }

  /// Has the informed consent been handled?
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  ///  * successfully uploaded to CARP
  set informedConsentAccepted(bool shown) =>
      settings.preferences.setBool(SHOW_INFORMED_CONSENT_KEY, shown);

  String get studyId => "2";

  /// The CARP username.
  String get username => "researcher@example.com";

  /// The CARP password.
  String get password =>
      "..."; //decrypt("lkjhf98sdvhcksdmnfewoiywefhowieyurpo2hjr");

  /// The URI of the CARP server.
  String get uri => "http://staging.carp.cachet.dk:8080";

  String get clientID => "carp";
  String get clientSecret => "carp";

  Study get study => _study;

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
  void addError(Object error, [StackTrace stacktrace]) =>
      controller.executor.addError(error, stacktrace);
}

final bloc = AppBLoC();
