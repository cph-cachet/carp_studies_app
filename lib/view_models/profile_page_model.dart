part of carp_study_app;

class ProfilePageViewModel extends ViewModel {
  String get username => bloc.user?.username ?? '';
  String get userId => bloc.user?.id ?? bloc.deployment?.userId ?? '';
  String get firstName => bloc.user?.firstName ?? '';
  String get lastName => bloc.user?.lastName ?? '';
  String get fullName => '$firstName $lastName';
  String get email => bloc.user?.email ?? '';
  String get studyId => bloc.deployment?.studyId ?? '';
  String get studyDeploymentId => bloc.deployment?.studyDeploymentId ?? '';
  String get studyDeploymentTitle =>
      bloc.deployment?.studyDescription?.title ?? '';
  String get participantId => 'PARTICIPANT ID. THIS IS MISSING';
  String get participantRole => 'PARTICIPANT ROLE. THIS IS MISSING';
  String get deviceRole => 'DEVICE ROLE. THIS IS MISSING';
  String get responsibleEmail =>
      bloc.deployment?.responsible?.email ?? 'cachet@dtu.dk';

  ProfilePageViewModel();
}
