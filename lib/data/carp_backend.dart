part of carp_study_app;

/// Handles a connection to the CAWS backend, including configuring the CAWS [app],
/// authentication, storing study IDs, and uploading informed consent.
///
/// Use as a singleton ` CarpBackend()`.
class CarpBackend {
  /// The URI of the CARP Web Service (CAWS) host.
  static const String cawsUri = 'carp.computerome.dk';

  /// The URL of the CARP Privacy Policy for this app.
  static const String carpPrivacyUrl =
      "https://carp.cachet.dk/privacy-policy-app";

  /// The URL of the official CARP web site.
  static const String carpWebsiteUrl = "https://carp.cachet.dk";

  static const Map<DeploymentMode, String> uris = {
    DeploymentMode.dev: 'dev',
    DeploymentMode.test: 'test',
    DeploymentMode.staging: 'stage',
    DeploymentMode.production: '',
  };

  static final CarpBackend _instance = CarpBackend._();
  factory CarpBackend() => _instance;
  CarpBackend._() : super() {
    // make sure that the json functions are loaded
    CarpMobileSensing.ensureInitialized();
    CognitionPackage.ensureInitialized();
  }

  /// The URI of the CANS server - depending on deployment mode.
  Uri get uri => Uri(
        scheme: 'https',
        host: cawsUri,
        pathSegments: [
          'auth',
          uris[bloc.deploymentMode]!,
          'realms',
          'Carp',
        ],
      );

  /// The CAWS app configuration.
  CarpApp? app;

  /// Initialize this backend. Must be called before used.
  Future<void> initialize() async {
    info('$runtimeType - initializing');

    app = CarpApp(
      name: "CAWS @ DTU",
      uri: uri.replace(pathSegments: [uris[bloc.deploymentMode]!]),
      authURL: uri,
      clientId: 'studies-app',
      redirectURI: Uri.parse('carp-studies-auth://auth'),
      discoveryURL: uri.replace(pathSegments: [
        ...uri.pathSegments,
        '.well-known',
        'openid-configuration'
      ]),
      studyId: studyId,
      studyDeploymentId: studyDeploymentId,
    );

    CarpService().configure(app!);

    // check if there is a user stored locally on the phone
    if (user != null) {
      info('$runtimeType - User stored locally - user: $user');
      CarpService().currentUser = user;
      if (oauthToken!.hasExpired) {
        try {
          await refresh();
        } catch (error) {
          CarpService().currentUser = null;
          warning('$runtimeType - Failed to refresh access token - $error');
        }
      }
    }

    CarpParticipationService().configureFrom(CarpService());

    info('$runtimeType initialized - app: $app');
  }

  /// Authenticate using a web view.
  Future<CarpUser> authenticate() async {
    user = await CarpService().authenticate();
    info('$runtimeType - user authenticated - user: $user');
    return user!;
  }

  /// Refresh authentication token based on the refresh token.
  Future<CarpUser> refresh() async {
    user = await CarpService().refresh();
    info('$runtimeType - user authenticated via refresh - user: $user');
    return user!;
  }

  /// Sign out from CAWS and erase all local authentication information.
  Future<void> signOut() async {
    if (CarpService().authenticated) await CarpService().logout();
    await LocalSettings().eraseAuthCredentials();
  }

  /// Has the user been authenticated?
  bool get isAuthenticated => CarpService().authenticated;

  /// The user authenticated, if any.
  CarpUser? get user => LocalSettings().user;
  set user(CarpUser? user) => LocalSettings().user = user;

  /// The user name of the user, if authenticated.
  String? get username => user?.username;
  OAuthToken? get oauthToken => user?.token;

  /// The study ID of the running study, if deployed.
  String? get studyId => bloc.studyId;
  set studyId(String? id) {
    if (CarpService().isConfigured) CarpService().app.studyId = id;
  }

  /// The study deployment ID of the running study, if deployed.
  String? get studyDeploymentId => bloc.studyDeploymentId;
  set studyDeploymentId(String? id) {
    if (CarpService().isConfigured) CarpService().app.studyDeploymentId = id;
  }

  /// Upload the result of an informed consent flow.
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
      bloc.hasInformedConsentBeenAccepted = true;
    } on Exception {
      bloc.hasInformedConsentBeenAccepted = false;
      warning('Informed consent upload failed for username: $username');
    }

    return document;
  }
}
