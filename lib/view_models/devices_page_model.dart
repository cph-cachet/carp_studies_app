part of carp_study_app;

enum DeviceType {
  PHONE,
  WATCH,
  HEADSET,
  SCALE,
  HOME,
  SPEAKER,
  HEARTRATE_MONITOR,
  UNKNOWN,
}

class DevicesPageViewModel extends ViewModel {
  List<DeviceModel> _devices = [];
  List<DeviceModel> get devices => _devices;
}

class DeviceModel {
  DeviceManager deviceManager;

  String? get type => deviceManager.type;
  DeviceStatus get status => deviceManager.status;

  /// Stream of [DeviceStatus] events
  Stream<DeviceStatus> get deviceEvents => deviceManager.statusEvents;

  /// The device id
  String get id => deviceManager.id;

  /// A printer-friendly name for this device.
  String? get name => deviceTypeName[type!];

  /// A printer-friendly description of this device.
  String get description =>
      '${deviceTypeDescription[type!]} - $statusString\n$batteryLevel% battery remaining.';

  String get statusString => status.toString().split('.').last;

  /// The battery level of this device.
  ///
  /// Only relevant if this device is a [HardwareDeviceManager].
  /// Returns null if not a hardware device.
  int? get batteryLevel => (deviceManager is HardwareDeviceManager)
      ? (deviceManager as HardwareDeviceManager).batteryLevel
      : null;

  /// The icon for this type of device.
  Icon? get icon => deviceTypeIcon[type!];

  /// The icon for the status of device.
  dynamic get statusIcon => deviceStatusIcon[status];

  /// The name for the status of device.
  String? get statusText => deviceStatusText[status];

  String? get connectionInstructions => deviceConnectionInstructions[type!];

  Map<String, String?> get phoneInfo => {
        'name': '${DeviceInfo().deviceID}',
        'model':
            '${DeviceInfo().deviceModel} (${DeviceInfo().deviceManufacturer?.toUpperCase()})',
        'version': 'SDK ${DeviceInfo().sdk}',
      };

  DeviceModel(this.deviceManager) : super();

  static Map<String, String> get deviceTypeName => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.name",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.name",
        AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.name",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.name",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.name",
        // PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.name",
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.description",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.description",
        AirQualityService.DEVICE_TYPE:
            "pages.devices.type.air_quality.description",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.description",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.description",
        // PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.description",
      };

  static Map<String, Icon> get deviceTypeIcon => {
        Smartphone.DEVICE_TYPE: Icon(Icons.phone_android, size: 30),
        WeatherService.DEVICE_TYPE: Icon(Icons.wb_cloudy),
        AirQualityService.DEVICE_TYPE: Icon(Icons.air),
        LocationService.DEVICE_TYPE: Icon(Icons.location_on),
        ESenseDevice.DEVICE_TYPE: Icon(Icons.headphones, size: 30),
        // PolarDevice.DEVICE_TYPE: Icon(Icons.monitor_heart, size: 30),
      };

  static Map<DeviceStatus, dynamic> get deviceStatusIcon => {
        DeviceStatus.initialized: "pages.devices.status.action.connect",
        DeviceStatus.connecting:
            Icon(Icons.sensors_off, color: CACHET.GREEN_1, size: 30),
        DeviceStatus.connected:
            Icon(Icons.sensors, color: CACHET.GREEN_1, size: 30),
        DeviceStatus.disconnected: "pages.devices.status.action.connect",
        DeviceStatus.paired: "pages.devices.status.action.connect",
        DeviceStatus.error:
            Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
        DeviceStatus.unknown:
            Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
      };

  static Map<DeviceStatus, String> get deviceStatusText => {
        DeviceStatus.connecting: "pages.devices.status.connecting",
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
        // PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.instructions",
      };
}
