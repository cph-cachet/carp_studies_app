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

  // /// App settings
  // static const MethodChannel _channel = const MethodChannel('app_settings');

  // /// Future async method call to open bluetooth settings.
  // static Future<void> openBluetoothSettings({
  //   bool asAnotherTask = false,
  // }) async {
  //   _channel.invokeMethod('bluetooth', {
  //     'asAnotherTask': asAnotherTask,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //List<DeviceModel> devices = bloc.runningDevices.toList();
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
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Devices & Services".toUpperCase(),
                    //   style: dataCardTitleStyle.copyWith(color: Theme.of(context).primaryColor),
                    // ),
                    Text("Here you can find all the devices and services used in your study.",
                        style: aboutCardSubtitleStyle),
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
                        child: Text("Phone".toUpperCase(),
                            style: dataCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                      )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return _buildSmartphoneDeviceCard(
                              context, smartphoneDevice[index], setState, selected, selectedDevice);
                        }, childCount: smartphoneDevice.length),
                      ),
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Text("Devices".toUpperCase(),
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
                          child: Text("Services".toUpperCase(),
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
            color: Theme.of(context).accentColor, border: Border.all(color: Theme.of(context).primaryColor)),
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
            color: Theme.of(context).accentColor, border: Border.all(color: Theme.of(context).primaryColor)),
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

Future<String> _showSmartphoneInfo(BuildContext context) async {
  String? smartphoneInfo;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    smartphoneInfo = androidInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    smartphoneInfo = iosInfo.name;
  }

  // smartphoneInfo += Platform.operatingSystem + ' ';
  // smartphoneInfo += Platform.operatingSystemVersion.split(' ')[1];
  return smartphoneInfo!;
}

Widget _buildPhysicalDeviceCard(
    BuildContext context, DeviceModel device, setState, selected, selectedDevice) {
  return Center(
    child: Card(
      color: Theme.of(context).scaffoldBackgroundColor,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Text(device.name!),
                    ]),
                subtitle: Column(
                  children: [
                    Text(device.id),
                    SizedBox(height: 1),
                    Row(
                      children: [
                        // Text(device.statusString),
                        // SizedBox(width: 8),
                        _showBateryPercentage(context, device.batteryLevel!, scale: 0.9),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [device.statusIcon],
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

Widget _buildSmartphoneDeviceCard(
    BuildContext context, DeviceModel device, setState, selected, selectedDevice) {
  return Center(
    child: Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: FutureBuilder<Map<String, String?>>(
        future: device.phoneInfo,
        builder: (context, snapshot) => Column(
          children: [
            ListTile(
              enableFeedback: false,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [device.icon!],
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Text(snapshot.data!["name"]!),
                  ]),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!["model"]! + " - " + snapshot.data!["version"]!),
                      SizedBox(height: 1),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOnlineDeviceCard(BuildContext context, DeviceModel device) {
  return Center(
    child: Card(
      color: Theme.of(context).scaffoldBackgroundColor,
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
                    Text(device.name!),
                  ]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(device.statusString),
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
                            "Select the name of the " +
                                device.name! +
                                " that you want to connect and press 'NEXT'.",
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
                                              // device.id = bluetoothDevice.value.device.name;
                                              selectedDevice = bluetoothDevice.value.device;
                                              device.setId = bluetoothDevice.value.device.name;
                                              print(device._id);
                                              // bluetoothDevice.value.device.connect();

                                              setState(() => selected = bluetoothDevice.key);
                                            },
                                          ),
                                        )
                                        .toList()),
                              ),
                            ),
                          ),
                          Text(
                            "If the " +
                                device.name! +
                                " is not in the list, make sure it is charged and turned on. If you want to know how to connect " +
                                device.name! +
                                " to the phone, press 'INSTRUCTIONS'.",
                            style: aboutCardContentStyle,
                            textAlign: TextAlign.justify,
                          )
                        ],
                      )
                    : stepContent(_currentStep, device, selected, flutterBlue, context),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 25),
              // actions: stepActions(_currentStep, setState, device, context),
              actions: _currentStep == 0
                  ? [
                      TextButton(
                          child: Text("NEXT"),
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
                              child: Text("INSTRUCTIONS"),
                              onPressed: () => setState(() {
                                    _currentStep = 0;
                                  })),
                          TextButton(
                              child: Text("NEXT"),
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
                              child: Text("BACK"),
                              onPressed: () => setState(() {
                                    _currentStep = 1;
                                  })),
                          TextButton(
                              child: Text("DONE"),
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
  if (_currentStep == 0) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "How to connect to " + device.name!,
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  } else if (_currentStep == 1) {
    return Column(
      children: [
        Text(
          "Let's get started",
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  } else
    return Column(
      children: [
        Text(
          device.name! + " is connected!",
          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
}

Widget confirmDevice(DeviceModel device, FlutterBluePlus flutterBlue, BuildContext context) {
  flutterBlue.startScan();
  return Column(
    children: [
      Image(
          image: AssetImage('assets/icons/connection_done.png'),
          width: MediaQuery.of(context).size.height * 0.2,
          height: MediaQuery.of(context).size.height * 0.2),
      Text(
        "The " +
            device.name! +
            " " +
            device.id +
            " has succesfully been connected to the study and is now ready to start sensing.",
        style: aboutCardContentStyle,
        textAlign: TextAlign.justify,
      ),
    ],
  );
}

Widget connectionInstructions(DeviceModel device, BuildContext context) {
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
                device.connectionInstructions!,
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

Widget stepContent(_currentStep, device, selected, flutterBlue, context) {
  if (_currentStep == 0)
    return connectionInstructions(device, context);

  // Since the step 1 it uses setState, it needs to go in the parent widget
  // if (_currentStep == 1)
  //   return pairDevice(device, setState, selected, flutterBlue);

  else
    return confirmDevice(device, flutterBlue, context);
}
