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
  String? get type => deviceManager.type;
  DeviceStatus get status => deviceManager.status;
  Stream<DeviceStatus> get deviceEvents => deviceManager.statusEvents;

  /// The device id.
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

  // /// The icon for the runtime state of this device.
  // Icon? get stateIcon => deviceStateIcon[status];

  DeviceModel(this.deviceManager) : super();

  static Map<String, String> get deviceTypeName => {
        Smartphone.DEVICE_TYPE: 'Phone',
        ESenseDevice.DEVICE_TYPE: 'eSense',
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: 'This phone',
        ESenseDevice.DEVICE_TYPE: 'eSense ear plug',
      };

  static Map<DeviceType, Icon> get deviceTypeIcon => {
        DeviceType.HEADSET: Icon(Icons.headphones),
        DeviceType.PHONE: Icon(Icons.phone_android),
        DeviceType.WATCH: Icon(Icons.watch),
        DeviceType.HOME: Icon(Icons.home_mini_outlined),
        DeviceType.SPEAKER: Icon(Icons.speaker),
        DeviceType.SCALE: Icon(Icons.monitor_weight_outlined),
        DeviceType.UNKNOWN: Icon(Icons.bluetooth)
      };

// Map<DeviceStatus, String> deviceStateText = {
//   DeviceStatus.connected: "Connected",
//   DeviceStatus.disconnected: "Disconnected",
//   DeviceStatus.paired: "Paired",
//   DeviceStatus.error: "Error",
//   DeviceStatus.sampling: "Sampling",
//   DeviceStatus.unknown: "Unknown"
// };

}

enum DeviceType { WATCH, PHONE, HEADSET, SCALE, HOME, SPEAKER, UNKNOWN }
