part of carp_study_app;

class InformedConsentViewModel extends ViewModel {
  RPOrderedTask? _informedConsent;

  InformedConsentManager get informedConsentManager => CarpResourceManager();

  InformedConsentViewModel();

  Future<RPOrderedTask?> get informedConsent async =>
      _informedConsent ??= await informedConsentManager.getInformedConsent();

  /// Called when the informed consent has been accepted by the user.
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  Future<void> informedConsentHasBeenAccepted(
    RPTaskResult informedConsentResult,
  ) async {
    info('Informed consent has been accepted by user.');
    bloc.setHasInformedConsentBeenAccepted = true;
    await bloc.backend.uploadInformedConsent(informedConsentResult);
  }
}
