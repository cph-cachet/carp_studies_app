part of '../main.dart';

enum DeploymentMode {
  /// Use the CARP production server to get the study deployment and store data.
  production,

  /// Use the CARP staging server to get the study deployment and store data.
  staging,

  /// Use the CARP testing server to get the study deployment and store data.
  test,

  /// Use the CARP development server to get the study deployment and store data.
  dev,
}

enum LoginStatus {
  /// No invitation selected (tap outside the invitation box) - Navigate to login screen
  noSelection,

  /// Informed Consent not accepted - Navigate to message screen / login
  noConsent,

  /// User registered but no current ongoing studies - Navigate to message screen
  noInvitation,

  /// User temporary blocked for introducing the login credentials wrongly 3 times - Navigate to message screen
  temporaryBlock,

  /// Successful login - Navigate to home page
  successful,
}

enum ProcessStatus {
  done,
  error,
  other,
}

enum StudiesAppState {
  initialized,
  loginpage,
  authenticating,
  accessTokenRetrieved,
  configuring,
  loading,
  loaded,
  error,
}

extension StringExtension on String {
  String truncateTo(int maxLength) =>
      (length <= maxLength) ? this : '${substring(0, maxLength)}...';
}
