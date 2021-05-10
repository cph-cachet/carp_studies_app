part of carp_study_app;

enum DeploymentMode {
  /// Use a local study protocol & deployment and store data locally in a file.
  LOCAL,

  /// Get the study deployment from CARP and store data back to CARP
  CARP,
}
