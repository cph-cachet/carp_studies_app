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
  //late ESenseDevice eSenseDevice;

  String _id = '';

  String? get type => deviceManager.type;
  DeviceStatus get status => deviceManager.status;
  Stream<DeviceStatus> get deviceEvents => deviceManager.statusEvents;

  /// The device ids
  String get id => deviceTypeName[type!] == 'Phone' ? deviceManager.id : _id;

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

  String? get connectionInstructions => deviceConnectionInstructions[type!];

  // /// The icon for the runtime state of this device.
  // Icon? get stateIcon => deviceStateIcon[status];

  set id(String newName) {
    _id = newName;
    ESenseDeviceManager().setDeviceName(newName);
  }

  DeviceModel(this.deviceManager) : super();

  static Map<String, String> get deviceTypeName => {
        Smartphone.DEVICE_TYPE: 'Phone',
        ESenseDevice.DEVICE_TYPE: 'eSense',
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: 'This phone',
        ESenseDevice.DEVICE_TYPE: 'eSense ear plug',
      };
  static Map<String, Icon> get deviceTypeIcon => {
        Smartphone.DEVICE_TYPE: Icon(Icons.phone_android),
        ESenseDevice.DEVICE_TYPE: Icon(Icons.headphones),
      };

  static Map<DeviceStatus, dynamic> get deviceStatusIcon => {
        DeviceStatus.connected: Icon(Icons.done, color: CACHET.GREEN_1),
        DeviceStatus.disconnected: Text("PAIR"), // If its disconnected, ask to pair
        DeviceStatus.paired: Text("CONNECT"), // If its paired, ask to connect
        DeviceStatus.error: Icon(Icons.error_outline, color: CACHET.RED_1),
        // DeviceStatus.sampling: Icon(Icons.save_alt, color: CACHET.BLUE_1),
        DeviceStatus.initialized: Text("READY"),
        DeviceStatus.unknown: Icon(Icons.error_outline, color: CACHET.RED_1),
      };

  static Map<String, String> get deviceConnectionInstructions => {
        Smartphone.DEVICE_TYPE: 'This phone is already connected to the study',
        ESenseDevice.DEVICE_TYPE:
            'Turn on the earbuds by pressing and holding the push button until the LED turns on blue.\n\nThe earbuds are paired to eachother and only one earbud needs to be paired with the phone.\n\nTo pair the eSense with the phone, press the push button until the LED starts blinking blue and red.\n\nOpen the bluetooth settings of the phone and click on the eSense device.\n\nOnce the device is paired, it will indicate so by blinking in blue.\n\nTurn on the earbuds by pressing and holding the push button until the LED turns on blue.\n\nThe earbuds are paired to eachother and only one earbud needs to be paired with the phone.\n\nTo pair the eSense with the phone, press the push button until the LED starts blinking blue and red.\n\nOpen the bluetooth settings of the phone and click on the eSense device.\n\nOnce the device is paired, it will indicate so by blinking in blue.',
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
