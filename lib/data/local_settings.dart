part of carp_study_app;

/// A local settings manager. Works as a singleton - use `LocalSettings()`
/// for accessing settings.
class LocalSettings {
  // Keys for storing in shared preferences
  static const String studyIdKey = 'study_id';
  static const String studyDeploymentIdKey = 'study_deployment_id';
  static const String deviceRoleNameKey = 'role_name';
  static const String userKey = 'user';
  static const String informedConsentAcceptedKey = 'informed_consent_accepted';

  static final LocalSettings _instance = LocalSettings._();
  factory LocalSettings() => _instance;
  LocalSettings._() : super();

  String? _studyId;
  String? _studyDeploymentId;
  String? _deviceRoleName;
  bool? _hasInformedConsentBeenAccepted;
  CarpUser? _user;

  CarpUser? get user {
    if (_user == null) {
      String? userString = Settings().preferences!.getString(userKey);

      _user = (userString != null)
          ? CarpUser.fromJson(jsonDecode(userString) as Map<String, dynamic>)
          : null;
    }
    return _user;
  }

  set user(CarpUser? user) {
    _user = user;
    Settings().preferences!.setString(userKey, jsonEncode(user!.toJson()));
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
  String? get deviceRoleName => (_deviceRoleName ??=
      Settings().preferences?.getString(deviceRoleNameKey));

  /// Set the device role name for the currently running deployment.
  /// This name will be cached locally on the phone.
  set deviceRoleName(String? name) {
    assert(
        name != null,
        'Cannot set the study deployment id to null in Settings. '
        "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
    _deviceRoleName = name;
    Settings().preferences?.setString(deviceRoleNameKey, name!);
  }

  /// Erase all study deployment information cached locally on this phone.
  Future<void> eraseStudyDeployment() async {
    _studyDeploymentId = null;
    await Settings().preferences!.remove(studyDeploymentIdKey);
    await Settings().preferences!.remove(deviceRoleNameKey);
  }

  Future<String?> get deploymentBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getDeploymentBasePath(studyDeploymentId!);

  Future<String?> get cacheBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getCacheBasePath(studyDeploymentId!);

  /// Has the informed consent been shown to, and accepted by the user?
  /// Is `true` if there is no informed consent.
  bool get hasInformedConsentBeenAccepted => _hasInformedConsentBeenAccepted ??=
      Settings().preferences!.getBool(informedConsentAcceptedKey) ?? false;

  /// Specify if the informed consent has been handled.
  set hasInformedConsentBeenAccepted(bool accepted) {
    _hasInformedConsentBeenAccepted = accepted;
    Settings().preferences!.setBool(informedConsentAcceptedKey, accepted);
  }

  Future<void> eraseStudyIds() async {
    _studyId = null;
    _hasInformedConsentBeenAccepted = null;
    await eraseStudyDeployment();
    await Settings().preferences!.remove(studyIdKey);
    await Settings().preferences!.remove(informedConsentAcceptedKey);
    debug('$runtimeType - study erased.');
  }

  Future<void> eraseAuthCredentials() async {
    _user = null;
    await Settings().preferences!.remove(userKey);
  }
}
