part of carp_study_app;

class CarpBackend {
  /// The URI of the CARP Web Service (CAWS) host.
  static const String cawsUri = "https://cans.cachet.dk";

  /// The URL of the CARP Privacy Policy for this app.
  static const String carpPrivacyUrl =
      "https://carp.cachet.dk/privacy-policy-app";

  /// The URL of the official CARP Web Site.
  static const String carpWebsiteUrl = "https://carp.cachet.dk";

  // TODO - take into account deployment mode

  /// The URI for the web-based authentication.
  WebUri get loginUri => WebUri(
      'https://cans.cachet.dk/portal/playground/?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/login?redirect=carp.studies://auth');

  /// The URI for the web-based registration of users.
  WebUri get registerUri => WebUri(
      'https://cans.cachet.dk/portal/playground/register?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/register?redirect=carp.studies://auth');

  static const Map<DeploymentMode, String> uris = {
    DeploymentMode.dev: 'dev',
    DeploymentMode.test: 'test',
    DeploymentMode.staging: 'stage',
    DeploymentMode.production: '',
  };

  static final CarpBackend _instance = CarpBackend._();

  String get clientId => "carp";
  String get clientSecret => "carp";

  /// The CAWS app configuration.
  CarpApp? app;

  /// Has the user been authenticated?
  bool? get isAuthenticated => user != null;

  /// The authenticated user
  CarpUser? get user => CarpService().currentUser;

  /// The URI of the CANS server - depending on deployment mode.
  Uri get uri => Uri(
        scheme: 'https',
        host: 'cans.cachet.dk',
        pathSegments: [
          uris[bloc.deploymentMode]!,
        ],
      );

  OAuthToken? get oauthToken => LocalSettings().oauthToken;
  set oauthToken(OAuthToken? token) => LocalSettings().oauthToken = token;

  String? get username => LocalSettings().username;
  set username(String? username) => LocalSettings().username = username;

  String? get studyId => bloc.studyId;
  set studyId(String? id) {
    if (CarpService().isConfigured) CarpService().app!.studyId = id;
  }

  String? get studyDeploymentId => bloc.studyDeploymentId;
  set studyDeploymentId(String? id) {
    if (CarpService().isConfigured) CarpService().app!.studyDeploymentId = id;
  }

  CarpBackend._() : super() {
    // make sure that the json functions are loaded
    CarpMobileSensing.ensureInitialized();
    CognitionPackage.ensureInitialized();
  }

  factory CarpBackend() => _instance;

  Future<void> initialize() async {
    app = CarpApp(
      name: "CAWS @ DTU",
      uri: uri,
      oauth: OAuthEndPoint(clientID: clientId, clientSecret: clientSecret),
      studyId: studyId,
      studyDeploymentId: studyDeploymentId,
    );

    CarpService().configure(app!);

    if (oauthToken != null) {
      // if we have a token, we can authenticate the user
      await authenticateWithRefreshToken(oauthToken!.refreshToken);
    }
    info('$runtimeType initialized - app: $app');
  }

  Future<CarpUser?> authenticateWithRefreshToken(String refreshToken) async {
    try {
      CarpUser user =
          await CarpService().authenticateWithRefreshToken(refreshToken);

      info('User authenticated - user: $user');

      // saving username & token on the phone
      username = user.username;
      oauthToken = user.token;
      bloc.stateStream.sink.add(StudiesAppState.accessTokenRetrieved);

      // configure the participation service in order to get the invitations
      CarpParticipationService().configureFrom(CarpService());
      return user;
    } on Exception catch (error) {
      warning(
          '$runtimeType - error authenticating based on refresh token - $error');
      return null;
    }
  }

  Future<ConsentDocument?> uploadInformedConsent(
      RPTaskResult taskResult) async {
    RPConsentSignatureResult signatureResult =
        (taskResult.results["consentreviewstepID"] as RPConsentSignatureResult);
    signatureResult.userID = username;
    Map<String, dynamic> informedConsent = signatureResult.toJson();

    ConsentDocument? document;
    try {
      document = await CarpService().createConsentDocument(informedConsent);
      info(
          'Informed consent document uploaded successfully - id: ${document.id}');
      bloc.setHasInformedConsentBeenAccepted = true;
    } on Exception {
      bloc.setHasInformedConsentBeenAccepted = false;
      warning('Informed consent upload failed for username: $username');
    }

    return document;
  }

  Future<void> signOut() async {
    if (CarpService().authenticated) await CarpService().signOut();
    await LocalSettings().eraseAuthCredentials();
  }
}
