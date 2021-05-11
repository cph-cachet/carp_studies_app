part of carp_study_app;

enum DeploymentMode {
  /// Use a local study protocol & deployment and store data locally in a file.
  LOCAL,

  /// Use the CARP production server to get the study deployment and store data.
  CARP_PRODUCTION,

  /// Use the CARP stagging server to get the study deployment and store data.
  CARP_STAGGING,
}
