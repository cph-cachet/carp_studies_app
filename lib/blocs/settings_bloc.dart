part of carp_study_app;

class SettingsBLoC {
  static const String USER_ID_KEY = "user_id";
  static const String INSTALL_DATE_KEY = "install_date";
  static const String COMPLETED_TASKS_KEY = "completed_tasks";
  static const String STUDY_START_KEY = "study_start";

  SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> get preferences async =>
      _preferences ??= await SharedPreferences.getInstance();

  String _userId;
  DateTime _studyStartTimestamp;

  /// Generate a unique anonymous user id.
  ///
  /// This id is stored on the phone in-between sessions and should therefore
  /// be the same for the same phone.
  Future<String> get userId async {
    if (_userId == null) {
      _userId = (await preferences).get(USER_ID_KEY);
      if (_userId == null) {
        _userId = Uuid().v4();
        (await preferences).setString(USER_ID_KEY, _userId);
      }
    }
    return _userId;
  }

  /// The timestamp when the current study was started on this phone.
  ///
  /// This timestamp is save on the phone and hence only set the
  /// first time a study is started.
  Future<DateTime> get studyStartTimestamp async {
    if (_studyStartTimestamp == null) {
      String str = (await preferences).get(STUDY_START_KEY);
      _studyStartTimestamp = DateTime.parse(str);
      if (_studyStartTimestamp == null) {
        _studyStartTimestamp = DateTime.now();
        (await preferences).setString(
            STUDY_START_KEY, _studyStartTimestamp.toUtc().toString());
      }
    }
    return _studyStartTimestamp;
  }

  String get studyId => "2";

  /// The CARP username.
  String get username => "researcher@example.com";

  /// The CARP password.
  String get password =>
      "..."; //decrypt("lkjhf98sdvhcksdmnfewoiywefhowieyurpo2hjr");

  /// The URI of the CARP server.
  String get uri => "http://staging.carp.cachet.dk:8080";

  String get clientID => "carp";
  String get clientSecret => "carp";
}

final settings = SettingsBLoC();
