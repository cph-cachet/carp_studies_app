part of carp_study_app;

/// The page showing the list of devices and online services, ordered as:
///  * The Smartphone device (primary device)
///  * Any hardware devices (connected devices)
///  * Any online services (connected services)
class DeviceListPage extends StatefulWidget {
  static const String route = '/devices';
  const DeviceListPage({super.key});

  @override
  DeviceListPageState createState() => DeviceListPageState();
}

class DeviceListPageState extends State<DeviceListPage> {
  StreamSubscription<BluetoothAdapterState>? bluetoothStateStream;
  BluetoothAdapterState? bluetoothAdapterState;

  final List<DeviceViewModel> _smartphoneDevice = bloc.runningDevices
      .where((element) => element.deviceManager is SmartphoneDeviceManager)
      .toList();

  final List<DeviceViewModel> _hardwareDevices = bloc.runningDevices
      .where((element) =>
          element.deviceManager is HardwareDeviceManager &&
          element.deviceManager is! SmartphoneDeviceManager)
      .toList();
  final List<DeviceViewModel> _onlineServices = bloc.runningDevices
      .where((element) => element.deviceManager is OnlineServiceManager)
      .toList();

  @override
  void initState() {
    super.initState();
    bluetoothStateStream = FlutterBluePlus.adapterState.listen((state) {
      bluetoothAdapterState = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    bluetoothStateStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const CarpAppBarWithProfile(),
              Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locale.translate("pages.devices.message"),
                                    style: aboutCardSubtitleStyle),
                                const SizedBox(height: 15),
                              ])))),
              Expanded(
                  flex: 4,
                  child: CustomScrollView(slivers: [
                    ..._smartphoneDeviceList(locale),
                    if (_hardwareDevices.isNotEmpty)
                      ..._hardwareDevicesList(locale),
                    if (_onlineServices.isNotEmpty)
                      ..._onlineServicesList(locale),
                  ]))
            ])));
  }

  /// The list of smartphones - which is a list with only one smartphone.
  List<Widget> _smartphoneDeviceList(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.phone),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ListenableBuilder(
              listenable: _smartphoneDevice[index],
              builder: (BuildContext context, Widget? widget) => Center(
                      child: StudiesMaterial(
                          child: _cardListBuilder(
                              _smartphoneDevice[index].icon!,
                              _smartphoneDevice[index].phoneInfo['name']!, (
                    "${_smartphoneDevice[index].phoneInfo["model"]!} - ${_smartphoneDevice[index].phoneInfo["version"]!}",
                    _smartphoneDevice[index].batteryLevel ?? 0,
                  ))))),
          childCount: _smartphoneDevice.length,
        )),
      ];

  /// The list of connected hardware devices (like a Polar sensor)
  List<Widget> _hardwareDevicesList(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.devices),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            DeviceViewModel device = _hardwareDevices[index];
            return _devicesPageCardStream(
                device.statusEvents,
                () => _cardListBuilder(
                    device.icon!,
                    locale.translate(device.typeName),
                    (device.name, device.batteryLevel ?? 0),
                    enableFeedback: true,
                    onTap: () async => await _hardwareDeviceClicked(device),
                    trailing: device.getDeviceStatusIcon is String
                        ? Text(
                            locale
                                .translate(device.getDeviceStatusIcon as String)
                                .toUpperCase(),
                            style: aboutCardTitleStyle.copyWith(
                                color: Theme.of(context).primaryColor))
                        : device.getDeviceStatusIcon as Icon),
                DeviceStatus.unknown);
          }, childCount: _hardwareDevices.length),
        ),
      ];

  /// The list of online services (like a Location service)
  List<Widget> _onlineServicesList(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.services),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              DeviceViewModel service = _onlineServices[index];
              return _devicesPageCardStream(
                  service.statusEvents,
                  () => _cardListBuilder(
                        service.icon!,
                        locale.translate(service.typeName),
                        null,
                        trailing: service.getServiceStatusIcon is String
                            ? Text(
                                locale
                                    .translate(
                                        service.getServiceStatusIcon as String)
                                    .toUpperCase(),
                                style: aboutCardTitleStyle.copyWith(
                                    color: Theme.of(context).primaryColor))
                            : service.getServiceStatusIcon as Icon,
                        isThreeLine: false,
                        onTap: () async => await _onlineServiceClicked(service),
                      ),
                  DeviceStatus.unknown);
            },
            childCount: _onlineServices.length,
          ),
        ),
      ];

  Widget _cardListBuilder(
    Icon leading,
    String title,
    (String, int)? subtitle, {
    Widget? trailing,
    void Function()? onTap,
    bool enableFeedback = false,
    bool isThreeLine = true,
  }) =>
      ListTile(
        enableFeedback: enableFeedback,
        isThreeLine: isThreeLine,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [leading],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title),
          ],
        ),
        subtitle: subtitle != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle.$1),
                  BatteryPercentage(batteryLevel: subtitle.$2),
                ],
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (trailing != null) trailing,
          ],
        ),
        onTap: onTap,
      );

  Widget _devicesPageCardStream<T>(
    Stream<T> stream,
    Widget Function() childBuilder,
    T? initialData,
  ) =>
      Center(
        child: StudiesMaterial(
          child: StreamBuilder<T>(
            stream: stream,
            initialData: initialData,
            builder: (context, AsyncSnapshot<T> snapshot) => childBuilder(),
          ),
        ),
      );

  Future<void> _onlineServiceClicked(DeviceViewModel service) async {
    if (service.status == DeviceStatus.connected ||
        service.status == DeviceStatus.connecting) {
      return;
    }

    if (!(await service.deviceManager.hasPermissions())) {
      await service.deviceManager.requestPermissions();
    }
    await service.deviceManager.connect();
  }

  Future<void> _hardwareDeviceClicked(DeviceViewModel device) async {
    // fast out if no Bluetooth
    if (!(await FlutterBluePlus.isSupported)) return;

    // turn on bluetooth if we can
    if (Platform.isAndroid) await FlutterBluePlus.turnOn();

    if (context.mounted) {
      if (bluetoothAdapterState == BluetoothAdapterState.off &&
          Platform.isIOS) {
        await showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (context) => EnableBluetoothDialog(device: device),
        );
      } else if (bluetoothAdapterState == BluetoothAdapterState.on) {
        if (device.status == DeviceStatus.connected ||
            device.status == DeviceStatus.connecting) {
          bool disconnect = await showDialog<bool?>(
                context: context,
                barrierDismissible: true,
                builder: (context) => DisconnectionDialog(device: device),
              ) ??
              false;
          if (disconnect) await device.disconnectFromDevice();
        } else {
          await showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (context) => ConnectionDialog(device: device),
          );
        }
      } else if (bluetoothAdapterState == BluetoothAdapterState.unauthorized &&
          Platform.isIOS) {
        await showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (context) => AuthorizationDialog(device: device),
        );
      }
    }
  }
}
