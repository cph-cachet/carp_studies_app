part of '../main.dart';

class ProfilePageViewModel extends ViewModel {
  String get userid => bloc.user?.id ?? bloc.deployment?.userId ?? '';
  String get username => bloc.user?.username ?? '';
  String get firstname => bloc.user?.firstName ?? '';
  String get lastname => bloc.user?.lastName ?? '';
  String get name => '$firstname $lastname';
  String get responsibleEmail =>
      bloc.deployment?.responsible?.email ?? 'cachet@dtu.dk';
  String get studyDeploymentId => bloc.deployment?.studyDeploymentId ?? '';
  String get studyDeploymentTitle =>
      bloc.deployment?.studyDescription?.title ?? '';

  ProfilePageViewModel();
}
