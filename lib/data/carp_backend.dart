part of carp_study_app;

// String encode(Object object) =>
//     const JsonEncoder.withIndent(' ').convert(object);

class CarpBackend {
  static const String PROD_URI = "https://cans.cachet.dk:443";
  static const String STAGING_URI = "https://cans.cachet.dk:443/stage";
  static const String CLIENT_ID = "carp";
  static const String CLIENT_SECRET = "carp";

  // SharedPreferences
  static const String OAUTH_TOKEN_KEY = 'token';
  static const String USERNAME_KEY = 'username';
  static const String STUDY_ID_KEY = 'study_id';
  static const String STUDY_DEPLOYMENT_ID_KEY = "study_deployment_id";

  String get _oauthTokenKey =>
      '${Settings().appName}.$OAUTH_TOKEN_KEY'.toLowerCase();
  String get _usernameKey =>
      '${Settings().appName}.$USERNAME_KEY'.toLowerCase();
  String get _studyIdKey => '${Settings().appName}.$STUDY_ID_KEY'.toLowerCase();
  String get _studyDeploymentIdKey =>
      '${Settings().appName}.$STUDY_DEPLOYMENT_ID_KEY'.toLowerCase();

  CarpApp _app;
  OAuthToken _oauthToken;
  String _username;

  CarpApp get app => _app;

  /// The signed in user
  CarpUser get user => CarpService().currentUser;

  String get uri => (bloc.deploymentMode == DeploymentMode.CARP_PRODUCTION)
      ? PROD_URI
      : STAGING_URI;

  String get clientID => CLIENT_ID;
  String get clientSecret => CLIENT_SECRET;

  OAuthToken get oauthToken {
    if (_oauthToken == null) {
      String tokenString = Settings().preferences.getString(_oauthTokenKey);

      _oauthToken = (tokenString != null)
          ? OAuthToken.fromJson(jsonDecode(tokenString))
          : null;
    }
    return _oauthToken;
  }

  set oauthToken(OAuthToken token) {
    _oauthToken = token;
    Settings()
        .preferences
        .setString(_oauthTokenKey, jsonEncode(token.toJson()));
  }

  String get username =>
      _username ??= Settings().preferences.getString(_usernameKey);

  set username(String username) {
    _username = username;
    Settings().preferences.setString(_usernameKey, username);
  }

  String get studyId =>
      app?.studyId ??= Settings().preferences.getString(_studyIdKey);

  set studyId(String id) {
    CarpService().app.studyId = id;
    Settings().preferences.setString(_studyIdKey, id);
  }

  String get studyDeploymentId => app?.studyDeploymentId ??=
      Settings().preferences.getString(_studyDeploymentIdKey);

  set studyDeploymentId(String id) {
    CarpService().app.studyDeploymentId = id;
    Settings().preferences.setString(_studyDeploymentIdKey, id);
  }

  static CarpBackend _instance = CarpBackend._();
  CarpBackend._() : super();

  factory CarpBackend() => _instance;

  Future<void> initialize() async {
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
    info('Authenticating user...');
    if (username != null && oauthToken != null) {
      info('Authenticating with saved token - token: $oauthToken');
      try {
        await CarpService()
            .authenticateWithToken(username: username, token: oauthToken);
      } catch (error) {
        warning('Authentication with saved token unsuccessful - $error');
      }
    }

    if (user == null) {
      info('Authenticating with dialogue - username: $username');
      await CarpService().authenticateWithDialog(context, username: username);
      if (CarpService().authenticated) {
        username = CarpService().currentUser.username;
      }
    }

    info('User authenticated - user: $user');
    // saving token on the phone
    oauthToken = user.token;

    // configure the participation service in order to get the invitations
    CarpParticipationService().configureFrom(CarpService());
  }

  /// Get the study invitation.
  Future<void> getStudyInvitation(BuildContext context) async {
    if (studyId == null || studyDeploymentId == null) {
      ActiveParticipationInvitation _invitation =
          await CarpParticipationService().getStudyInvitation(context);
      debug('CARP Study Invitation: $_invitation');

      studyId = _invitation?.studyId;
      studyDeploymentId = _invitation?.studyDeploymentId;
    }
    info('Study ID: $studyId');
    info('Deployment ID: $studyDeploymentId');
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
    await Settings().preferences.remove(_studyIdKey);
    await Settings().preferences.remove(_studyDeploymentIdKey);
  }

  Future<void> signOut() async {
    print('#1.2.1');
    if (CarpService().authenticated) await CarpService().signOut();
    print('#1.2.2');

    await Settings().preferences.remove(_usernameKey);
    print('#1.2.3');
    await Settings().preferences.remove(_oauthTokenKey);
    print('#1.2.4');
  }
}