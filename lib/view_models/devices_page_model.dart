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

  String _id = '';

  String? get type => deviceManager.type;
  DeviceStatus get status => deviceManager.status;

  /// Stream of [DeviceStatus] events
  Stream<DeviceStatus> get deviceEvents => deviceManager.statusEvents;

  /// The device ids
  String get id => deviceManager.type == Smartphone.DEVICE_TYPE ? deviceManager.id : _id;

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

  set setId(String newId) {
    _id = newId;
    // var eSenseDevice = bloc.deployment.connectedDevices.firstWhere((device) => device is ESenseDevice);
    // eSenseDevice.deviceName = newId;
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
        Smartphone.DEVICE_TYPE: 'Phone',
        ESenseDevice.DEVICE_TYPE: 'eSense',
        WeatherService.DEVICE_TYPE: 'Weather',
        AirQualityService.DEVICE_TYPE: 'Air quality',
        LocationService.DEVICE_TYPE: 'Location',
      };

  static Map<String, String> get deviceTypeDescription => {
        Smartphone.DEVICE_TYPE: 'This phone',
        ESenseDevice.DEVICE_TYPE: 'eSense ear plug',
        WeatherService.DEVICE_TYPE: 'Weather service',
        AirQualityService.DEVICE_TYPE: 'Air quality service',
        LocationService.DEVICE_TYPE: 'Location service',
      };
  static Map<String, Icon> get deviceTypeIcon => {
        Smartphone.DEVICE_TYPE: Icon(Icons.phone_android, size: 30),
        ESenseDevice.DEVICE_TYPE: Icon(Icons.headphones, size: 30),
        WeatherService.DEVICE_TYPE: Icon(Icons.wb_sunny_rounded),
        AirQualityService.DEVICE_TYPE: Icon(Icons.air),
        LocationService.DEVICE_TYPE: Icon(Icons.location_on),
      };

  static Map<DeviceStatus, dynamic> get deviceStatusIcon => {
        DeviceStatus.connected: Text("connected", style: aboutCardTitleStyle.copyWith(color: CACHET.GREEN_1)),
        DeviceStatus.disconnected: Text("CONNECT",
            style: aboutCardTitleStyle.copyWith(color: CACHET.BLUE_1)), // If its disconnected, ask to pair
        DeviceStatus.paired: Text("CONNECT",
            style: aboutCardTitleStyle.copyWith(color: CACHET.BLUE_1)), // If its paired, ask to connect
        DeviceStatus.error: Icon(Icons.error_outline, color: CACHET.RED_1),
        DeviceStatus.initialized: Text("PAIR", style: aboutCardTitleStyle.copyWith(color: CACHET.BLUE_1)),
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
