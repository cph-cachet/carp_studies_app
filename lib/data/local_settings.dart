part of carp_study_app;

/// A local settings manager.
///
/// Works as a singleton - use `LocalSettings()` for accessing settings.
class LocalSettings {
  // Keys for storing in shared preferences
  static const String userKey = 'user';

  static const String participantKey = 'participant';

  static const String studyKey = 'study';
  static const String informedConsentAcceptedKey = 'informed_consent_accepted';

  static final LocalSettings _instance = LocalSettings._();
  factory LocalSettings() => _instance;
  LocalSettings._() : super();

  CarpUser? _user;

  Participant? _participant;

  SmartphoneStudy? _study;
  bool? _hasInformedConsentBeenAccepted;

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

  /// The study for the currently running study deployment.
  /// The study is cached locally on the phone.
  /// Returns `null` if no study is deployed (yet).
  SmartphoneStudy? get study {
    if (_study != null) return _study;
    var jsonString = Settings().preferences?.getString(studyKey);
    return _study = (jsonString == null)
        ? null
        : _$SmartphoneStudyFromJson(
            json.decode(jsonString) as Map<String, dynamic>);
  }

  set study(SmartphoneStudy? study) {
    assert(
        study != null,
        'Cannot set the study to null in Settings. '
        "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
    _study = study;
    Settings().preferences?.setString(
          studyKey,
          json.encode(_$SmartphoneStudyToJson(study!)),
        );
  }

  /// The study deployment id for the currently running deployment.
  String? get studyDeploymentId => _study?.studyDeploymentId;

  /// Erase all study deployment information cached locally on this phone.
  Future<void> eraseStudyDeployment() async {
    _study = null;
    _hasInformedConsentBeenAccepted = null;
    _participant = null;
    await Settings().preferences!.remove(participantKey);

    await Settings().preferences!.remove(studyKey);
    await Settings().preferences!.remove(informedConsentAcceptedKey);
    debug('$runtimeType - study deployment erased.');
  }

  /// Erase all authentication information on this user from the phone.
  Future<void> eraseAuthCredentials() async {
    _user = null;
    await Settings().preferences!.remove(userKey);
  }

  // Need to create our own JSON serializers here, since SmartphoneStudy is not made serializable
  Map<String, dynamic> _$SmartphoneStudyToJson(SmartphoneStudy study) =>
      <String, dynamic>{
        'studyId': study.studyId,
        'studyDeploymentId': study.studyDeploymentId,
        'deviceRoleName': study.deviceRoleName,
        'participantId': study.participantId,
        'participantRoleName': study.participantRoleName,
      };

  SmartphoneStudy _$SmartphoneStudyFromJson(Map<String, dynamic> json) =>
      SmartphoneStudy(
        studyId: json['studyId'] as String?,
        studyDeploymentId: json['studyDeploymentId'] as String,
        deviceRoleName: json['deviceRoleName'] as String,
        participantId: json['participantId'] as String?,
        participantRoleName: json['participantRoleName'] as String?,
      );

  Future<String?> get deploymentBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getDeploymentBasePath(studyDeploymentId!);

  Future<String?> get cacheBasePath async => (studyDeploymentId == null)
      ? null
      : await Settings().getCacheBasePath(studyDeploymentId!);

  /// Has the informed consent been shown to, and accepted by the user?
  bool get hasInformedConsentBeenAccepted => _hasInformedConsentBeenAccepted ??=
      Settings().preferences!.getBool(informedConsentAcceptedKey) ?? false;

  set hasInformedConsentBeenAccepted(bool accepted) {
    _hasInformedConsentBeenAccepted = accepted;
    Settings().preferences!.setBool(informedConsentAcceptedKey, accepted);
  }
}
