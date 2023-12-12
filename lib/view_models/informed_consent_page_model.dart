part of '../main.dart';

class InformedConsentViewModel extends ViewModel {
  RPOrderedTask? _informedConsent;

  InformedConsentManager get informedConsentManager => CarpResourceManager();

  InformedConsentViewModel();

  /// Get the informed consent for this study as translated to the
  /// local [locale].
  Future<RPOrderedTask?> getInformedConsent(Locale locale) async {
    await bloc.localizationLoader.load(locale);
    _informedConsent ??= await informedConsentManager.getInformedConsent();
    return _informedConsent;
  }
  // Future<RPOrderedTask?> getInformedConsent(Locale locale) async =>
  //     bloc.localizationLoader.load(locale).then((value) async =>
  //         _informedConsent ??=
  //             await informedConsentManager.getInformedConsent());
  // return _informedConsent ??=
  //     await informedConsentManager.getInformedConsent();

  /// Called when the informed consent has been accepted by the user.
  /// This entails that it has been:
  ///  * shown to the user
  ///  * accepted by the user
  Future<void> informedConsentHasBeenAccepted(
    RPTaskResult informedConsentResult,
  ) async {
    info('Informed consent has been accepted by user.');
    bloc.hasInformedConsentBeenAccepted = true;
    await bloc.backend.uploadInformedConsent(informedConsentResult);
  }
}
