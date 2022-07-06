part of carp_study_app;

class DevicesPage extends StatefulWidget {
  // final DevicesPageViewModel model;
  // const DevicesPage(this.model);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int selected = 40;
  dynamic selectedDevice;

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    List<DeviceModel> physicalDevice = bloc.runningDevices
        .where((element) =>
            element.deviceManager is HardwareDeviceManager &&
            element.deviceManager is! SmartphoneDeviceManager)
        .toList();
    List<DeviceModel> onlineService =
        bloc.runningDevices.where((element) => element.deviceManager is OnlineServiceManager).toList();

    List<DeviceModel> smartphoneDevice =
        bloc.runningDevices.where((element) => element.deviceManager is SmartphoneDeviceManager).toList();

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
                    Text(locale.translate("pages.devices.message"), style: aboutCardSubtitleStyle),
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
                  print('>> $snapshot');
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Text(locale.translate("pages.devices.phone.title").toUpperCase(),
                            style: dataCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                      )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return _buildSmartphoneDeviceCard(context, smartphoneDevice[index]);
                        }, childCount: smartphoneDevice.length),
                      ),
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Text(locale.translate("pages.devices.devices.title").toUpperCase(),
                            style: dataCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                      )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return _buildPhysicalDeviceCard(
                              context, physicalDevice[index], setState, selected, selectedDevice);
                        }, childCount: physicalDevice.length),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Text(locale.translate("pages.devices.services.title").toUpperCase(),
                              style: dataCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return _buildOnlineDeviceCard(context, onlineService[index]);
                        }, childCount: onlineService.length),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 2.0,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget _showBateryPercentage(BuildContext context, int bateryLevel, {double scale = 1}) {
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

Widget _buildPhysicalDeviceCard(
    BuildContext context, DeviceModel device, setState, selected, selectedDevice) {
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
                    _showBateryPercentage(context, device.batteryLevel!, scale: 0.9),
                  ],
                ),
                isThreeLine: true,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    device.statusIcon is String
                        ? Text(locale.translate(device.statusIcon).toUpperCase(),
                            style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor))
                        : device.statusIcon
                  ],
                ),
                onTap: () async {
                  if (device.status != DeviceStatus.connected)
                    await _showConnectionDialog(context, 1, device, setState, selected, selectedDevice);
                }),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSmartphoneDeviceCard(BuildContext context, DeviceModel device) {
  return Center(
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: FutureBuilder<Map<String, String?>>(
          future: device.phoneInfo,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return Column(
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
                          Text(snapshot.data!["name"]!),
                        ]),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!["model"]! + " - " + snapshot.data!["version"]!),
                        SizedBox(height: 1),
                        _showBateryPercentage(context, device.batteryLevel!, scale: 0.9),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                ],
              );
            }
          }),
    ),
  );
}

Widget _buildOnlineDeviceCard(BuildContext context, DeviceModel device) {
  RPLocalizations locale = RPLocalizations.of(context)!;
  return Center(
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: StreamBuilder<DeviceStatus>(
        stream: device.deviceEvents,
        initialData: DeviceStatus.unknown,
        builder: (context, AsyncSnapshot<DeviceStatus> snapshot) => Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              enableFeedback: false,
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    device.icon!,
                    Text(locale.translate(device.name!)),
                  ]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(locale.translate(device.statusString)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future _showConnectionDialog(
    BuildContext context, _currentStep, DeviceModel device, setState, selected, selectedDevice) async {
  RPLocalizations locale = RPLocalizations.of(context)!;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  // Start Scanning devices
  flutterBlue.startScan();

  print(flutterBlue.connectedDevices);
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
              scrollable: true,
              titlePadding: EdgeInsets.symmetric(vertical: 5),
              insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 40),
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
                        stepTitle(_currentStep, device, context),
                      ],
                    ),
                  ),
                ],
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _currentStep == 1
                    ? Column(
                        children: [
                          Text(
                            locale.translate("pages.devices.connection.step.start.1") +
                                " " +
                                locale.translate(device.name!) +
                                " " +
                                locale.translate("pages.devices.connection.step.start.2"),
                            style: aboutCardContentStyle,
                            textAlign: TextAlign.justify,
                          ),
                          Expanded(
                            child: StreamBuilder<List<ScanResult>>(
                              stream: flutterBlue.scanResults,
                              initialData: [],
                              builder: (context, snapshot) => SingleChildScrollView(
                                child: Column(
                                    children: snapshot.data!
                                        .where((element) => element.device.name.isNotEmpty)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map(
                                          (bluetoothDevice) => ListTile(
                                            selected: bluetoothDevice.key == selected,
                                            title: Text(bluetoothDevice.value.device.name),
                                            onTap: () {
                                              selectedDevice = bluetoothDevice.value.device;
                                              device.setId = bluetoothDevice.value.device.name;
                                              setState(() => selected = bluetoothDevice.key);
                                            },
                                          ),
                                        )
                                        .toList()),
                              ),
                            ),
                          ),
                          Text(
                            locale.translate("pages.devices.connection.step.start.3") +
                                " " +
                                locale.translate(device.name!) +
                                "  " +
                                locale.translate("pages.devices.connection.step.start.4") +
                                " " +
                                locale.translate(device.name!) +
                                " " +
                                locale.translate("pages.devices.connection.step.start.5"),
                            style: aboutCardContentStyle,
                            textAlign: TextAlign.justify,
                          )
                        ],
                      )
                    : stepContent(_currentStep, device, flutterBlue, context),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 25),
              // actions: stepActions(_currentStep, setState, device, context),
              actions: _currentStep == 0
                  ? [
                      TextButton(
                          child: Text(locale.translate("pages.devices.connection.next").toUpperCase()),
                          onPressed: () => {
                                setState(() {
                                  _currentStep = 1;
                                })
                              }
                          //settings
                          ),
                    ]
                  : _currentStep == 1
                      ? [
                          // TextButton(child: Text("SETTINGS"), onPressed: () => AppSettings.openBluetoothSettings()),
                          TextButton(
                              child: Text(
                                  locale.translate("pages.devices.connection.instructions").toUpperCase()),
                              onPressed: () => setState(() {
                                    _currentStep = 0;
                                  })),
                          TextButton(
                              child: Text(locale.translate("pages.devices.connection.next").toUpperCase()),
                              onPressed: () => {
                                    if (selectedDevice != null)
                                      {
                                        setState(() {
                                          _currentStep = 2;
                                        })
                                      }
                                  }),
                        ]
                      : [
                          TextButton(
                              child: Text(locale.translate("pages.devices.connection.back").toUpperCase()),
                              onPressed: () => setState(() {
                                    _currentStep = 1;
                                  })),
                          TextButton(
                              child: Text(locale.translate("pages.devices.connection.done").toUpperCase()),
                              onPressed: () => {
                                    if (selectedDevice != null)
                                      {
                                        // TODO: Update name in protocol
                                        selectedDevice.connect(),
                                        bloc.connectToDevice(device),
                                        Navigator.of(context).pop(),
                                      },
                                  }),
                        ]);
        },
      );
    },
  );
}

Widget stepTitle(_currentStep, device, context) {
  RPLocalizations locale = RPLocalizations.of(context)!;
  if (_currentStep == 0) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          locale.translate("pages.devices.connection.step.how_to.title") +
              " " +
              locale.translate(device.name!),
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  } else if (_currentStep == 1) {
    return Column(
      children: [
        Text(
          locale.translate("pages.devices.connection.step.start.title"),
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  } else
    return Column(
      children: [
        Text(
          locale.translate(device.name!) +
              " " +
              locale.translate("pages.devices.connection.step.confirm.title"),
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
}

Widget confirmDevice(DeviceModel device, FlutterBluePlus flutterBlue, BuildContext context) {
  RPLocalizations locale = RPLocalizations.of(context)!;
  return Column(
    children: [
      Image(
          image: AssetImage('assets/icons/connection_done.png'),
          width: MediaQuery.of(context).size.height * 0.2,
          height: MediaQuery.of(context).size.height * 0.2),
      Text(
        locale.translate("pages.devices.connection.step.confirm.1") +
            " " +
            locale.translate(device.name!) +
            " " +
            device.id +
            " " +
            locale.translate("pages.devices.connection.step.confirm.2"),
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

Widget stepContent(_currentStep, device, flutterBlue, context) {
  if (_currentStep == 0)
    return connectionInstructions(device, context);
  else
    return confirmDevice(device, flutterBlue, context);
}
