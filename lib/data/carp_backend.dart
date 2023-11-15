part of carp_study_app;

class CarpBackend {
  /// The URI of the CARP Web Service (CAWS) host.
  static const String cawsUri = "https://cans.cachet.dk";

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

  /// The authenticated user
  CarpUser? get user => CarpService().currentUser;

  /// The URI of the CANS server - depending on deployment mode.
  Uri get uri => Uri(
        scheme: 'https',
        host: 'carp.computerome.dk',
        pathSegments: [
          'auth',
          uris[bloc.deploymentMode]!,
          'realms',
          'Carp',
        ],
      );

  OAuthToken? get oauthToken => LocalSettings().oauthToken;
  set oauthToken(OAuthToken? token) => LocalSettings().oauthToken = token;

  String? get username => LocalSettings().username;
  set username(String? username) => LocalSettings().username = username;

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
      clientId: 'carp-webservices-dart',
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
    if (oauthToken != null) {
      if (oauthToken!.hasExpired) {
        CarpService().refresh();
      }
    }

    info('$runtimeType initialized - app: $app');
  }

  Future<CarpUser> authenticate() async {
    var response = await CarpService().authenticate();

    username = response.username;
    oauthToken = response.token;
    bloc.stateStream.sink.add(StudiesAppState.accessTokenRetrieved);

    CarpParticipationService().configureFrom(CarpService());

    return response;
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
    if (CarpService().authenticated) await CarpService().logout();
    await LocalSettings().eraseAuthCredentials();
  }
}
