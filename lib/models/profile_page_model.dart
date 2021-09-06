part of carp_study_app;

class ProfilePageModel extends DataModel {
  String get userid => bloc.user?.accountId ?? '';
  String get username => bloc.user?.username ?? '';
  String get firstname => bloc.user?.firstName ?? '';
  String get lastname => bloc.user?.lastName ?? '';
  String get responsibleEmail =>
      bloc.deployment?.responsible?.email ?? 'cachet@dtu.dk';
  String get studyTitle => bloc.deployment?.protocolDescription?.title ?? '';

  ProfilePageModel();
}
