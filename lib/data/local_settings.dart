part of carp_study_app;

/// A local settings manager.
///
/// Works as a singleton - use `LocalSettings()` for accessing settings.
class LocalSettings {
  // Keys for storing in shared preferences
  static const String userKey = 'user';
  static const String participantKey = 'participant';

  static final LocalSettings _instance = LocalSettings._();
  factory LocalSettings() => _instance;
  LocalSettings._() : super();

  CarpUser? _user;
  Participant? _participant;

  /// The user saved on this device, if any.
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
    (user != null)
        ? Settings().preferences!.setString(userKey, jsonEncode(user.toJson()))
        : Settings().preferences!.remove(userKey);
  }

  /// The participant saved on this device, if any.
  Participant? get participant {
    if (_participant == null) {
      String? userString = Settings().preferences!.getString(participantKey);

      _participant = (userString != null)
          ? Participant.fromJson(jsonDecode(userString) as Map<String, dynamic>)
          : null;
    }
    return _participant;
  }

  set participant(Participant? participant) {
    _participant = participant;
    (participant != null)
        ? Settings()
            .preferences!
            .setString(participantKey, jsonEncode(participant.toJson()))
        : Settings().preferences!.remove(participantKey);
  }

  // /// The study id for the currently running deployment.
  // /// Returns the study id cached locally on the phone (if available).
  // /// Returns `null` if no study is deployed (yet).
  // String? get studyId => participant?.studyId;

  /// The study deployment id for the currently running deployment.
  /// Returns the deployment id cached locally on the phone (if available).
  /// Returns `null` if no study is deployed (yet).
  String? get studyDeploymentId => participant?.studyDeploymentId;

  // /// The device role name for the currently running deployment.
  // /// Returns the role name cached locally on the phone (if available).
  // /// Returns `null` if no study is deployed (yet).
  // String? get deviceRoleName => participant?.deviceRoleName;

  /// Has the informed consent been shown to, and accepted by the user?
  // bool get hasInformedConsentBeenAccepted =>
  //     participant?.hasInformedConsentBeenAccepted ?? false;

  /// Erase all study deployment information cached locally on this phone.
  Future<void> eraseStudyDeployment() async {
    _participant = null;
    await Settings().preferences!.remove(participantKey);
    debug('$runtimeType - study deployment erased.');
  }

  /// Erase all authentication information on this user from the phone.
  Future<void> eraseAuthCredentials() async {
    _user = null;
    await Settings().preferences!.remove(userKey);
  }

  Future<String?> get deploymentBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getDeploymentBasePath(studyDeploymentId!);

  Future<String?> get cacheBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getCacheBasePath(studyDeploymentId!);
}
