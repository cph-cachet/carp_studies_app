part of carp_study_app;

class AppBLoC {
  static const INFORMED_CONSENT_ACCEPTED_KEY = 'informed_consent_accepted';

  CAMSMasterDeviceDeployment _deployment;
  String _studyDeploymentId;
  CARPBackend get backend => _backend;
  final CarpStydyAppDataModel _data = CarpStydyAppDataModel();
  StudyDeploymentStatus _status;
  StudyProtocol _protocol;
  StudyDeploymentController _controller;
  DateTime _studyStartTimestamp;
  List<Message> _messages;

  String get studyDeploymentId => _studyDeploymentId;
  CAMSMasterDeviceDeployment get deployment => _deployment;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus get status => _status;

  final CARPBackend _backend = CARPBackend();
  StudyProtocolManager manager;

  DateTime get studyStartTimestamp => _studyStartTimestamp;
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

    // first we will load the protcol locally
    manager = LocalStudyProtocolManager();
    // and use a dummy  studyDeploymentId
    _studyDeploymentId = '1234';

    // ... but later we will load it from CARP
    // used for downloading the study protocol from the CARP server
    // TODO - obtain deployment id from an invitaiton
    // manager = CARPStudyProtocolManager();
  }

  Future<void> init() async {
    globalDebugLevel = DebugLevel.DEBUG;
    await settings.init();
    await backend.init();
    info('$runtimeType initialized');
  }

  /// Initialize and setup sensing.
  Future<void> initializeSensing() async {
    // get the protocol from the study protocol manager based on the
    // study deployment id
    _protocol = await manager.getStudyProtocol(studyDeploymentId);

    // deploy this protocol using the on-phone deployment service
    // reuse the study deployment id, so we have the same id on the phone deployment
    _status = await CAMSDeploymentService().createStudyDeployment(
      _protocol,
      studyDeploymentId,
    );

    // initialize the local device controller with the deployment status,
    // which contains the list of needed devices
    await DeviceController().initialize(_status, CAMSDeploymentService());

    // now we're ready to get the device deployment configuration for this phone
    _deployment = await CAMSDeploymentService()
        .getDeviceDeployment(status.studyDeploymentId);

    // create a study deployment controller that can manage this deployment
    _controller = StudyDeploymentController(
      deployment,
      debugLevel: DebugLevel.DEBUG,
      privacySchemaName: PrivacySchema.DEFAULT,
    );

    data.init(controller);

    // initialize the controller
    await _controller.initialize();

    // listening on the data stream and print them as json to the debug console
    _controller.data.listen((data) => print(toJsonString(data)));
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
