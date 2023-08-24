part of carp_study_app;

/// State of Bluetoth connection UI.
enum CurrentStep { scan, instructions, done }

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  DevicesPageState createState() => DevicesPageState();
}

class DevicesPageState extends State<DevicesPage> {
  StreamSubscription? isScanningStream;
  StreamSubscription? scanResultStream;
  StreamSubscription? bluetoothStateStream;

  List<DeviceModel> physicalDevices = bloc.runningDevices
      .where((element) =>
          element.deviceManager is HardwareDeviceManager &&
          element.deviceManager is! SmartphoneDeviceManager)
      .toList();
  List<DeviceModel> onlineServices = bloc.runningDevices
      .where((element) => element.deviceManager is OnlineServiceManager)
      .toList();

  List<DeviceModel> smartphoneDevice = bloc.runningDevices
      .where((element) => element.deviceManager is SmartphoneDeviceManager)
      .toList();

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    isScanningStream?.cancel();
    scanResultStream?.cancel();
    bluetoothStateStream?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (var element in physicalDevices) {
      element.deviceEvents.listen((event) {
        setState(() {});
      });
    }
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
            const CarpAppBar(),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.translate("pages.devices.message"),
                          style: aboutCardSubtitleStyle),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: StreamBuilder<UserTask>(
                  stream: AppTaskController().userTaskEvents,
                  builder: (context, AsyncSnapshot<UserTask> snapshot) {
                    return CustomScrollView(
                      slivers: [
                        ...smartphoneDeviceListWidget(),
                        if (physicalDevices.isNotEmpty)
                          ...physicalDevicesListWidget(),
                        if (onlineServices.isNotEmpty)
                          ...onlineServicesListWidget(),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> smartphoneDeviceListWidget() {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Text(
              locale.translate("pages.devices.phone.title").toUpperCase(),
              style: dataCardTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor)),
        ),
      ), // Title Widget
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Center(
            child: StudiesCard(
              child: Column(
                children: cardListBuilder(
                  smartphoneDevice[index].icon!,
                  smartphoneDevice[index].phoneInfo['name']!,
                  (
                    "${smartphoneDevice[index].phoneInfo["model"]!} - ${smartphoneDevice[index].phoneInfo["version"]!}",
                    smartphoneDevice[index].batteryLevel ?? 0,
                  ),
                ),
              ),
            ),
          );
        }, childCount: smartphoneDevice.length),
      ), // List of smartphone(s)
    ];
  }

  List<Widget> physicalDevicesListWidget() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return [
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Text(
            locale.translate("pages.devices.devices.title").toUpperCase(),
            style: dataCardTitleStyle.copyWith(
                color: Theme.of(context).primaryColor)),
      )),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          RPLocalizations locale = RPLocalizations.of(context)!;
          DeviceModel device = physicalDevices[index];
          var children = cardListBuilder(
              device.icon!,
              locale.translate(device.name!),
              (device.id, device.batteryLevel ?? 0),
              enableFeedback: true,
              onTap: () => physicalDeviceClicked(device),
              trailing: device.getDeviceStatusIcon is String
                  ? Text(
                      locale
                          .translate(device.getDeviceStatusIcon)
                          .toUpperCase(),
                      style: aboutCardTitleStyle.copyWith(
                          color: Theme.of(context).primaryColor))
                  : device.getDeviceStatusIcon);

          return devicesPageCardStream(
              device.deviceEvents, children, DeviceStatus.unknown);
        }, childCount: physicalDevices.length),
      )
    ];
  }

  List<Widget> onlineServicesListWidget() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Text(
              locale.translate("pages.devices.services.title").toUpperCase(),
              style: dataCardTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor)),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          RPLocalizations locale = RPLocalizations.of(context)!;

          var service = onlineServices[index];
          var children = cardListBuilder(
            service.icon!,
            locale.translate(service.name!),
            null,
            trailing: service.getServiceStatusIcon is String
                ? Text(
                    locale
                        .translate(service.getServiceStatusIcon)
                        .toUpperCase(),
                    style: aboutCardTitleStyle.copyWith(
                        color: Theme.of(context).primaryColor))
                : service.getServiceStatusIcon,
            isThreeLine: false,
          );

          return devicesPageCardStream<DeviceStatus>(
              onlineServices[index].deviceEvents,
              children,
              DeviceStatus.unknown);
        }, childCount: onlineServices.length),
      )
    ];
  }

  Widget _showBatteryPercentage(BuildContext context, int bateryLevel,
      {double scale = 1}) {
    double width = 25 * scale;
    double height = 12 * scale;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      //SizedBox(width: 8),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: width,
          height: height,
          child: Row(children: [
            SizedBox(
                width: bateryLevel != 0 ? bateryLevel * (width * 0.9 / 100) : 0,
                height: height * 0.75,
                child: Container(color: Theme.of(context).primaryColor)),
          ]),
        ),
      ),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: 2,
          height: 4,
        ),
      ),
      const SizedBox(width: 4),
      Text(
        "$bateryLevel%",
      )
    ]);
  }

  List<Widget> cardListBuilder(
    Icon leading,
    String title,
    (String, int)? subtitle, {
    Widget? trailing,
    void Function()? onTap,
    enableFeedback = false,
    isThreeLine = true,
  }) {
    return [
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
                  _showBatteryPercentage(context, subtitle.$2, scale: 0.9),
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
      )
    ];
  }

  Widget devicesPageCardStream<T>(
      Stream<T> stream, List<Widget> children, T? initialData) {
    return Center(
      child: StudiesCard(
        child: StreamBuilder<T>(
          stream: stream,
          initialData: initialData,
          builder: (context, AsyncSnapshot<T> snapshot) => Column(
            children: children,
          ),
        ),
      ),
    );
  }

  void physicalDeviceClicked(DeviceModel device) async {
    if (await FlutterBluePlus.isAvailable == false) {
      warning("Bluetooth not supported by this device");
      return;
    }

    if (device.status == DeviceStatus.connected ||
        device.status == DeviceStatus.connecting) {
      return;
    }

    // turn on bluetooth ourself if we can
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    // wait bluetooth to be on
    await FlutterBluePlus.adapterState
        .where((s) => s == BluetoothAdapterState.on)
        .first;

    // start scanning for BTLE devices
    bool isScanning = false;

    FlutterBluePlus.isScanning.listen((scanBool) => isScanning = scanBool);

    bluetoothStateStream = FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on && !isScanning) {
        FlutterBluePlus.startScan();
        isScanning = true;
      } else {
        // instantly start and stop a scan to turn on the BT adapter
        FlutterBluePlus.startScan();
        FlutterBluePlus.stopScan();
      }
    });

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConnectionDialog(device: device),
    );

    FlutterBluePlus.stopScan();
  }
}
