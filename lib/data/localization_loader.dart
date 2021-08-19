part of carp_study_app;

/// A [LocalizationLoader] that knows how to load localizations from a
/// [ResourceManager].
class ResourceLocalizationLoader implements LocalizationLoader {
  final ResourceManager resourceManager;
  ResourceLocalizationLoader(this.resourceManager);

  @override
  Future<Map<String, String>> load(Locale locale) async {
    Map<String, String> translations = {};
    // if using the CARP resource mananger, the initial call to load will
    // fail since the user is not authenticated - but will re-load later
    try {
      translations = await (resourceManager.getLocalizations(locale) as FutureOr<Map<String, String>>);
      print("$runtimeType - translations for ´$locale' loaded! - $translations");
    } catch (error) {
      print("$runtimeType - could not load translations for '$locale'\n - $error");
    }

    return translations;
  }
}
