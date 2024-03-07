part of carp_study_app;

/// Handles a connection to the CAWS backend, including configuring the CAWS [app],
/// authentication, storing study IDs, and uploading informed consent.
///
/// Use as a singleton ` CarpBackend()`.
class CarpBackend {
  /// The URL of the CARP Privacy Policy for this app.
  static const String carpPrivacyUrl =
      "https://carp.cachet.dk/privacy-policy-app";

  /// The URL of the official CARP web site.
  static const String carpWebsiteUrl = "https://carp.cachet.dk";

  /// The URIs of the CARP Web Service (CAWS) host for each [DeploymentMode].
  static const Map<DeploymentMode, String> uris = {
    DeploymentMode.dev: 'dev.carp.dk',
    DeploymentMode.test: 'test.carp.dk',
    DeploymentMode.production: 'carp.computerome.dk',
  };

  static final CarpBackend _instance = CarpBackend._();
  factory CarpBackend() => _instance;
  CarpBackend._() : super() {
    // make sure that the json functions are loaded
    CarpMobileSensing.ensureInitialized();
    ResearchPackage.ensureInitialized();
    CognitionPackage.ensureInitialized();
  }

  /// The URI of the CAWS server - depending on deployment mode.
  Uri get uri => Uri(
        scheme: 'https',
        host: uris[bloc.deploymentMode],
        pathSegments: [
          'auth',
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
      studyId: bloc.studyId,
      studyDeploymentId: bloc.studyDeploymentId,
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
    info('$runtimeType - User authenticated - user: $user');
    debug(toJsonString(user));
    return user!;
  }

  /// Refresh authentication token based on the refresh token.
  Future<CarpUser> refresh() async {
    user = await CarpService().refresh();
    info('$runtimeType - User authenticated via refresh - user: $user');
    debug(toJsonString(user));
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

  /// The list of invitation for this user.
  List<ActiveParticipationInvitation> invitations = [];

  Future<List<ActiveParticipationInvitation>> getInvitations() async {
    CarpParticipationService().configureFrom(CarpService());

    invitations =
        await CarpParticipationService().getActiveParticipationInvitations();

    // Filter the invitations to only include those that
    // have a smartphone as a device in [ActiveParticipationInvitation.assignedDevices] list
    // (i.e. the invitation is for a smartphone).
    // This is done to avoid showing invitations for other devices (e.g. [WebBrowser]).
    invitations.removeWhere((invitation) =>
        invitation.assignedDevices
            ?.any((device) => device.device is! Smartphone) ??
        false);

    return invitations;
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
