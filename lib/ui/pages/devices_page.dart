part of carp_study_app;

/// State of Bluetoth connection UI.
enum CurrentStep { scan, instructions, done }

class DevicesPage extends StatefulWidget {
  @override
  DevicesPageState createState() => DevicesPageState();
}

class DevicesPageState extends State<DevicesPage> {
  int selected = 40;
  BluetoothDevice? selectedDevice;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

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

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarpAppBar(),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.translate("pages.devices.message"),
                        style: aboutCardSubtitleStyle),
                    SizedBox(height: 15),
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
                      SliverToBoxAdapter(
                          child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Text(
                            locale
                                .translate("pages.devices.phone.title")
                                .toUpperCase(),
                            style: dataCardTitleStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                      )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return buildSmartphoneDeviceCard(
                              context, smartphoneDevice[index]);
                        }, childCount: smartphoneDevice.length),
                      ),
                      physicalDevices.isEmpty
                          ? SliverToBoxAdapter(child: SizedBox.shrink())
                          : SliverToBoxAdapter(
                              child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              child: Text(
                                  locale
                                      .translate("pages.devices.devices.title")
                                      .toUpperCase(),
                                  style: dataCardTitleStyle.copyWith(
                                      color: Theme.of(context).primaryColor)),
                            )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return buildPhysicalDeviceCard(
                              context,
                              physicalDevices[index],
                              setState,
                              selected,
                              selectedDevice);
                        }, childCount: physicalDevices.length),
                      ),
                      onlineServices.isEmpty
                          ? SliverToBoxAdapter(child: SizedBox.shrink())
                          : SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                child: Text(
                                    locale
                                        .translate(
                                            "pages.devices.services.title")
                                        .toUpperCase(),
                                    style: dataCardTitleStyle.copyWith(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return buildOnlineServiceCard(
                              context, onlineServices[index]);
                        }, childCount: onlineServices.length),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _showBatteryPercentage(BuildContext context, int bateryLevel,
      {double scale = 1}) {
    double width = 25 * scale;
    double height = 12 * scale;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      //SizedBox(width: 8),
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(2)),
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
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: 2,
          height: 4,
        ),
      ),
      SizedBox(width: 4),
      Text(
        bateryLevel.toString() + "%",
      )
    ]);
  }

  Widget buildSmartphoneDeviceCard(BuildContext context, DeviceModel device) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              enableFeedback: false,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [device.icon!],
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(device.phoneInfo["name"]!),
                  ]),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.phoneInfo["model"]! +
                      " - " +
                      device.phoneInfo["version"]!),
                  SizedBox(height: 1),
                  _showBatteryPercentage(context, device.batteryLevel!,
                      scale: 0.9),
                ],
              ),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhysicalDeviceCard(
    BuildContext context,
    DeviceModel device,
    setState,
    selected,
    BluetoothDevice? selectedDevice,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: StreamBuilder<DeviceStatus>(
          stream: device.deviceEvents,
          initialData: DeviceStatus.unknown,
          builder: (context, AsyncSnapshot<DeviceStatus> snapshot) => Column(
            children: [
              ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [device.icon!],
                  ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(locale.translate(device.name!)),
                      ]),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(device.id),
                      SizedBox(height: 1),
                      _showBatteryPercentage(context, device.batteryLevel ?? 0,
                          scale: 0.9),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      device.statusIcon is String
                          ? Text(
                              locale.translate(device.statusIcon).toUpperCase(),
                              style: aboutCardTitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor))
                          : device.statusIcon
                    ],
                  ),
                  onTap: () async {
                    if (device.status != DeviceStatus.connected)
                      await showConnectionDialog(
                        context,
                        CurrentStep.scan,
                        device,
                        setState,
                        selected,
                        selectedDevice,
                      );
                    // when the modal dialog is closed, stop the scan
                    flutterBlue.stopScan();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOnlineServiceCard(BuildContext context, DeviceModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: StreamBuilder<DeviceStatus>(
          stream: device.deviceEvents,
          initialData: DeviceStatus.unknown,
          builder: (context, AsyncSnapshot<DeviceStatus> snapshot) => Column(
            children: [
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [device.icon!],
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(locale.translate(device.name!)),
                    ]),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    device.statusIcon is String
                        ? Text(
                            locale.translate(device.statusIcon).toUpperCase(),
                            style: aboutCardTitleStyle.copyWith(
                                color: Theme.of(context).primaryColor))
                        : device.statusIcon
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showConnectionDialog(
    BuildContext context,
    CurrentStep currentStep,
    DeviceModel device,
    setState,
    selected,
    BluetoothDevice? selectedDevice,
  ) async {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // start scanning for BTLE devices
    flutterBlue.startScan();

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                scrollable: true,
                titlePadding: EdgeInsets.symmetric(vertical: 5),
                insetPadding:
                    EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close),
                            padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          stepTitle(currentStep, device, context),
                        ],
                      ),
                    ),
                  ],
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: currentStep == CurrentStep.scan
                      ? Column(
                          children: [
                            Text(
                              locale.translate(
                                      "pages.devices.connection.step.start.1") +
                                  " " +
                                  locale.translate(device.name!) +
                                  " " +
                                  locale.translate(
                                      "pages.devices.connection.step.start.2"),
                              style: aboutCardContentStyle,
                              textAlign: TextAlign.justify,
                            ),
                            Expanded(
                              child: StreamBuilder<List<ScanResult>>(
                                stream: flutterBlue.scanResults,
                                initialData: [],
                                builder: (context, snapshot) =>
                                    SingleChildScrollView(
                                  child: Column(
                                      children: snapshot.data!
                                          .where((element) =>
                                              element.device.name.isNotEmpty)
                                          .toList()
                                          .asMap()
                                          .entries
                                          .map(
                                            (bluetoothDevice) => ListTile(
                                              selected: bluetoothDevice.key ==
                                                  selected,
                                              title: Text(bluetoothDevice
                                                  .value.device.name),
                                              selectedTileColor:
                                                  Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                              onTap: () {
                                                selectedDevice = bluetoothDevice
                                                    .value.device;
                                                setState(() => selected =
                                                    bluetoothDevice.key);
                                              },
                                            ),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                            Text(
                              locale.translate(
                                      "pages.devices.connection.step.start.3") +
                                  " " +
                                  locale.translate(device.name!) +
                                  "  " +
                                  locale.translate(
                                      "pages.devices.connection.step.start.4") +
                                  " " +
                                  locale.translate(device.name!) +
                                  " " +
                                  locale.translate(
                                      "pages.devices.connection.step.start.5"),
                              style: aboutCardContentStyle,
                              textAlign: TextAlign.justify,
                            )
                          ],
                        )
                      : stepContent(
                          currentStep,
                          device,
                          selectedDevice,
                          context,
                        ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                actions: currentStep == CurrentStep.scan
                    ? [
                        TextButton(
                            child: Text(locale
                                .translate(
                                    "pages.devices.connection.instructions")
                                .toUpperCase()),
                            onPressed: () => setState(() {
                                  currentStep = CurrentStep.instructions;
                                })),
                        TextButton(
                            child: Text(locale
                                .translate("pages.devices.connection.next")
                                .toUpperCase()),
                            onPressed: () {
                              if (selectedDevice != null) {
                                setState(() {
                                  currentStep = CurrentStep.done;
                                });
                              }
                            }),
                      ]
                    : currentStep == CurrentStep.instructions
                        ? [
                            TextButton(
                                child: Text(locale
                                    .translate(
                                        "pages.devices.connection.settings")
                                    .toUpperCase()),
                                onPressed: () =>
                                    OpenSettings.openBluetoothSetting()),
                            TextButton(
                                child: Text(locale
                                    .translate("pages.devices.connection.ok")
                                    .toUpperCase()),
                                onPressed: () => setState(() {
                                      currentStep = CurrentStep.scan;
                                    })),
                          ]
                        : [
                            TextButton(
                                child: Text(locale
                                    .translate("pages.devices.connection.back")
                                    .toUpperCase()),
                                onPressed: () => setState(() {
                                      currentStep = CurrentStep.scan;
                                    })),
                            TextButton(
                                child: Text(locale
                                    .translate("pages.devices.connection.done")
                                    .toUpperCase()),
                                onPressed: () {
                                  flutterBlue.stopScan();
                                  if (selectedDevice != null) {
                                    bloc.connectToDevice(
                                      selectedDevice!,
                                      device.deviceManager,
                                    );
                                    Navigator.of(context).pop();
                                  }
                                }),
                          ]);
          },
        );
      },
    );
  }

  Widget stepTitle(
    CurrentStep currentStep,
    DeviceModel device,
    BuildContext context,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    switch (currentStep) {
      case CurrentStep.scan:
        return Column(
          children: [
            Text(
              locale.translate("pages.devices.connection.step.start.title"),
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
      case CurrentStep.instructions:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              locale.translate("pages.devices.connection.step.how_to.title") +
                  " " +
                  locale.translate(device.name!),
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
      case CurrentStep.done:
        return Column(
          children: [
            Text(
              locale.translate(device.name!) +
                  " " +
                  locale
                      .translate("pages.devices.connection.step.confirm.title"),
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
    }
  }

  Widget confirmDevice(BluetoothDevice? device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Image(
            image: AssetImage('assets/icons/connection_done.png'),
            width: MediaQuery.of(context).size.height * 0.2,
            height: MediaQuery.of(context).size.height * 0.2),
        Text(
          (locale.translate("pages.devices.connection.step.confirm.1") +
                  " '${device?.name}' " +
                  locale.translate("pages.devices.connection.step.confirm.2"))
              .trim(),
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget connectionInstructions(DeviceModel device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                    image: AssetImage('assets/icons/connection.png'),
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  locale.translate(device.connectionInstructions!),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget stepContent(
    CurrentStep currentStep,
    DeviceModel device,
    BluetoothDevice? selectedDevice,
    BuildContext context,
  ) =>
      (currentStep == CurrentStep.instructions)
          ? connectionInstructions(device, context)
          : confirmDevice(selectedDevice, context);
}
