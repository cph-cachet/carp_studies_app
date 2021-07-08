part of carp_study_app;

/// A local resource manager handling:
///  * informed consent
///  * localization
class LocalResourceManager implements ResourceManager {
  RPOrderedTask _informedConsent;

  static final LocalResourceManager _instance = LocalResourceManager._();
  factory LocalResourceManager() => _instance;

  LocalResourceManager._() {
    RPOrderedTask('', []); // to initialize json serialization for RP classes
  }

  @override
  Future initialize() async {}

  @override
  RPOrderedTask get informedConsent => _informedConsent;

  @override
  Future<RPOrderedTask> getInformedConsent() async {
    if (_informedConsent == null) {
      RPConsentSection overviewSection =
          RPConsentSection(RPConsentSectionType.Welcome)
            ..title = 'ic.overview.title'
            ..summary = 'ic.overview.summary'
            ..content = 'ic.overview.content';

      RPConsentSection whoAreWeSection =
          RPConsentSection(RPConsentSectionType.AboutUs)
            ..title = "ic.who.title"
            ..summary = "ic.who.summary"
            ..content = "ic.who.content";

      RPConsentSection tasksSection =
          RPConsentSection(RPConsentSectionType.StudyTasks)
            ..title = "ic.tasks.title"
            ..summary = "ic.tasks.summary"
            ..content = "ic.tasks.summary";

      RPConsentSection durationSection =
          RPConsentSection(RPConsentSectionType.Duration)
            ..title = "ic.duration.title"
            ..summary = "ic.duration.summary"
            ..content = "ic.duration.summary";

      RPConsentSection dataHandlingSection =
          RPConsentSection(RPConsentSectionType.DataHandling)
            ..title = "ic.data.title"
            ..summary = "ic.data.summary"
            ..content = "ic.data.content";

      RPConsentSection rightsSection =
          RPConsentSection(RPConsentSectionType.YourRights)
            ..title = "ic.rights.title"
            ..summary = "ic.rights.summary"
            ..content = "ic.rights.content";

      RPConsentSection summarySection =
          RPConsentSection(RPConsentSectionType.Overview)
            ..title = "ic.summary.title"
            ..summary = "ic.summary.summary"
            ..content = "ic.summary.content";

      RPConsentSignature signature = RPConsentSignature("signatureID");

      RPConsentDocument consentDocument =
          RPConsentDocument('CACHET Research Platfom', [
        overviewSection,
        whoAreWeSection,
        tasksSection,
        durationSection,
        dataHandlingSection,
        rightsSection,
        summarySection,
      ])
            ..addSignature(signature);

      RPConsentReviewStep consentReviewStep =
          RPConsentReviewStep("consentreviewstepID", consentDocument)
            ..title = "ic.review.title"
            ..reasonForConsent = "ic.review.reason"
            ..text = "ic.review.text";

      RPVisualConsentStep consentVisualStep =
          RPVisualConsentStep("visualStep", consentDocument);

      RPCompletionStep completionStep = RPCompletionStep("completionID")
        ..title = "ic.completion.title"
        ..text = "ic.completion.text";

      _informedConsent = RPOrderedTask(
        "consentTaskID",
        [
          consentVisualStep,
          consentReviewStep,
          completionStep,
        ],
        closeAfterFinished: false,
      );
    }
    return _informedConsent;
  }

  @override
  Future<bool> deleteInformedConsent() {
    // TODO: implement deleteInformedConsent
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLocalizations(Locale locale) {
    // TODO: implement deleteLocalizations
    throw UnimplementedError();
  }

  final String basePath = 'assets/lang_local';

  @override
  Future<Map<String, String>> getLocalizations(Locale locale) async {
    String path = '$basePath/${locale.languageCode}.json';
    print("$runtimeType - loading '$path'");
    String jsonString = await rootBundle.loadString(path);

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, String> translations =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return translations;
  }

  @override
  Future<bool> setInformedConsent(RPOrderedTask informedConsent) {
    // TODO: implement setInformedConsent
    throw UnimplementedError();
  }

  @override
  Future<bool> setLocalizations(
      Locale locale, Map<String, dynamic> localizations) {
    // TODO: implement setLocalizations
    throw UnimplementedError();
  }
}
