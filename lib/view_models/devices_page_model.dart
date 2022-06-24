part of carp_study_app;

class DevicesPageViewModel extends ViewModel {
  // DevicesPageViewModel();

  // /// The list of scanned bluetooth devices.

  // List<BluetoothDevice> get devices => BluetoothDatum().scanResult;
  // Stream<Datum> get scanDevices => Stream.fromFuture(BluetoothProbe().getDatum());

  // // Get an icon for the device based on its type.  If there is no icon for the device, use a default icon

  List<DeviceModel> _devices = [];
  List<DeviceModel> get devices => _devices;
}

class DeviceModel {
  DeviceManager deviceManager;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //late ESenseDevice eSenseDevice;

  //String _id = bloc.deployment!.connectedDevices.firstWhere((device) => device is deviceManager.type).deviceName;

  String? get type => deviceManager.type;
  DeviceStatus get status => deviceManager.status;

  /// Stream of [DeviceStatus] events
  Stream<DeviceStatus> get deviceEvents => deviceManager.statusEvents;

  /// The device ids
  String get id => deviceManager.id;

  /// A printer-friendly name for this device.
  String? get name => deviceTypeName[type!];

  /// A printer-friendly description of this device.
  //String get description => deviceTypeDescription[type];
  String get description =>
      '${deviceTypeDescription[type!]} - $statusString\n$batteryLevel% battery remaining.';

  String get statusString => status.toString().split('.').last;

  /// The battery level of this device.
  int? get batteryLevel => deviceManager.batteryLevel;

  /// The icon for this type of device.
  Icon? get icon => deviceTypeIcon[type!];

  /// The icon for the status of device.
  dynamic get statusIcon => deviceStatusIcon[status];

  /// The name for the status of device.
  String? get statusText => deviceStatusText[status];

  String? get connectionInstructions => deviceConnectionInstructions[type!];
  // /// The icon for the runtime state of this device.
  // Icon? get stateIcon => deviceStateIcon[status];

  set setId(String newId) {
    ESenseDevice eSenseDevice =
        bloc.deployment!.connectedDevices.firstWhere((device) => device is ESenseDevice) as ESenseDevice;
    eSenseDevice.deviceName = newId;
  }

  // Future<dynamic> get platformDeviceInfo async {
  //   if (Platform.isAndroid) {
  //     return await deviceInfo.androidInfo;
  //   } else if (Platform.isIOS) {
  //     return deviceInfo.iosInfo;
  //   } else
  //     return null;
  // }

  Future<Map<String, String?>> get phoneInfo async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return {
        "name": androidInfo.host,
        "model": androidInfo.model,
        "version": androidInfo.version.baseOS,
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return {
        "name": iosInfo.name,
        "model": iosInfo.model,
        "version": iosInfo.systemName! + " " + iosInfo.systemVersion!,
      };
    } else
      return {
        "name": null,
        "model": null,
        "version": null,
      };
  }

  DeviceModel(this.deviceManager) : super();

  static Map<String, String> get deviceTypeName => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.name",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.name",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.name",
        AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.name",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.name",
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.description",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.description",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.description",
        AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.description",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.description",
      };
  static Map<String, Icon> get deviceTypeIcon => {
        Smartphone.DEVICE_TYPE: Icon(Icons.phone_android, size: 30),
        ESenseDevice.DEVICE_TYPE: Icon(Icons.headphones, size: 30),
        WeatherService.DEVICE_TYPE: Icon(Icons.wb_sunny_rounded),
        AirQualityService.DEVICE_TYPE: Icon(Icons.air),
        LocationService.DEVICE_TYPE: Icon(Icons.location_on),
      };

  static Map<DeviceStatus, dynamic> get deviceStatusIcon => {
        DeviceStatus.connected: Icon(Icons.sensors, color: CACHET.GREEN_1, size: 30),
        DeviceStatus.disconnected: "pages.devices.status.action.connect", // If its disconnected, ask to pair
        DeviceStatus.paired: "pages.devices.status.action.connect", // If its paired, ask to connect
        DeviceStatus.error: Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
        DeviceStatus.initialized: "pages.devices.status.action.pair",
        DeviceStatus.unknown: Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
      };

  static Map<DeviceStatus, String> get deviceStatusText => {
        DeviceStatus.connected: "pages.devices.status.connected",
        DeviceStatus.disconnected: "pages.devices.status.disconnected",
        DeviceStatus.paired: "pages.devices.status.paired",
        DeviceStatus.error: "pages.devices.status.error",
        DeviceStatus.initialized: "pages.devices.status.initialized",
        DeviceStatus.unknown: "pages.devices.status.unknown",
      };

  static Map<String, String> get deviceConnectionInstructions => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.instructions",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.instructions",
      };

  // static Map<DeviceType, Icon> get deviceTypeIcon => {
  //       DeviceType.HEADSET: Icon(Icons.headphones),
  //       DeviceType.PHONE: Icon(Icons.phone_android),
  //       DeviceType.WATCH: Icon(Icons.watch),
  //       DeviceType.HOME: Icon(Icons.home_mini_outlined),
  //       DeviceType.SPEAKER: Icon(Icons.speaker),
  //       DeviceType.SCALE: Icon(Icons.monitor_weight_outlined),
  //       DeviceType.UNKNOWN: Icon(Icons.bluetooth)
  //     };

}

enum DeviceType { WATCH, PHONE, HEADSET, SCALE, HOME, SPEAKER, UNKNOWN }
