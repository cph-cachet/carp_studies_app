part of carp_study_app;

enum DeploymentMode {
  /// Use a local study protocol & deployment and store data locally in a file.
  local,

  /// Use the CARP production server to get the study deployment and store data.
  cawsProduction,

  /// Use the CARP staging server to get the study deployment and store data.
  cawsStaging,

  /// Use the CARP testing server to get the study deployment and store data.
  cawsTest,

  /// Use the CARP development server to get the study deployment and store data.
  cawsDev,
}

enum LoginStatus {
  /// No invitation selected (tap outside the invitation box) - Navigate to login screen
  noSelection,

  /// Informed Consent not accepted - Navigate to message screen / login
  noConsent,

  /// User registered but no current ongoing studies - Navigate to message screen
  noInvitation,

  /// User temproary blocked for introducing the login credentials wrongly 3 times - Navigate to message screen
  temporaryBlock,

  /// Successful login - Navigate to home page
  succesful,
}

enum ProcessStatus {
  done,
  error,
  other,
}
