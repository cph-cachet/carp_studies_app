part of carp_study_app;

/// A local in-memory resource manager handling:
///  * informed consent
///  * localization
///  * study descriptions
///
/// Localization json files should be added to the app as assets in the
/// `assets/lang_local` folder and added to the `pubsepc.yaml` file.
class LocalResourceManager implements ResourceManager {
  RPOrderedTask? _informedConsent;
  StudyDescription? _description;

  static final LocalResourceManager _instance = LocalResourceManager._();
  factory LocalResourceManager() => _instance;

  LocalResourceManager._() {
    // to initialize json serialization for RP classes
    RPOrderedTask(identifier: '', steps: []);
  }

  @override
  Future initialize() async {}

  @override
  RPOrderedTask? get informedConsent => _informedConsent;

  @override
  Future<RPOrderedTask?> getInformedConsent() async {
    if (_informedConsent == null) {
      RPConsentSection overviewSection = RPConsentSection(
          type: RPConsentSectionType.Welcome,
          title: 'ic.overview.title',
          summary: 'ic.overview.summary',
          content: 'ic.overview.content');

      RPConsentSection whoAreWeSection = RPConsentSection(
          type: RPConsentSectionType.AboutUs,
          title: "ic.who.title",
          summary: "ic.who.summary",
          content: "ic.who.content");

      RPConsentSection tasksSection = RPConsentSection(
          type: RPConsentSectionType.StudyTasks,
          title: "ic.tasks.title",
          summary: "ic.tasks.summary",
          content: "ic.tasks.summary");

      RPConsentSection durationSection = RPConsentSection(
          type: RPConsentSectionType.Duration,
          title: "ic.duration.title",
          summary: "ic.duration.summary",
          content: "ic.duration.summary");

      RPConsentSection dataHandlingSection = RPConsentSection(
          type: RPConsentSectionType.DataHandling,
          title: "ic.data.title",
          summary: "ic.data.summary",
          content: "ic.data.content");

      RPConsentSection locationSection = RPConsentSection(
          type: RPConsentSectionType.Location,
          title: "ic.location.title",
          summary: "ic.location.summary",
          content: "ic.location.content");

      RPConsentSection rightsSection = RPConsentSection(
          type: RPConsentSectionType.YourRights,
          title: "ic.rights.title",
          summary: "ic.rights.summary",
          content: "ic.rights.content");

      RPConsentSection summarySection = RPConsentSection(
          type: RPConsentSectionType.Overview,
          title: "ic.summary.title",
          summary: "ic.summary.summary",
          content: "ic.summary.content");

      RPConsentSignature signature =
          RPConsentSignature(identifier: "signatureID");

      RPConsentDocument consentDocument =
          RPConsentDocument(title: 'CACHET Research Platfom', sections: [
        overviewSection,
        whoAreWeSection,
        tasksSection,
        durationSection,
        dataHandlingSection,
        locationSection,
        rightsSection,
        summarySection,
      ])
            ..addSignature(signature);

      RPConsentReviewStep consentReviewStep = RPConsentReviewStep(
          identifier: "consentreviewstepID", consentDocument: consentDocument)
        ..title = "ic.review.title"
        ..reasonForConsent = "ic.review.reason"
        ..text = "ic.review.text";

      RPVisualConsentStep consentVisualStep = RPVisualConsentStep(
          identifier: "visualStep", consentDocument: consentDocument);

      RPCompletionStep completionStep = RPCompletionStep(
          identifier: "completionID",
          title: "ic.completion.title",
          text: "ic.completion.text");

      _informedConsent = RPOrderedTask(
        identifier: "consentTaskID",
        steps: [
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
  Future<bool> setInformedConsent(RPOrderedTask informedConsent) async {
    _informedConsent = informedConsent;
    return true;
  }

  @override
  Future<bool> deleteInformedConsent() async {
    _informedConsent = null;
    return true;
  }

  /// The path to the language json files to be loaded using this resource manager.
  final String basePath = 'assets/lang_local';

  @override
  Future<Map<String, String>> getLocalizations(
    Locale locale,
  ) async {
    String path = '$basePath/${locale.languageCode}.json';
    print("$runtimeType - loading '$path'");
    String jsonString = await rootBundle.loadString(path);

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, String> translations =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return translations;
  }

  @override
  Future<bool> setLocalizations(
      Locale locale, Map<String, dynamic> localizations) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLocalizations(Locale locale) {
    throw UnimplementedError();
  }
}
