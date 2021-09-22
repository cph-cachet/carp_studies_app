/*
 * Copyright 2021 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of carp_study_app;

/// This class implements the sensing layer.
///
/// Call [initialize] to setup a deployment, either locally or using a CARP
/// deployment. Once initialized, the runtime [controller] can be used to
/// control the study execution (e.g., resume, pause, stop).
///
/// Note that this class is a singleton. Only one sensing layer is used.
/// But, CAMS supports that several studies are added to the [client].
class Sensing {
  static final Sensing _instance = Sensing._();
  StudyDeploymentStatus? _status;
  StudyDeploymentController? _controller;

  DeploymentService? deploymentService;
  SmartPhoneClientManager? client;

  /// The deployment running on this phone.
  SmartphoneDeployment? get deployment =>
      _controller?.deployment as SmartphoneDeployment?;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus? get status => _status;

  /// The role name of this device in the deployed study
  String? get deviceRolename => _status?.masterDeviceStatus?.device.roleName;

  /// The study deployment id of the deployment running on this phone.
  String? get studyDeploymentId => _status?.studyDeploymentId;

  /// The study runtime controller for this deployment
  StudyDeploymentController? get controller => _controller;

  /// Is sensing running, i.e. has the study executor been resumed?
  bool get isRunning =>
      (controller != null) && controller!.executor!.state == ProbeState.resumed;

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes =>
      (_controller != null) ? _controller!.executor!.probes : [];

  /// The list of connected devices.
  List<DeviceManager>? get runningDevices =>
      client?.deviceRegistry.devices.values.toList();

  /// The singleton sensing instance
  factory Sensing() => _instance;

  Sensing._() {
    // create and register external sampling packages
    //SamplingPackageRegistry.register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    //SamplingPackageRegistry.register(CommunicationSamplingPackage());
    SamplingPackageRegistry().register(AudioSamplingPackage());
    SamplingPackageRegistry().register(SurveySamplingPackage());
    //SamplingPackageRegistry.register(HealthSamplingPackage());

    // create and register external data managers
    DataManagerRegistry().register(CarpDataManager());

    // register the special-purpose audio user task factory
    AppTaskController().registerUserTaskFactory(AudioUserTaskFactory());
  }

  /// Initialize and set up sensing.
  Future<void> initialize() async {
    info('Initializing $runtimeType - mode: ${bloc.deploymentMode}');

    StudyDescription? description;

    // set up the devices available on this phone
    DeviceController().registerAllAvailableDevices();

    switch (bloc.deploymentMode) {
      case DeploymentMode.LOCAL:
        // use the local, phone-based deployment service
        deploymentService = SmartphoneDeploymentService();

        // get the protocol from the local study protocol manager
        // note that the study id is not used
        StudyProtocol? protocol =
            await (LocalStudyProtocolManager().getStudyProtocol(''));

        // get the local study description
        description = await LocalResourceManager().getStudyDescription();

        // deploy this protocol using the on-phone deployment service
        // re-use the study deployment id - if available
        _status = await SmartphoneDeploymentService().createStudyDeployment(
          protocol!,
          LocalSettings().studyDeploymentId,
        );

        break;
      case DeploymentMode.CARP_PRODUCTION:
      case DeploymentMode.CARP_STAGING:
        assert(CarpService().authenticated,
            'No used is authenticated. Call CarpService().authenticate() before using a CARP deployment service.');
        assert(bloc.backend.studyDeploymentId != null,
            'No study deployment ID is provided. Cannot fetch deployment from CARP');

        // use the CARP deployment service that knows how to download a custom protocol
        deploymentService = CustomProtocolDeploymentService();

        // get the study deployment status
        _status = await CustomProtocolDeploymentService()
            .getStudyDeploymentStatus(bloc.backend.studyDeploymentId!);

        // register the CARP data manager for uploading data back to CARP
        // TODO - check if we can remove this - seems to be done in the CustomProtocolDeploymentService
        DataManagerRegistry().register(CarpDataManager());

        break;
    }

    // store the deployment id locally on the phone
    LocalSettings().studyDeploymentId = studyDeploymentId!;

    // create and configure a client manager for this phone
    client = SmartPhoneClientManager(
      deploymentService: deploymentService,
      deviceRegistry: DeviceController(),
    );
    await client!.configure();

    // add and deploy this deployment
    _controller = await client!.addStudy(studyDeploymentId!, deviceRolename!);

    // set the study description, if available
    deployment!.protocolDescription ??= description;

    // configure the controller
    await _controller!.configure();

    // listening on the data stream and print them as json to the debug console
    _controller!.data.listen((data) => print(toJsonString(data)));

    info('$runtimeType initialized');
  }
}
