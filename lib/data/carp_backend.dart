part of carp_study_app;

// String encode(Object object) =>
//     const JsonEncoder.withIndent(' ').convert(object);

class CARPBackend {
  static const String PROD_URI = "https://cans.cachet.dk:443";
  // static const String STAGING_URI = "https://cans.cachet.dk:443/stage"; // The staging server
  // static const String TEST_URI = "https://cans.cachet.dk:443/test"; // The testing server
  // static const String DEV_URI = "https://cans.cachet.dk:443/dev"; // The development server
  static const String CLIENT_ID = "carp";
  static const String CLIENT_SECRET = "carp";

  // SharedPreferences
  static const String OAUTH_TOKEN_KEY = 'token';
  static const String USERNAME_KEY = 'username';
  static const String STUDY_ID_KEY = 'study_id';
  static const String STUDY_DEPLOYMENT_ID_KEY = "study_deployment_id";

  String get _oauthTokenKey =>
      '${settings.appName}.$OAUTH_TOKEN_KEY'.toLowerCase();
  String get _usernameKey => '${settings.appName}.$USERNAME_KEY'.toLowerCase();
  String get _studyIdKey => '${settings.appName}.$STUDY_ID_KEY'.toLowerCase();
  String get _studyDeploymentIdKey =>
      '${settings.appName}.$STUDY_DEPLOYMENT_ID_KEY'.toLowerCase();

  CarpApp _app;
  OAuthToken _oauthToken;
  String _username;
  ActiveParticipationInvitation _invitation;
  StudyManager studyManager = LocalStudyManager();
  MessageManager messageManager = LocalMessageManager();

  CarpApp get app => _app;

  /// The signed in user
  CarpUser get user => CarpService().currentUser;

  String get uri => PROD_URI;
  String get clientID => CLIENT_ID;
  String get clientSecret => CLIENT_SECRET;

  OAuthToken get oauthToken {
    if (_oauthToken == null) {
      String tokenString = settings.preferences.getString(_oauthTokenKey);

      _oauthToken = (tokenString != null)
          ? OAuthToken.fromJson(jsonDecode(tokenString))
          : null;
    }
    return _oauthToken;
  }

  set oauthToken(OAuthToken token) {
    _oauthToken = token;
    settings.preferences.setString(_oauthTokenKey, jsonEncode(token.toJson()));
  }

  String get username =>
      _username ??= settings.preferences.getString(_usernameKey);

  set username(String username) {
    _username = username;
    settings.preferences.setString(_usernameKey, username);
  }

  String get studyId =>
      app?.studyId ??= settings.preferences.getString(_studyIdKey);

  set studyId(String id) {
    CarpService().app.studyId = id;
    settings.preferences.setString(_studyIdKey, id);
  }

  String get studyDeploymentId => app?.studyDeploymentId ??=
      settings.preferences.getString(_studyDeploymentIdKey);

  set studyDeploymentId(String id) {
    CarpService().app.studyDeploymentId = id;
    settings.preferences.setString(_studyDeploymentIdKey, id);
  }

  static CARPBackend _instance = CARPBackend._();
  CARPBackend._() : super();

  factory CARPBackend() => _instance;

  Future<void> init() async {
    // await settings.init();
    await studyManager.initialize();
    await messageManager.init();

    _app = CarpApp(
      name: "CANS Production @ DTU",
      uri: Uri.parse(uri),
      oauth: OAuthEndPoint(clientID: CLIENT_ID, clientSecret: CLIENT_SECRET),
    );

    CarpService().configure(app);
    info('$runtimeType initialized');
  }

  /// Authenticate the user like this:
  /// * check if a local username and token is saved on the phone
  /// * if so, use this and try to authenticate
  /// * else authenticate using the username / password dialogue
  /// * if successful, get the invitation & study
  Future<void> authenticate(BuildContext context) async {
    if (username != null && oauthToken != null) {
      await CarpService()
          .authenticateWithToken(username: username, token: oauthToken);
    }

    // if authentication failed
    if (user == null) {
      await CarpService().authenticateWithDialog(context, username: username);
      if (CarpService().authenticated) {
        username = CarpService().currentUser.username;
      }
    }
    info('User authenticated: $user');
    // saving token on the phone
    oauthToken = user.token;
  }

  /// Get the study invitation.
  Future<void> getStudyInvitation(BuildContext context) async {
    if (studyId == null || studyDeploymentId == null) {
      ActiveParticipationInvitation _invitation =
          await CarpService().getStudyInvitation(context);
      debug('CARP Study Invitation: $_invitation');

      studyId = _invitation?.studyId;
      studyDeploymentId = _invitation?.studyDeploymentId;
    }
    info('Study ID: $studyId');
    info('Deployment ID: $studyDeploymentId');
  }

  Future<Study> getStudy() async {
    Study study = await studyManager.getStudy(studyDeploymentId);
    // make sure to set the right study id (deployment id) and username
    study.id = studyDeploymentId;
    study.userId = CarpService().currentUser.username;
    return study;
  }

  Future<ConsentDocument> uploadInformedConsent(RPTaskResult taskResult) async {
    RPConsentSignatureResult signatureResult =
        taskResult.results["consentreviewstepID"].results["signatureID"];
    signatureResult.userID = username;
    Map<String, dynamic> informedConsent = signatureResult.toJson();

    ConsentDocument document;
    try {
      document = await CarpService().createConsentDocument(informedConsent);
      info(
          'Informed consent document uploaded successfully - id: ${document.id}');
      bloc.informedConsentAccepted = true;
    } on Exception catch (e) {
      bloc.informedConsentAccepted = false;
      warning('Informed consent upload failed for username: $username');
      throw e;
    }

    return document;
  }

  Future<void> leaveStudy() async {
    await settings.preferences.remove(_studyIdKey);
    await settings.preferences.remove(_studyDeploymentIdKey);
  }

  Future<void> signOut() async {
    await CarpService().signOut();

    await settings.preferences.remove(_usernameKey);
    await settings.preferences.remove(_oauthTokenKey);
  }
}
