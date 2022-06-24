part of carp_study_app;

/// A local settings manager. Works as a singleton - use `LocalSettings()`
/// for accessing settings.
class LocalSettings {
  static const String STUDY_DEPLOYMENT_ID_KEY = 'study_deployment_id';

  static final LocalSettings _instance = LocalSettings._();
  factory LocalSettings() => _instance;
  LocalSettings._() : super();

  // Keys for storing in shared preferences
  static const String OAUTH_TOKEN_KEY = 'token';
  static const String USERNAME_KEY = 'username';
  static const String STUDY_ID_KEY = 'study_id';
  static const INFORMED_CONSENT_ACCEPTED_KEY = 'informed_consent_accepted';

  String get _oauthTokenKey =>
      '${Settings().appName}.$OAUTH_TOKEN_KEY'.toLowerCase();
  String get _usernameKey =>
      '${Settings().appName}.$USERNAME_KEY'.toLowerCase();
  String get _studyIdKey => '${Settings().appName}.$STUDY_ID_KEY'.toLowerCase();
  String get _informedConsentAcceptedKey =>
      '$studyDeploymentId.$INFORMED_CONSENT_ACCEPTED_KEY'.toLowerCase();

  OAuthToken? _oauthToken;
  String? _username;
  String? _studyId;
  bool? _hasInformedConsentBeenAccepted;

  OAuthToken? get oauthToken {
    if (_oauthToken == null) {
      String? tokenString = Settings().preferences!.getString(_oauthTokenKey);

      _oauthToken = (tokenString != null)
          ? OAuthToken.fromJson(jsonDecode(tokenString))
          : null;
    }
    return _oauthToken!;
  }

  set oauthToken(OAuthToken? token) {
    _oauthToken = token;
    Settings()
        .preferences!
        .setString(_oauthTokenKey, jsonEncode(token?.toJson()));
  }

  String? get username =>
      (_username ??= Settings().preferences!.getString(_usernameKey));

  set username(String? username) {
    _username = username;
    Settings().preferences!.setString(_usernameKey, username!);
  }

  String? get studyId =>
      (_studyId ??= Settings().preferences!.getString(_studyIdKey));

  set studyId(String? id) {
    _studyId = id;
    Settings().preferences!.setString(_studyIdKey, id!);
  }

  String? _studyDeploymentId;

  /// The study deployment id for the currently running deployment.
  /// Returns the deployment id cached locally on the phone (if available).
  /// Returns `null` if no study is deployed (yet).
  String? get studyDeploymentId => (_studyDeploymentId ??=
      Settings().preferences?.getString(STUDY_DEPLOYMENT_ID_KEY));

  /// Set the study deployment id for the currently running deployment.
  /// This study deployment id will be cached locally on the phone.
  set studyDeploymentId(String? id) {
    assert(
        id != null,
        'Cannot set the study deployment id to null in Settings. '
        "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
    _studyDeploymentId = id;
    Settings().preferences?.setString(STUDY_DEPLOYMENT_ID_KEY, id!);
  }

  /// Erase all study deployment information cached locally on this phone.
  Future<void> eraseStudyDeployment() async {
    _studyDeploymentId = null;
    await Settings().preferences!.remove(STUDY_DEPLOYMENT_ID_KEY);
  }

  Future<String?> get deploymentBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getDeploymentBasePath(studyDeploymentId!);

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted => _hasInformedConsentBeenAccepted ??=
      Settings().preferences!.getBool(_informedConsentAcceptedKey) ?? false;

  /// Specify if the informed consent has been handled.
  set informedConsentAccepted(bool accepted) =>
      Settings().preferences!.setBool(_informedConsentAcceptedKey, accepted);

  Future<void> eraseStudyIds() async {
    _studyId = null;
    _hasInformedConsentBeenAccepted = null;
    await eraseStudyDeployment();
    await Settings().preferences!.remove(_studyIdKey);
    await Settings().preferences!.remove(_informedConsentAcceptedKey);
  }

  Future<void> eraseAuthCredentials() async {
    _username = null;
    _oauthToken = null;
    await Settings().preferences!.remove(_usernameKey);
    await Settings().preferences!.remove(_oauthTokenKey);
  }
}
