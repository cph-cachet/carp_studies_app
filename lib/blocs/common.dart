part of carp_study_app;

/// Enumeration of different types of deployments on the CARP Web Service (CAWS).
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

/// Enumeration of of different user authentication states.
enum LoginStatus {
  /// No invitation selected (tap outside the invitation box).
  /// Navigate to login screen.
  noSelection,

  /// Informed Consent not accepted.
  /// Navigate to message screen or login.
  noConsent,

  /// User registered but no current ongoing studies.
  /// Navigate to message screen.
  noInvitation,

  /// User temporary blocked based on 3 wrongly login credentials.
  /// Navigate to message screen.
  temporaryBlock,

  /// Successful login.
  /// Navigate to home page.
  successful,
}

enum ProcessStatus {
  done,
  error,
  other,
}

/// Enumeration of different app states.
enum StudiesAppState {
  initialized,
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
