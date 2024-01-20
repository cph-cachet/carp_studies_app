part of carp_study_app;

class CarpBackend {
  /// The URI of the CARP Web Service (CAWS) host.
  static const String cawsUri = 'carp.computerome.dk';

  /// The URL of the CARP Privacy Policy for this app.
  static const String carpPrivacyUrl =
      "https://carp.cachet.dk/privacy-policy-app";

  /// The URL of the official CARP Web Site.
  static const String carpWebsiteUrl = "https://carp.cachet.dk";

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
  bool get isAuthenticated => CarpService().authenticated;

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

  /// The user logged in, if any.
  CarpUser? get user => LocalSettings().user;
  set user(CarpUser? user) => LocalSettings().user = user;

  String? get username => user?.username;
  OAuthToken? get oauthToken => user?.token;

  String? get studyId => bloc.studyId;
  set studyId(String? id) {
    if (CarpService().isConfigured) CarpService().app.studyId = id;
  }

  String? get studyDeploymentId => bloc.studyDeploymentId;
  set studyDeploymentId(String? id) {
    if (CarpService().isConfigured) CarpService().app.studyDeploymentId = id;
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
    if (user != null) {
      CarpService().currentUser = user;
      if (oauthToken!.hasExpired) {
        try {
          await refresh();
        } catch (error) {
          CarpService().currentUser = null;
          warning('Failed to refresh access token - $error');
        }
      }
    }

    CarpParticipationService().configureFrom(CarpService());

    info('$runtimeType initialized - app: $app');
  }

  Future<CarpUser> authenticate() async {
    user = await CarpService().authenticate();
    return user!;
  }

  Future<CarpUser> refresh() async {
    user = await CarpService().refresh();
    return user!;
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
      bloc.hasInformedConsentBeenAccepted = true;
    } on Exception {
      bloc.hasInformedConsentBeenAccepted = false;
      warning('Informed consent upload failed for username: $username');
    }

    return document;
  }

  Future<void> signOut() async {
    if (CarpService().authenticated) await CarpService().logout();
    await LocalSettings().eraseAuthCredentials();
  }
}
