part of carp_study_app;

class InformedConsentViewModel extends ViewModel {
  RPOrderedTask? _informedConsent;

  InformedConsentViewModel();

  /// Get the informed consent for this study as translated to the
  /// local [locale].
  Future<RPOrderedTask?> getInformedConsent(Locale locale) async {
    if (_informedConsent == null) {
      await bloc.localizationLoader.load(locale);
      _informedConsent = await bloc.informedConsentManager.getInformedConsent();
    }
    return _informedConsent;
  }

  /// Called when the informed consent has been accepted by the user.
  void informedConsentHasBeenAccepted(
    RPTaskResult informedConsentResult,
  ) =>
      bloc.informedConsentHasBeenAccepted(informedConsentResult);
}
