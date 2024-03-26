part of carp_study_app;

enum DeviceType {
  phone,
  watch,
  headset,
  scale,
  home,
  speaker,
  heartrate,
  unknown,
}

/// The view model for the [DeviceListPage].
class DeviceListPageViewModel extends ViewModel {
  final List<DeviceViewModel> _devices = [];
  List<DeviceViewModel> get devices => _devices;
}

/// The view model for each device - [DeviceManager].
class DeviceViewModel extends ViewModel {
  DeviceManager deviceManager;
  DeviceViewModel(this.deviceManager) : super();

  String? get type => deviceManager.type;

  /// A printer-friendly name for this [type] of device.
  String get typeName =>
      deviceTypeName[type!] ?? 'pages.devices.type.unknown.name';

  DeviceStatus get status => deviceManager.status;
  set status(DeviceStatus status) => deviceManager.status = status;

  /// Stream of [DeviceStatus] events
  Stream<DeviceStatus> get statusEvents => deviceManager.statusEvents;

  /// The device id
  String get id => deviceManager.id;

  /// A printer-friendly name for this device.
  String get name {
  if (deviceManager is BTLEDeviceManager) {
    return (deviceManager as BTLEDeviceManager).btleName;
  } else if (deviceManager is PolarDeviceManager) {
    return (deviceManager as PolarDeviceManager).displayName ?? id;
  } else {
    return id;
  }
}

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

  /// The stream of battery level events.
  ///
  /// Only relevant if this device is a [HardwareDeviceManager].
  /// Returns an empty stream if not a hardware device.
  Stream<int> get batteryEvents => deviceManager is HardwareDeviceManager
      ? (deviceManager as HardwareDeviceManager).batteryEvents
      : const Stream.empty();

  /// The icon for this type of device.
  Icon? get icon => deviceTypeIcon[type!];

  /// The icon for the status of device.
  dynamic get getDeviceStatusIcon => deviceStatusIcon[status];
  dynamic get getServiceStatusIcon => serviceStatusIcon[status];

  /// The name for the status of device.
  String? get statusText => deviceStatusText[status];

  String? get connectionInstructions => deviceConnectionInstructions[type!];

  Map<String, String?> get phoneInfo => {
        'name': '${DeviceInfo().deviceID}',
        'model':
            '${DeviceInfo().deviceModel} (${DeviceInfo().deviceManufacturer?.toUpperCase()})',
        'version': 'SDK ${DeviceInfo().sdk}',
      };

  static Map<String, String> get deviceTypeName => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.name",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.name",
        AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.name",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.name",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.name",
        PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.name",
        MovesenseDevice.DEVICE_TYPE: "pages.devices.type.movesense.name",
        // HealthService.DEVICE_TYPE: "pages.devices.type.health.name",
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.description",
        WeatherService.DEVICE_TYPE: "pages.devices.type.weather.description",
        AirQualityService.DEVICE_TYPE:
            "pages.devices.type.air_quality.description",
        LocationService.DEVICE_TYPE: "pages.devices.type.location.description",
        ESenseDevice.DEVICE_TYPE: "pages.devices.type.esense.description",
        PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.description",
        MovesenseDevice.DEVICE_TYPE: "pages.devices.type.movesense.description",
        // HealthService.DEVICE_TYPE: "pages.devices.type.health.description",
      };

  static Map<String, Icon> get deviceTypeIcon => {
        Smartphone.DEVICE_TYPE: const Icon(
          Icons.phone_android,
          size: 30,
          color: CACHET.GREEN_1,
        ),
        WeatherService.DEVICE_TYPE: const Icon(
          Icons.wb_cloudy,
          color: CACHET.WHITE,
        ),
        AirQualityService.DEVICE_TYPE: const Icon(
          Icons.air,
          color: CACHET.LIGHT_BLUE_2,
        ),
        LocationService.DEVICE_TYPE: const Icon(
          Icons.location_on,
          color: CACHET.GREEN,
        ),
        ESenseDevice.DEVICE_TYPE: const Icon(
          Icons.headphones,
          size: 30,
          color: CACHET.BLUE_1,
        ),
        PolarDevice.DEVICE_TYPE: const Icon(
          Icons.monitor_heart,
          size: 30,
          color: CACHET.RED,
        ),
        MovesenseDevice.DEVICE_TYPE: const Icon(
          Icons.circle,
          size: 30,
          color: CACHET.GREY_1,
        ),
        // HealthService.DEVICE_TYPE: const Icon(
        //   Icons.favorite_rounded,
        //   size: 30,
        //   color: CACHET.RED_1,
        // ),
      };

  static Map<DeviceStatus, dynamic> get deviceStatusIcon => {
        DeviceStatus.initialized: "pages.devices.status.action.connect",
        DeviceStatus.connecting: const Icon(Icons.bluetooth_searching_rounded,
            color: CACHET.DARK_BLUE, size: 30),
        DeviceStatus.connected: const Icon(Icons.bluetooth_rounded,
            color: CACHET.DARK_BLUE, size: 30),
        DeviceStatus.disconnected: "pages.devices.status.action.connect",
        DeviceStatus.paired: "pages.devices.status.action.connect",
        DeviceStatus.error:
            const Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
        DeviceStatus.unknown:
            const Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
      };

  static Map<DeviceStatus, dynamic> get serviceStatusIcon => {
        DeviceStatus.initialized: "pages.devices.status.action.connect",
        DeviceStatus.connecting: const Icon(Icons.sensors_off_rounded,
            color: CACHET.GREEN_1, size: 30),
        DeviceStatus.connected:
            const Icon(Icons.sensors_rounded, color: CACHET.GREEN_1, size: 30),
        DeviceStatus.disconnected: "pages.devices.status.action.connect",
        DeviceStatus.paired: "pages.devices.status.action.connect",
        DeviceStatus.error:
            const Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
        DeviceStatus.unknown:
            const Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
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
        PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.instructions",
        MovesenseDevice.DEVICE_TYPE:
            "pages.devices.type.movesense.instructions",
      };

  /// Map a selected device to the device in the protocol and connect to it.
  void connectToDevice(BluetoothDevice selectedDevice) {
    if (deviceManager is BTLEDeviceManager) {
      (deviceManager as BTLEDeviceManager).btleAddress =
          selectedDevice.remoteId.str;
      (deviceManager as BTLEDeviceManager).btleName =
          selectedDevice.platformName;
    }

    Sensing().controller?.saveDeployment();
    deviceManager.connect();
  }

  /// Disconnect from the currently connected device
  Future<void> disconnectFromDevice() async {
    try {
      await deviceManager.disconnect();

      // Erase BTLE information so the user can connect to another device, if needed.
      if (deviceManager is BTLEDeviceManager) {
        (deviceManager as BTLEDeviceManager).btleAddress = '';
        (deviceManager as BTLEDeviceManager).btleName = '';
      }

      Sensing().controller?.saveDeployment();
    } catch (error) {
      warning(
          "$runtimeType - Error disconnecting to device '${deviceManager.id}' - $error.");
    }
  }
}
