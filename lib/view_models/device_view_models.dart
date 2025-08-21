part of carp_study_app;

/// The view model for the [DeviceListPage].
class DeviceListPageViewModel extends ViewModel {
  final List<DeviceViewModel> _devices = [];
  List<DeviceViewModel> get devices => _devices;
}

/// The view model for each device - [DeviceManager].
///
/// Note that the [deviceManager] can represent both a hardware device and
/// an online service.
class DeviceViewModel extends ViewModel {
  DeviceManager deviceManager;
  DeviceViewModel(this.deviceManager) : super();

  /// The type of this device.
  String? get type => deviceManager.type;

  /// A printer-friendly name for this [type] of device.
  String get typeName =>
      _deviceTypeName[type!] ?? 'pages.devices.type.unknown.name';

  /// The status of this device.
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
      return (deviceManager as PolarDeviceManager).displayName ?? '';
    } else {
      return id;
    }
  }

  /// A printer-friendly description of this device.
  String get description =>
      '${_deviceTypeDescription[type!]} - ${status.name}\n$batteryLevel% battery remaining.';

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
  Icon? get icon => _deviceTypeIcon[type!];

  /// The icon or string for the status of this hardware device.
  dynamic get getDeviceStatusIcon => _deviceStatusIcon[status];

  /// The icon or string for the status of service.
  dynamic get getServiceStatusIcon => _serviceStatusIcon[status];

  /// The name for the status of device.
  String? get statusText => _deviceStatusText[status];

  /// Instructions to the user on how to connect to this type of device.
  String? get connectionInstructions => _deviceConnectionInstructions[type!];

  String? get connectionInstructionsImage =>
      _deviceConnectionInstructionsImage[type!];

  PolarDeviceType get polarDeviceType {
    if (deviceManager is PolarDeviceManager) {
      return (deviceManager as PolarDeviceManager).configuration?.deviceType ??
          PolarDeviceType.UNKNOWN;
    } else {
      return PolarDeviceType.UNKNOWN;
    }
  }

  MovesenseDeviceType get movesenseDeviceType {
    if (deviceManager is MovesenseDeviceManager) {
      return (deviceManager as MovesenseDeviceManager)
              .configuration
              ?.deviceType ??
          MovesenseDeviceType.UNKNOWN;
    } else {
      return MovesenseDeviceType.UNKNOWN;
    }
  }

  /// Display information about this phone.
  Map<String, String?> get phoneInfo => {
        'name': '${DeviceInfo().deviceID}',
        'model':
            '${DeviceInfo().deviceModel} (${DeviceInfo().deviceManufacturer?.toUpperCase()})',
        'version': 'SDK ${DeviceInfo().sdk}',
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

const Map<String, String> _deviceTypeName = {
  Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.name",
  PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.name",
  MovesenseDevice.DEVICE_TYPE: "pages.devices.type.movesense.name",
  CortriumDevice.DEVICE_TYPE: "pages.devices.type.cortrium.name",
  WeatherService.DEVICE_TYPE: "pages.devices.type.weather.name",
  AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.name",
  LocationService.DEVICE_TYPE: "pages.devices.type.location.name",
  HealthService.DEVICE_TYPE: "pages.devices.type.health.name",
};

const Map<String, String> _deviceTypeDescription = {
  Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.description",
  PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.description",
  MovesenseDevice.DEVICE_TYPE: "pages.devices.type.movesense.description",
  CortriumDevice.DEVICE_TYPE: "pages.devices.type.cortrium.description",
  WeatherService.DEVICE_TYPE: "pages.devices.type.weather.description",
  AirQualityService.DEVICE_TYPE: "pages.devices.type.air_quality.description",
  LocationService.DEVICE_TYPE: "pages.devices.type.location.description",
  HealthService.DEVICE_TYPE: "pages.devices.type.health.description",
};

const Map<String, Icon> _deviceTypeIcon = {
  Smartphone.DEVICE_TYPE: Icon(
    Icons.phone_android,
    size: 30,
    color: CACHET.GREEN_1,
  ),
  WeatherService.DEVICE_TYPE: Icon(
    Icons.wb_cloudy,
    color: CACHET.BLUE_1,
  ),
  AirQualityService.DEVICE_TYPE: Icon(
    Icons.air,
    color: CACHET.LIGHT_BLUE,
  ),
  LocationService.DEVICE_TYPE: Icon(
    Icons.location_on,
    color: CACHET.GREEN,
  ),
  PolarDevice.DEVICE_TYPE: Icon(
    Icons.monitor_heart,
    size: 30,
    color: CACHET.RED,
  ),
  MovesenseDevice.DEVICE_TYPE: Icon(
    Icons.circle,
    size: 30,
    color: CACHET.GREY_1,
  ),
  HealthService.DEVICE_TYPE: Icon(
    Icons.favorite_rounded,
    size: 30,
    color: CACHET.RED_1,
  ),
  CortriumDevice.DEVICE_TYPE: Icon(
    Icons.monitor_heart_outlined,
    size: 30,
    color: CACHET.RED_1,
  ),
};

const Map<DeviceStatus, dynamic> _deviceStatusIcon = {
  DeviceStatus.initialized: "pages.devices.status.action.connect",
  DeviceStatus.connecting: Icon(Icons.bluetooth_searching_rounded,
      color: CACHET.DARK_BLUE, size: 30),
  DeviceStatus.connected:
      Icon(Icons.bluetooth_rounded, color: CACHET.GREEN_1, size: 30),
  DeviceStatus.disconnected: "pages.devices.status.action.connect",
  DeviceStatus.paired: "pages.devices.status.action.connect",
  DeviceStatus.error: Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
  DeviceStatus.unknown:
      Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
};

const Map<DeviceStatus, dynamic> _serviceStatusIcon = {
  DeviceStatus.initialized: "pages.devices.status.action.connect",
  DeviceStatus.connecting:
      Icon(Icons.sensors_off_rounded, color: CACHET.GREEN_1, size: 30),
  DeviceStatus.connected:
      Icon(Icons.sensors_rounded, color: CACHET.GREEN_1, size: 30),
  DeviceStatus.disconnected: "pages.devices.status.action.connect",
  DeviceStatus.paired: "pages.devices.status.action.connect",
  DeviceStatus.error: Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
  DeviceStatus.unknown:
      Icon(Icons.error_outline, color: CACHET.RED_1, size: 30),
};

const Map<DeviceStatus, String> _deviceStatusText = {
  DeviceStatus.connecting: "pages.devices.status.connecting",
  DeviceStatus.connected: "pages.devices.status.connected",
  DeviceStatus.disconnected: "pages.devices.status.disconnected",
  DeviceStatus.paired: "pages.devices.status.paired",
  DeviceStatus.error: "pages.devices.status.error",
  DeviceStatus.initialized: "pages.devices.status.initialized",
  DeviceStatus.unknown: "pages.devices.status.unknown",
};

const Map<String, String> _deviceConnectionInstructions = {
  Smartphone.DEVICE_TYPE: "pages.devices.type.smartphone.instructions",
  PolarDevice.DEVICE_TYPE: "pages.devices.type.polar.instructions",
  MovesenseDevice.DEVICE_TYPE: "pages.devices.type.movesense.instructions",
  CortriumDevice.DEVICE_TYPE: "pages.devices.type.cortrium.instructions",
};

const Map<String, String> _deviceConnectionInstructionsImage = {
  Smartphone.DEVICE_TYPE: "assets/icons/connection_done.png",
  PolarDevice.DEVICE_TYPE: "assets/instructions/polar_instructions.png",
  MovesenseDevice.DEVICE_TYPE: "assets/instructions/movesense_instructions.png",
  CortriumDevice.DEVICE_TYPE: "assets/instructions/cortrium_instructions.png",
};
