part of carp_study_app;

/// A local settings manager. Works as a singleton - use `LocalSettings()`
/// for accessing settings.
class LocalSettings {
  // Keys for storing in shared preferences
  static const String studyIdKey = 'study_id';
  static const String studyDeploymentIdKey = 'study_deployment_id';
  static const String deviceRolenameKey = 'role_name';
  static const String oauthTokenKey = 'token';
  static const String accessTokenKey = 'access_token';
  static const String usernameKey = 'username';
  static const informedConsentAcceptedKey = 'informed_consent_accepted';

  static final LocalSettings _instance = LocalSettings._();
  factory LocalSettings() => _instance;
  LocalSettings._() : super();

  OAuthToken? _oauthToken;
  String? _accessToken;
  String? _studyId;
  String? _studyDeploymentId;
  String? _deviceRolename;
  bool? _hasInformedConsentBeenAccepted;
  String? _username;

  String? get accessToken {
    if (_accessToken == null) {
      String? accessTokenString =
          Settings().preferences!.getString(accessTokenKey);

      _accessToken = (accessTokenString != null) ? accessTokenString : null;
    }
    return _accessToken;
  }

  set accessToken(String? value) {
    _accessToken = value;
    Settings().preferences!.setString(accessTokenKey, value!);
  }

  OAuthToken? get oauthToken {
    if (_oauthToken == null) {
      String? ouathTokenString =
          Settings().preferences!.getString(oauthTokenKey);

      _oauthToken = (ouathTokenString != null)
          ? OAuthToken.fromJson(jsonDecode(ouathTokenString))
          : null;
    }
    return _oauthToken;
  }

  set oauthToken(OAuthToken? token) {
    _oauthToken = token;
    Settings()
        .preferences!
        .setString(oauthTokenKey, jsonEncode(token?.toJson()));
  }

  String? get username =>
      (_username ??= Settings().preferences!.getString(usernameKey));

  set username(String? username) {
    _username = username;
    Settings().preferences!.setString(usernameKey, username!);
  }

  String? get studyId =>
      (_studyId ??= Settings().preferences!.getString(studyIdKey));

  set studyId(String? id) {
    _studyId = id;
    Settings().preferences!.setString(studyIdKey, id!);
  }

  /// The study deployment id for the currently running deployment.
  /// Returns the deployment id cached locally on the phone (if available).
  /// Returns `null` if no study is deployed (yet).
  String? get studyDeploymentId => (_studyDeploymentId ??=
      Settings().preferences?.getString(studyDeploymentIdKey));

  /// Set the study deployment id for the currently running deployment.
  /// This study deployment id will be cached locally on the phone.
  set studyDeploymentId(String? id) {
    assert(
        id != null,
        'Cannot set the study deployment id to null in Settings. '
        "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
    _studyDeploymentId = id;
    Settings().preferences?.setString(studyDeploymentIdKey, id!);
  }

  /// The device role name for the currently running deployment.
  /// Returns the role name cached locally on the phone (if available).
  /// Returns `null` if no study is deployed (yet).
  String? get deviceRolename => (_deviceRolename ??=
      Settings().preferences?.getString(deviceRolenameKey));

  /// Set the device role name for the currently running deployment.
  /// This name will be cached locally on the phone.
  set deviceRolename(String? name) {
    assert(
        name != null,
        'Cannot set the study deployment id to null in Settings. '
        "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
    _deviceRolename = name;
    Settings().preferences?.setString(deviceRolenameKey, name!);
  }

  /// Erase all study deployment information cached locally on this phone.
  Future<void> eraseStudyDeployment() async {
    _studyDeploymentId = null;
    await Settings().preferences!.remove(studyDeploymentIdKey);
    await Settings().preferences!.remove(deviceRolenameKey);
  }

  Future<String?> get deploymentBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getDeploymentBasePath(studyDeploymentId!);

  Future<String?> get cacheBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getCacheBasePath(studyDeploymentId!);

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted => _hasInformedConsentBeenAccepted ??=
      Settings().preferences!.getBool(informedConsentAcceptedKey) ?? false;

  /// Specify if the informed consent has been handled.
  set setHasInformedConsentBeenAccepted(bool accepted) =>
      Settings().preferences!.setBool(informedConsentAcceptedKey, accepted);

  Future<void> eraseStudyIds() async {
    _studyId = null;
    _hasInformedConsentBeenAccepted = null;
    await eraseStudyDeployment();
    await Settings().preferences!.remove(studyIdKey);
    await Settings().preferences!.remove(informedConsentAcceptedKey);
    debug('$runtimeType - study erased.');
  }

  Future<void> eraseAuthCredentials() async {
    _username = null;
    _oauthToken = null;
    await Settings().preferences!.remove(usernameKey);
    await Settings().preferences!.remove(oauthTokenKey);
  }
}
