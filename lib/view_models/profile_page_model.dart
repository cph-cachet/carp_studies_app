part of carp_study_app;

class ProfilePageViewModel extends ViewModel {
  String get userId => bloc.user?.id ?? bloc.deployment?.userId ?? '';
  String get username => bloc.user?.username ?? '';
  String get firstName => bloc.user?.firstName ?? '';
  String get lastName => bloc.user?.lastName ?? '';
  String get name => '$firstName $lastName';
  String get responsibleEmail =>
      bloc.deployment?.responsible?.email ?? 'cachet@dtu.dk';
  String get studyDeploymentId => bloc.deployment?.studyDeploymentId ?? '';
  String get studyDeploymentTitle =>
      bloc.deployment?.studyDescription?.title ?? '';

  ProfilePageViewModel();
}
