part of carp_study_app;

class InformedConsentViewModel extends ViewModel {
  Future<RPOrderedTask> get informedConsent async {
    bloc.informedConsent = await bloc.informedConsentManager.getInformedConsent();
    return bloc.informedConsent!;
  }

  InformedConsentViewModel();
}