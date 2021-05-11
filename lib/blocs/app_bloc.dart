part of carp_study_app;

class AppBLoC {
  static const INFORMED_CONSENT_ACCEPTED_KEY = 'informed_consent_accepted';

  final CarpBackend _backend = CarpBackend();
  // CAMSMasterDeviceDeployment _deployment;
  final CarpStydyAppDataModel _data = CarpStydyAppDataModel();
  StudyDeploymentStatus _status;
  // StudyProtocol _protocol;
  DateTime _studyStartTimestamp;
  List<Message> _messages;

  /// What kind of deployment are we running - local or CARP?
  DeploymentMode deploymentMode = DeploymentMode.LOCAL;

  /// The informed consent to be shown to the user for this study.
  RPOrderedTask informedConsent;

  MessageManager messageManager = LocalMessageManager();

  CarpBackend get backend => _backend;

  String get studyDeploymentId => deployment?.studyDeploymentId;

  /// The deployment running on this phone.
  CAMSMasterDeviceDeployment get deployment => Sensing().controller?.deployment;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus get status => _status;

  DateTime get studyStartTimestamp => _studyStartTimestamp;
  List<Message> get messages => _messages;

  /// The overall data model for this app
  CarpStydyAppDataModel get data => _data;

  String get _informedConsentAcceptedKey =>
      '${Settings().appName}.$INFORMED_CONSENT_ACCEPTED_KEY'.toLowerCase();

  AppBLoC() : super();

  Future<void> initialize([DeploymentMode deploymentMode]) async {
    this.deploymentMode = deploymentMode ?? DeploymentMode.LOCAL;
    Settings().debugLevel = DebugLevel.DEBUG;
    await Settings().init();
    info('$runtimeType initialized');
  }

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted =>
      Settings().preferences.getBool(_informedConsentAcceptedKey) ?? false;

  /// Has the informed consent been handled?
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  ///  * successfully uploaded to CARP
  set informedConsentAccepted(bool accepted) =>
      Settings().preferences.setBool(_informedConsentAcceptedKey, accepted);

  Future<void> getMessages() async =>
      _messages ??= await messageManager?.messages;

  /// The signed in user. Returns null if no user is signed in.
  CarpUser get user => backend?.user;

  /// The name used for friendly greating - '' if no user logged in.
  String get friendlyUsername => (user != null) ? user.firstName : '';

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning => Sensing().isRunning;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes => (Sensing().controller != null)
      ? Sensing().controller.executor.probes
      : [];

  /// Start sensing. Should only be called once.
  /// Use [resume] and [pause] if pausing/resuming sensing.
  Future<void> start() async {
    Sensing().controller.resume();
    _studyStartTimestamp = await Settings().studyStartTimestamp;

    // listening on the data stream and print them as json to the debug console
    Sensing().controller.data.listen((data) => print(toJsonString(data)));
  }

  // Pause sensing.
  void pause() => Sensing().controller.pause();

  /// Resume sensing.
  void resume() => Sensing().controller.resume();

  /// Stop sensing.
  /// Once sensing is stopped, it cannot be (re)started.
  void stop() => Sensing().controller.stop();

  // Dispose the entire sensing.
  void dispose() => stop();

  /// Add a [Datum] object to the stream of events.
  void addDatum(Datum datum) =>
      Sensing().controller.executor.addDataPoint(DataPoint.fromData(datum));

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace stacktrace]) =>
      Sensing().controller.executor.addError(error, stacktrace);

  Future<void> leaveStudy() async {
    Sensing().controller.stop();
    bloc.informedConsentAccepted = false;
    await backend.leaveStudy();
  }

  Future<void> leaveStudyAndSignOut() async {
    await leaveStudy();
    await backend.signOut();
  }
}

final bloc = AppBLoC();
