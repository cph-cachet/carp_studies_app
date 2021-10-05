part of carp_study_app;

enum StudyAppState {
  /// The BLOC is created (initial state)
  created,

  /// The BLOC is initialized via the [initialized] method.
  initialized,

  /// The BLOC is in the process of being configured.
  configuring,

  /// The BLOC is configured and ready to use.
  configured,
}

class StudyAppBLoC {
  StudyAppState _state = StudyAppState.created;
  final CarpBackend _backend = CarpBackend();
  final CarpStydyAppDataModel _data = CarpStydyAppDataModel();
  StudyDeploymentStatus? _status;
  DateTime? _studyStartTimestamp;
  List<Message>? _messages;

  StudyAppState get state => _state;
  bool get isInitialized => _state.index >= 1;
  bool get isConfiguring => _state.index >= 2;
  bool get isConfigured => _state.index >= 3;

  /// Debug level for this app (and CAMS).
  DebugLevel debugLevel;

  /// What kind of deployment are we running - LOCAL or CARP?
  final DeploymentMode deploymentMode;

  /// Force the app to refresh the user credentials and study information?
  final bool forceSignOutAndStudyReload;

  /// Create the BLoC for the app specifying:
  ///  * debug level
  ///  * deployment mode (LOCAL or CARP)
  ///  * whether to use the locally stored credentials
  StudyAppBLoC({
    this.debugLevel = DebugLevel.INFO,
    this.deploymentMode = DeploymentMode.LOCAL,
    this.forceSignOutAndStudyReload = false,
  }) : super();

  /// The informed consent to be shown to the user for this study.
  RPOrderedTask? informedConsent;

  ResourceManager get resourceManager =>
      (deploymentMode == DeploymentMode.LOCAL)
          ? LocalResourceManager()
          : CarpResourceManager();

  LocalizationLoader get localizationLoader =>
      ResourceLocalizationLoader(resourceManager);

  MessageManager messageManager = LocalMessageManager();

  CarpBackend get backend => _backend;

  /// The id of the currently running study deployment.
  /// Typical set based on an invitation.
  /// `null` if no deployment have been specified.
  String? get studyDeploymentId => Settings().studyDeploymentId;
  set studyDeploymentId(String? id) => Settings().studyDeploymentId = id;

  // String? get studyDeploymentId => deployment?.studyDeploymentId;

  /// The deployment running on this phone.
  SmartphoneDeployment? get deployment =>
      Sensing().controller?.deployment as SmartphoneDeployment?;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus? get status => _status;

  DateTime? get studyStartTimestamp => _studyStartTimestamp;
  List<Message>? get messages => _messages;

  /// The overall data model for this app
  CarpStydyAppDataModel get data => _data;

  /// Does this [deployment] have the measure of [type].
  bool hasMeasure(String type) {
    if (deployment == null) return false;

    try {
      deployment!.measures.firstWhere((measure) => measure.type == type);
    } catch (error) {
      return false;
    }

    return true;
  }

  /// Initialize this BLOC. Called before being used for anything.
  Future<void> initialize() async {
    if (isInitialized) return;
    print('$runtimeType initializing...');

    Settings().debugLevel = debugLevel;
    await Settings().init();

    await resourceManager.initialize();

    _state = StudyAppState.initialized;
    info('$runtimeType initialized');
  }

  /// This methods is used to configure the entire app, including:
  ///  * initialize the bloc
  ///  * authenticate the user
  ///  * get the invitation
  ///  * get the informed consent
  ///  * get the study
  ///  * initialize sensing
  ///
  /// This method is used in the [LoadingPage].
  Future<void> configure(BuildContext context) async {
    // make sure to initialize the bloc, if not already done
    // await bloc.initialize();

    // early out if already configuring (e.g. waiting for user authentication)
    if (isConfiguring) return;

    _state = StudyAppState.configuring;
    print('$runtimeType configuring...');

    // force the app to refresh the user credentials and study information?
    if (forceSignOutAndStudyReload) await leaveStudyAndSignOut();

    //  initialize the CARP backend, if needed
    if (deploymentMode != DeploymentMode.LOCAL) {
      await backend.initialize();
      await backend.authenticate(context);

      // check if there is a local deploymed id
      // if not, get a deployment id based on an invitation
      if (bloc.studyDeploymentId == null)
        await backend.getStudyInvitation(context);
    }

    // find the right informed consent, if needed
    bloc.informedConsent = (!hasInformedConsentBeenAccepted)
        ? await resourceManager.getInformedConsent()
        : null;

    // set up the messaging part
    await messageManager.init();
    await getMessages();

    // set up and initialize sensing
    await Sensing().initialize();
    // print(toJsonString(bloc.deployment));

    // initialize the UI data models
    data.init(Sensing().controller!);

    debug('$runtimeType configuration done.');
    _state = StudyAppState.configured;
  }

  /// Called when the informed consent has been accepted by the user.
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  Future<void> informedConsentHasBeenAccepted(
    RPTaskResult informedConsentResult,
  ) async {
    info('Informed consent has been accepted by user.');
    informedConsentAccepted = true;
    if (bloc.deploymentMode != DeploymentMode.LOCAL)
      await backend.uploadInformedConsent(informedConsentResult);
  }

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted =>
      LocalSettings().hasInformedConsentBeenAccepted;

  /// Should the informed consent be shown to the user?
  bool get shouldInformedConsentBeShown =>
      (informedConsent != null && !hasInformedConsentBeenAccepted);

  /// Specify if the informed consent been handled.
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  ///  * successfully uploaded to CARP
  set informedConsentAccepted(bool accepted) =>
      LocalSettings().informedConsentAccepted = accepted;

  Future<void> getMessages() async =>
      _messages ??= await messageManager.messages;

  /// The signed in user. Returns null if no user is signed in.
  CarpUser? get user => backend.user;

  String get username => (user != null)
      ? user!.username
      : Sensing().controller!.masterDeployment!.userId!;

  /// The name used for friendly greating - '' if no user logged in.
  String? get friendlyUsername => (user != null) ? user!.firstName : '';

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning => Sensing().isRunning;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes => (Sensing().controller != null)
      ? Sensing().controller!.executor!.probes
      : [];

  /// Start sensing. Should only be called once.
  /// Use [resume] and [pause] if pausing/resuming sensing.
  Future<void> start() async {
    assert(Sensing().controller != null,
        'No Study Controller - the study has not been deployed.');
    Sensing().controller!.resume();
    _studyStartTimestamp = Sensing().controller!.studyDeploymentStartTime;

    // listening on the data stream and print them as json to the debug console
    Sensing().controller!.data.listen((data) => print(toJsonString(data)));
  }

  // Pause sensing.
  void pause() => Sensing().controller!.pause();

  /// Resume sensing.
  void resume() => Sensing().controller!.resume();

  /// Stop sensing.
  /// Once sensing is stopped, it cannot be (re)started.
  void stop() => Sensing().controller!.stop();

  // Dispose the entire sensing.
  void dispose() => stop();

  /// Add a [Datum] object to the stream of events.
  void addDatum(Datum datum) =>
      Sensing().controller!.executor!.addDataPoint(DataPoint.fromData(datum));

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace? stacktrace]) =>
      Sensing().controller!.executor!.addError(error, stacktrace);

  Future<void> leaveStudy() async {
    if (Sensing().isRunning) Sensing().controller!.stop();
    informedConsentAccepted = false;
    await backend.leaveStudy();
  }

  Future<void> leaveStudyAndSignOut() async {
    await leaveStudy();
    await backend.signOut();
  }
}
