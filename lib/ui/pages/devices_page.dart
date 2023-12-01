part of '../../main.dart';

/// State of Bluetoth connection UI.
enum CurrentStep { scan, instructions, done }

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  DevicesPageState createState() => DevicesPageState();
}

class DevicesPageState extends State<DevicesPage> {
  StreamSubscription? bluetoothStateStream;
  BluetoothAdapterState? bluetoothAdapterState;

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
  void initState() {
    super.initState();
    bluetoothStateStream = FlutterBluePlus.adapterState.listen((event) {
      bluetoothAdapterState = event;
      setState(() {});
      FlutterBluePlus.stopScan();
    });
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
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
              child: CustomScrollView(
                slivers: [
                  ...smartphoneDeviceListWidget(locale),
                  if (physicalDevices.isNotEmpty)
                    ...physicalDevicesListWidget(locale),
                  if (onlineServices.isNotEmpty)
                    ...onlineServicesListWidget(locale),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> smartphoneDeviceListWidget(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.phone),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Center(
              child: StudiesCard(
                child: cardListBuilder(
                  smartphoneDevice[index].icon!,
                  smartphoneDevice[index].phoneInfo['name']!,
                  (
                    "${smartphoneDevice[index].phoneInfo["model"]!} - ${smartphoneDevice[index].phoneInfo["version"]!}",
                    smartphoneDevice[index].batteryLevel ?? 0,
                  ),
                ),
              ),
            );
          }, childCount: smartphoneDevice.length),
        ),
      ];

  List<Widget> physicalDevicesListWidget(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.devices),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            DeviceModel device = physicalDevices[index];
            return devicesPageCardStream(
                device.deviceEvents,
                () => cardListBuilder(
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
                        : device.getDeviceStatusIcon),
                DeviceStatus.unknown);
          }, childCount: physicalDevices.length),
        ),
      ];

  List<Widget> onlineServicesListWidget(RPLocalizations locale) => [
        DevicesPageListTitle(locale: locale, type: DevicesPageTypes.services),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            DeviceModel service = onlineServices[index];
            return devicesPageCardStream(
                service.deviceEvents,
                () => cardListBuilder(
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
                    ),
                DeviceStatus.unknown);
          }, childCount: onlineServices.length),
        ),
      ];

  Widget cardListBuilder(
    Icon leading,
    String title,
    (String, int)? subtitle, {
    Widget? trailing,
    void Function()? onTap,
    enableFeedback = false,
    isThreeLine = true,
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

  Widget devicesPageCardStream<T>(
          Stream<T> stream, Widget Function() childBuilder, T? initialData) =>
      Center(
        child: StudiesCard(
          child: StreamBuilder<T>(
            stream: stream,
            initialData: initialData,
            builder: (context, AsyncSnapshot<T> snapshot) => childBuilder(),
          ),
        ),
      );

  void physicalDeviceClicked(DeviceModel device) async {
    if (await FlutterBluePlus.isSupported == false) {
      warning("Bluetooth not supported by this device");
      return;
    }

    // turn on bluetooth ourself if we can
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    if (bluetoothAdapterState == BluetoothAdapterState.off) {
      // ask user to turn bluetooth on.
      if (!context.mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => EnableBluetoothDialog(device: device),
      );
    } else if (bluetoothAdapterState == BluetoothAdapterState.on) {
      if (!context.mounted) return;
      // open dialog to let user select device
      if (device.status == DeviceStatus.connected ||
          device.status == DeviceStatus.connecting) {
        // open dialog that asks if user wants to disconnect device
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => DisconnectionDialog(device: device),
        );
      } else {
        // open dialog to ask user to connect
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => ConnectionDialog(device: device),
        ).then((value) async {
          await FlutterBluePlus.stopScan();
        });
      }
    } else if (bluetoothAdapterState == BluetoothAdapterState.unauthorized) {
      // open dialog showing user how to allow app to use bluetooth
      if (!context.mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AuthorizationDialog(device: device),
      );
    }
    ;
  }
}
