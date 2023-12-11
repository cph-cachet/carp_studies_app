part of '../main.dart';

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
  final CarpStudyAppViewModel _data = CarpStudyAppViewModel();
  StudyDeploymentStatus? _status;
  final StreamController<StudiesAppState> _stateStream =
      StreamController.broadcast();

  get stateStream => _stateStream;

  List<ActiveParticipationInvitation> invitations = [];

  List<Message> _messages = [];
  final StreamController<int> _messageStreamController =
      StreamController.broadcast();
  List<Message> get messages => _messages;

  /// A stream of event when the list of [messages] is updated.
  /// The data send on the stream is the number of available messages.
  Stream<int> get messageStream => _messageStreamController.stream;

  StudyAppState get state => _state;
  bool get isInitialized => _state.index >= 1;
  bool get isConfiguring => _state.index >= 2;
  bool get isConfigured => _state.index >= 3;

  /// Debug level for the app and CAMS.
  DebugLevel debugLevel;

  /// What kind of deployment are we running - dev, staging, test or production?
  final DeploymentMode deploymentMode;

  // ScaffoldMessenger for showing snack bars
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  get scaffoldKey => _scaffoldKey;
  get scaffoldMessengerState => scaffoldKey.currentState;

  /// Create the BLoC for the app specifying:
  ///  * debug level
  ///  * deployment mode (production, test, dev)
  StudyAppBLoC({
    this.debugLevel = DebugLevel.info,
    this.deploymentMode = DeploymentMode.dev,
  }) : super();

  LocalizationManager get localizationManager => CarpResourceManager();

  LocalizationLoader get localizationLoader =>
      ResourceLocalizationLoader(localizationManager);

  MessageManager get messageManager => CarpResourceManager();

  CarpBackend get backend => _backend;

  /// The id of the currently running study.
  /// Typical set based on an invitation.
  /// `null` if no deployment have been specified.
  String? get studyId => LocalSettings().studyId;
  set studyId(String? id) {
    LocalSettings().studyId = id;
    backend.studyId = id;
  }

  /// The id of the currently running study deployment.
  /// Typical set based on an invitation.
  /// `null` if no deployment have been specified.
  String? get studyDeploymentId => LocalSettings().studyDeploymentId;
  set studyDeploymentId(String? id) {
    LocalSettings().studyDeploymentId = id;
    backend.studyDeploymentId = id;
  }

  /// The role name of the device in the currently running study deployment.
  /// Typical set based on an invitation.
  /// `null` if no deployment have been specified.
  String? get deviceRolename => LocalSettings().deviceRolename;
  set deviceRolename(String? name) => LocalSettings().deviceRolename = name;

  /// The deployment running on this phone.
  SmartphoneDeployment? get deployment => Sensing().controller?.deployment;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus? get status => _status;

  /// When was this study deployed on this phone.
  DateTime? get studyStartTimestamp => deployment?.deployed;

  /// The overall data model for this app
  CarpStudyAppViewModel get data => _data;

  /// Initialize this BLOC. Called before being used for anything.
  Future<void> initialize() async {
    if (isInitialized) return;

    Settings().debugLevel = debugLevel;
    await Settings().init();
    await localizationManager.initialize();

    await backend.initialize();

    stateStream.sink.add(StudiesAppState.initialized);
    info('$runtimeType initialized.');
  }

  /// Set the active study in the app based on an [invitation].
  ///
  /// If the [context] is provided, the translation for this study is re-loaded
  /// and applied in the app.
  void setStudyInvitation(
    ActiveParticipationInvitation invitation, [
    BuildContext? context,
  ]) {
    bloc.studyId = invitation.studyId;
    bloc.studyDeploymentId = invitation.studyDeploymentId;
    bloc.deviceRolename = invitation.assignedDevices?.first.device.roleName;

    info('Invitation received - '
        'study id: ${bloc.studyId}, '
        'deployment id: ${bloc.studyDeploymentId}, '
        'role name: ${bloc.deviceRolename}');

    if (context != null) CarpStudyApp.reloadLocale(context);
  }

  /// This methods is used to configure a study, including:
  ///  * setting up messaging
  ///  * initialize sensing
  ///  * adding the CAMS study
  ///  * initializing the data visualization pages
  Future<void> configureStudy() async {
    // early out if already configured
    if (isConfiguring) return;

    stateStream.sink.add(StudiesAppState.configuring);
    info('$runtimeType configuring...');

    // set up and initialize sensing
    await Sensing().initialize();

    // add the study and configure sensing
    await Sensing().addStudy();

    // initialize the UI data models
    data.init(Sensing().controller!);

    // set up the messaging part
    messageManager.initialize().then(
      (value) {
        refreshMessages();
        // refresh the list of messages on a regular basis
        Timer.periodic(const Duration(minutes: 30), (_) => refreshMessages());
      },
    );

    debug('$runtimeType configuration done.');
    _state = StudyAppState.configured;
  }

  /// Does this app use location permissions?
  bool get usingLocationPermissions =>
      SamplingPackageRegistry().permissions.any((permission) =>
          permission == Permission.location ||
          permission == Permission.locationWhenInUse ||
          permission == Permission.locationAlways);

  /// Configuration of permissions.
  ///
  /// If a [context] is provided, this method also opens the [LocationUsageDialog]
  /// if location permissions are needed and not yet granted.
  Future<void> configurePermissions(BuildContext? context) async {
    if (usingLocationPermissions && context != null) {
      var status = await Permission.locationAlways.status;
      if (!status.isGranted && Platform.isAndroid && context.mounted) {
        await showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black38,
            transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
                  filter: ui.ImageFilter.blur(
                      sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
                  child: FadeTransition(
                    opacity: anim1,
                    child: child,
                  ),
                ),
            pageBuilder: (context, anim1, anim2) => LocationUsageDialog().build(
                  context,
                  "ic.location.content",
                ));
        await LocationManager().requestPermission();
      }
    }
  }

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted =>
      LocalSettings().hasInformedConsentBeenAccepted;

  /// Specify if the informed consent been handled.
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  ///  * successfully uploaded to CARP
  set hasInformedConsentBeenAccepted(bool accepted) =>
      LocalSettings().hasInformedConsentBeenAccepted = accepted;

  /// Refresh the list of messages (news, announcements, articles) to be shown in
  /// the Study Page of the app.
  Future<void> refreshMessages() async {
    try {
      _messages = await messageManager.getMessages();
      _messages.sort((m1, m2) => m1.timestamp.compareTo(m2.timestamp));
      info('Message list refreshed - count: ${_messages.length}');
      _messageStreamController.add(_messages.length);
    } catch (error) {
      warning('Error getting messages - $error');
    }
  }

  /// The signed in user. Returns null if no user is signed in.
  CarpUser? get user => backend.user;

  String get username => (user != null)
      ? user!.username
      : Sensing().controller!.deployment!.userId!;

  /// The name used for friendly greeting - '' if no user logged in.
  String? get friendlyUsername => (user != null) ? user!.firstName : '';

  /// Does this [deployment] have any measures?
  bool hasMeasures() => (deployment == null)
      ? false
      : (deployment!.measures.any((measure) =>
          (measure.type != VideoUserTask.imageType &&
              measure.type != VideoUserTask.videoType &&
              measure.type != AudioUserTask.audioType &&
              measure.type != SurveyUserTask.SURVEY_TYPE)));

  /// Does this [deployment] have the measure of type [type]?
  bool hasMeasure(String type) {
    if (deployment == null) return false;

    try {
      deployment?.measures.firstWhere((measure) => measure.type == type);
    } catch (_) {
      return false;
    }

    return true;
  }

  /// Does this [deployment] have any user tasks?
  bool hasSurveys() => (deployment == null)
      ? false
      : deployment!.tasks.whereType<AppTask>().isNotEmpty;

  /// Does this [deployment] have any connected devices?
  bool hasDevices() =>
      (deployment == null) ? false : deployment!.connectedDevices.isNotEmpty;

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning => Sensing().isRunning;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes => (Sensing().controller != null)
      ? Sensing().controller!.executor.probes
      : [];

  /// Get a list of running devices
  Iterable<DeviceModel> get runningDevices =>
      Sensing().runningDevices!.map((device) => DeviceModel(device));

  /// Map a selected device to the device in the protocol and connect to it.
  void connectToDevice(BluetoothDevice selectedDevice, DeviceManager device) {
    if (device is BTLEDeviceManager) {
      device.btleAddress = selectedDevice.remoteId.str;
      device.btleName = selectedDevice.localName;
    }

    // when the device id is updated, save the deployment
    Sensing().controller?.saveDeployment();

    device.connect();
  }

  /// Start sensing.
  Future<void> start() async {
    assert(Sensing().controller != null,
        'No Study Controller - the study has not been deployed.');
    if (!Sensing().isRunning) Sensing().controller?.start();
  }

  // Stop sensing.
  void stop() => Sensing().controller?.executor.stop();

  // Dispose the entire sensing.
  void dispose() => Sensing().controller?.dispose();

  /// Add a [Measurement] object to the stream of events.
  void addMeasurement(Measurement measurement) =>
      Sensing().controller!.executor.addMeasurement(measurement);

  /// Add a error to the stream of events.
  void addError(Object error, [StackTrace? stacktrace]) =>
      Sensing().controller!.executor.addError(error, stacktrace);

  /// Leave the study deployed on this phone.
  ///
  /// This entails
  ///  * stopping sensing
  ///  * removing the study info from the phone
  ///  * resetting the informed consent flow
  ///  * returning the user to select an invitation for another study
  ///
  /// Note that study deployment information and data is not removed from the
  /// phone. This is stored for later access. Or if the same deployment is
  /// re-deployed on the phone, data from the previous deployment will be
  /// available.
  Future<void> leaveStudy() async {
    _state = StudyAppState.initialized;
    hasInformedConsentBeenAccepted = false;
    await LocalSettings().eraseStudyIds();
    await Sensing().removeStudy();
  }

  /// Leave the study and also sign out the user.
  ///
  /// This entails everything from the [leaveStudy] method plus permanently
  /// deleting all user authentication information from this phone, including
  /// the authentication and refresh tokens.
  Future<void> leaveStudyAndSignOut() async {
    await leaveStudy();
    await backend.signOut();
  }
}
