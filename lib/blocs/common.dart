part of carp_study_app;

enum DeploymentMode {
  /// Use a local study protocol & deployment and store data locally in a file.
  LOCAL,

  /// Use the CARP production server to get the study deployment and store data.
  CARP_PRODUCTION,

  /// Use the CARP staging server to get the study deployment and store data.
  CARP_STAGING,
}

enum LoginStatus {
  /// No invitation selected (tap outside the invitation box) - Navigate to login screen
  NOSELECTION,

  /// Informed Consent not accepted - Navigate to message screen / login
  NOCONSENT,

  /// User registered but no current ongoing studies - Navigate to message screen
  NOINVITATION,

  /// User temproary blocked for introducing the login credentials wrongly 3 times - Navigate to message screen
  TEMPORARYBLOCK,

  /// Successful login - Navigate to home page
  SUCCESSFUL
}
