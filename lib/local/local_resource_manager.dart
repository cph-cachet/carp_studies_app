part of carp_study_app;

/// A local in-memory resource manager handling:
///  * informed consent
///  * localization
///  * messages
///
/// Localization json files should be added to the app as assets in the
/// `assets/lang_local` folder and added to the `pubsepc.yaml` file.
class LocalResourceManager
    implements InformedConsentManager, LocalizationManager, MessageManager {
  RPOrderedTask? _informedConsent;
  final Map<String, Message> _messages = {};

  static final LocalResourceManager _instance = LocalResourceManager._();
  factory LocalResourceManager() => _instance;

  LocalResourceManager._() {
    ResearchPackage.ensureInitialized();

    // add two test messages
    setMessage(Message(
      type: MessageType.announcement,
      title: 'CACHET Research Platform',
      subTitle: '',
      message:
          'Click here to see a description of the CACHET Research Platform (CARP)',
      url: 'https://carp.cachet.dk/',
    ));
    setMessage(Message(
      type: MessageType.article,
      title: "message.1.title",
      subTitle: "message.1.subtitle",
      message: "message.1.message",
      image: 'assets/images/park.png',
      timestamp: DateTime(2022, 12, 14),
    ));
  }

  @override
  Future<void> initialize() async {}

  // INFORMED CONSENT

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

      RPConsentDocument consentDocument = RPConsentDocument(
        title: 'CACHET Research Platform',
        sections: [
          overviewSection,
          whoAreWeSection,
          tasksSection,
          durationSection,
          dataHandlingSection,
          locationSection,
          rightsSection,
          summarySection,
        ],
      )..addSignature(signature);

      RPConsentReviewStep consentReviewStep = RPConsentReviewStep(
        identifier: "consentreviewstepID",
        title: "ic.review.title",
        text: "ic.review.text",
        consentDocument: consentDocument,
        reasonForConsent: "ic.review.reason",
      );

      RPVisualConsentStep consentVisualStep = RPVisualConsentStep(
        identifier: "visualStep",
        consentDocument: consentDocument,
      );

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

  // LOCALIZATION

  /// The path to the language json files to be loaded using this resource manager.
  final String basePath = 'assets/lang_local';

  @override
  Future<Map<String, String>> getLocalizations(Locale locale) async {
    String path = '$basePath/${locale.languageCode}.json';
    String jsonString = await rootBundle.loadString(path);

    Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    var translations =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return translations;
  }

  @override
  Future<bool> setLocalizations(
    Locale locale,
    Map<String, dynamic> localizations,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLocalizations(Locale locale) {
    throw UnimplementedError();
  }

  @override
  bool isSupported(ui.Locale locale) => true;

  // MESSAGES

  @override
  Future<List<Message>> getMessages({
    DateTime? start,
    DateTime? end,
    int? count = 20,
  }) async =>
      _messages.values.toList();

  @override
  Future<Message?> getMessage(String messageId) async => _messages[messageId];

  @override
  Future<void> setMessage(Message message) async =>
      _messages[message.id] = message;

  @override
  Future<void> deleteMessage(String messageId) async =>
      _messages.remove(messageId);

  @override
  Future<void> deleteAllMessages() async => _messages.clear();
}
