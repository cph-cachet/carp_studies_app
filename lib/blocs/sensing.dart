part of carp_study_app;

/// This class implements the sensing layer.
///
/// Call [initialize] to setup a deployment using a CARP deployment.
/// Once initialized, use the [addStudy] method to add the study to this runtime.
/// The runtime [controller] can be used to control the study execution
/// (i.e., start or stop).
///
/// Note that this class is a singleton and only one sensing layer is used.
/// Hence, the current assumption at the moment is that this Study App only
/// runs one study at a time, even though CAMS supports that several studies
/// added to the [client].
class Sensing {
  static final Sensing _instance = Sensing._();
  StudyDeploymentStatus? _status;
  SmartphoneDeploymentController? _controller;
  DeploymentService? deploymentService;
  Study? _study;

  /// The study running on this phone.
  /// Only available after [addStudy] is called.
  Study? get study => _study;

  /// The deployment running on this phone.
  /// Only available after [addStudy] is called.
  SmartphoneDeployment? get deployment => _controller?.deployment;

  /// The latest status of the study deployment.
  StudyDeploymentStatus? get status => _status;

  /// The role name of this device in the deployed study.
  String? get deviceRoleName => _study?.deviceRoleName;

  /// The study deployment id of the deployment running on this phone.
  String? get studyDeploymentId => _study?.studyDeploymentId;

  /// The study runtime for this deployment.
  SmartphoneDeploymentController? get controller => _controller;

  /// Is sensing running, i.e. has the study executor been started?
  bool get isRunning =>
      (controller != null) &&
      controller!.executor.state == ExecutorState.started;

  /// The list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes =>
      (_controller != null) ? _controller!.executor.probes : [];

  /// The list of connected devices.
  List<DeviceManager>? get runningDevices =>
      SmartPhoneClientManager().deviceController.connectedDevices;

  /// The singleton sensing instance.
  factory Sensing() => _instance;

  Sensing._() {
    // create and register external sampling packages
    //SamplingPackageRegistry().register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    //SamplingPackageRegistry.register(CommunicationSamplingPackage());
    SamplingPackageRegistry().register(MediaSamplingPackage());
    SamplingPackageRegistry().register(SurveySamplingPackage());
    SamplingPackageRegistry().register(ESenseSamplingPackage());
    SamplingPackageRegistry().register(PolarSamplingPackage());
    SamplingPackageRegistry().register(HealthSamplingPackage());

    // create and register external data managers
    DataManagerRegistry().register(CarpDataManagerFactory());

    // register the special-purpose audio user task factory
    AppTaskController().registerUserTaskFactory(AppUserTaskFactory());
  }

  /// Initialize and set up sensing.
  Future<void> initialize() async {
    info('Initializing $runtimeType');

    // set up the devices available on this phone
    DeviceController().registerAllAvailableDevices();

    // Use the CARP deployment service which can download a protocol from CAWS
    CarpDeploymentService().configureFrom(CarpService());
    deploymentService = CarpDeploymentService();

    // Register the CARP data manager for uploading data back to CARP.
    // This is needed in both LOCAL and CARP deployments, since a local study
    // protocol may still upload to CARP
    DataManagerRegistry().register(CarpDataManagerFactory());

    // Create and configure a client manager for this phone
    await SmartPhoneClientManager().configure(
      deploymentService: deploymentService,
      deviceController: DeviceController(),
      askForPermissions: false,
    );

    info('$runtimeType initialized');
  }

  /// Add and deploy the study, and configure the study runtime (sampling).
  Future<void> addStudy() async {
    assert(SmartPhoneClientManager().isConfigured,
        'The client manager is not yet configured. Call SmartPhoneClientManager().configure() before adding a study.');
    assert(bloc.studyDeploymentId != null,
        'No study deployment ID is provided. Cannot start deployment w/o an id.');

    // Define the study and add it to the client.
    _study = await SmartPhoneClientManager().addStudy(
      bloc.studyDeploymentId!,
      bloc.deviceRoleName!,
    );

    // Get the study controller and try to deploy the study.
    //
    // Note that if the study has already been deployed on this phone
    // it has been cached locally in a file and the local cache will
    // be used pr. default.
    // If not deployed before (i.e., cached) the study deployment will be
    // fetched from the deployment service.
    _controller = SmartPhoneClientManager().getStudyRuntime(study!);
    await controller?.tryDeployment(useCached: true);

    // Configure the controller
    await controller?.configure();

    // Listening on the data stream and print them as json to the debug console
    controller?.measurements
        .listen((measurement) => debug(toJsonString(measurement)));

    info('$runtimeType study added: $studyDeploymentId');
  }

  Future<void> removeStudy() async {
    if (study != null) await SmartPhoneClientManager().removeStudy(study!);
  }

  /// Translate the title and description of all AppTask in the study protocol
  /// of the current master deployment.
  void translateStudyProtocol(AssetLocalizations localization) {
    // fast out, if not configured or no protocol
    if (controller?.status != StudyStatus.Deployed ||
        controller?.deployment == null) return;

    for (var task in controller!.deployment!.tasks) {
      if (task.runtimeType == AppTask) {
        AppTask appTask = task as AppTask;
        appTask.title = localization.translate(appTask.title);
        appTask.description = localization.translate(appTask.description);
      }
    }

    info("Study protocol translated to locale '${localization.locale}'");
  }

  Future<void> askForPermissions() async =>
      await SmartPhoneClientManager().askForAllPermissions();
}
