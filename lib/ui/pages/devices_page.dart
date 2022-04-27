part of carp_study_app;

class DevicesPage extends StatefulWidget {
  // final DevicesPageViewModel model;
  // const DevicesPage(this.model);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
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

  // List<Device> devices = [
  //   Device(
  //       name: "Phone",
  //       state: DeviceState.CONNECTED,
  //       description: "00:11:22:33:FF:EE",
  //       battery: 70,
  //       type: DeviceType.PHONE),
  //   Device(
  //       name: "eSense Ear Plug",
  //       state: DeviceState.CONNECTED,
  //       description: "00:11:22:33:FF:EE",
  //       battery: 80,
  //       type: DeviceType.HEADSET),
  //   Device(
  //       name: "Scale",
  //       state: DeviceState.DISCONNECTED,
  //       description: "00:11:22:33:FF:EE",
  //       type: DeviceType.SCALE),
  //   Device(
  //       name: "Fitbit",
  //       state: DeviceState.NOT_PAIRED,
  //       description: "00:11:22:33:FF:EE",
  //       type: DeviceType.WATCH),
  //   Device(
  //       name: "Google Home",
  //       state: DeviceState.ERROR,
  //       description: "00:11:22:33:FF:EE",
  //       type: DeviceType.HOME),
  // ];

  // @override
  // void initState() {
  //   super.initState();
  //   BluetoothProbe().getDatum();
  //   widget.model.scanDevices;
  // }

//   @override
//   Widget build(BuildContext context) {
//     RPLocalizations locale = RPLocalizations.of(context)!;

//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 35),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: ListTile(
//               leading: Icon(Icons.devices_other),
//               title: Text("Devices"),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: CustomScrollView(
//               slivers: [
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//                     return _buildDeviceCard(context, devices[index]);
//                   }, childCount: devices.length),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    List<DeviceModel> devices = bloc.runningDevices.toList();

    RPLocalizations locale = RPLocalizations.of(context)!;
    // BluetoothProbe().getDatum();
    // widget.model.scanDevices;
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
                    Text(
                      "Devices",
                      //'${locale.translate('pages.data_viz.hello')} ${bloc.friendlyUsername}',
                      style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Text("Here you can find all the devices you will use in your study.",
                        style: aboutCardSubtitleStyle),
                    //Text(locale.translate('pages.data_viz.thanks'), style: aboutCardSubtitleStyle),
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
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          //return Text(widget.model.devices[index].bluetoothDeviceName);
                          return _buildDeviceCard(context, devices[index]);
                        }, childCount: devices.length),
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
  return Row(children: [
    SizedBox(width: 8),
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
    Text(bateryLevel.toString() + "%")
  ]);
}

Widget _buildDeviceCard(BuildContext context, DeviceModel device) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                device.icon!,
              ]),
              title: Text(device.name!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(device.id),
                  SizedBox(height: 1),
                  Row(
                    children: [
                      Text(device.statusString),
                      // device.batteryLevel == null
                      //     ? SizedBox.shrink()
                      //     : Row(
                      //         children: [
                      //           SizedBox(width: 5),
                      //           Transform.rotate(
                      //               angle: 90 * pi / 180, child: Icon(Icons.battery_std_outlined)),

                      //         ],
                      //       ),
                      SizedBox(width: 8),
                      _showBateryPercentage(context, device.batteryLevel!, scale: 0.9)
                    ],
                  ),
                ],
              ),
              trailing: device.statusIcon,
              onTap: () => _showConnectionDialog(context, 0, device),
            ),
            // const Divider(
            //   thickness: 1,
            // ),
          ],
        ),
      ),
    ),
  );
}

Future _showConnectionDialog(BuildContext context, _currentStep, DeviceModel device) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            titlePadding: EdgeInsets.symmetric(vertical: 10),
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

                _currentStep == 0
                    ? Image(
                        image: AssetImage('assets/icons/bluetooth.png'),
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4)
                    : Image(
                        image: AssetImage('assets/icons/connected.png'),
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1].map(
                    (step) {
                      var index = step;
                      return Container(
                        width: 7.0,
                        height: 7.0,
                        margin: EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= _currentStep
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColor.withOpacity(0.5)),
                      );
                    },
                  ).toList(),
                ),

                //Image(image: AssetImage('assets/icons/audio.png'), width: 220, height: 220),

                Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _currentStep == 0 ? Text("Let's get started") : Text(device.name! + " paired!"),
                    ],
                  ),
                ),
              ],
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: _currentStep == 0
                  ? Text(
                      "Make sure the " +
                          device.name! +
                          " is charged and turned on. Then go to the Bluetooth Settings in your phone, press ‘Pair new device’ and select the " +
                          device.name! +
                          ". Once is paired come back and press 'NEXT'.",
                      style: aboutCardContentStyle,
                    )
                  : configureDevice(device, context),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            actions: _currentStep == 0
                ? [
                    TextButton(child: Text("SETTINGS"), onPressed: () => AppSettings.openBluetoothSettings()),
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
                : [
                    TextButton(
                        child: Text("BACK"),
                        onPressed: () => {
                              setState(() {
                                _currentStep = 0;
                              })
                            }
                        //settings
                        ),
                    TextButton(
                        child: Text("CONNECT"),
                        onPressed: () => {
                              bloc.connectToDevice(device),
                              Navigator.of(context).pop(),
                              // setState(() {
                              //   _currentStep = 0;
                              // })
                            }),
                  ],
          );
        },
      );
    },
  );
}

Widget configureDevice(DeviceModel device, BuildContext context) {
  //final inputController = TextEditingController(text: 'eSense-1234');
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  flutterBlue.startScan(timeout: Duration(seconds: 2));

  bool _selected = false;

  return Column(
    children: [
      Text(
        "Select the name of the " +
            device.name! +
            " that you want to connect and press 'CONNECT'. If the " +
            device.name! +
            " is not in the list, press 'BACK'.",
        style: aboutCardContentStyle,
      ),

      StreamBuilder<List<BluetoothDevice>>(
        stream: Stream.periodic(Duration(seconds: 2)).asyncMap((_) => flutterBlue.connectedDevices),
        initialData: [],
        builder: (context, snapshot) => Column(
          children: snapshot.data!.isEmpty
              ? [Padding(padding: EdgeInsets.symmetric(vertical: 20), child: CircularProgressIndicator())]
              : snapshot.data!
                  .map(
                    (bluetoothDevice) => ListTile(
                      selected: _selected,
                      //selectedTileColor: Theme.of(context).primaryColor,
                      title: Text(bluetoothDevice.name),
                      onTap: () {
                        device.id = bluetoothDevice.name;

                        _selected = !_selected;
                      },
                    ),
                  )
                  .toList(),
        ),
      ),

      // TextField(
      //   style: inputFieldStyle,
      //   // decoration: new InputDecoration.collapsed(hintText: 'eSense-0049'),
      //   controller: inputController,
      //   inputFormatters: [
      //     FilteringTextInputFormatter(RegExp(r'^eSense-\d{4}'), allow: true),
      //   ],
      //   decoration: InputDecoration(
      //     labelText: 'Device name',
      //     helperText: 'e.g. eSense-1234',
      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      //   ),
      // ),
      // TextButton(
      //     onPressed: () {
      //       print("@@@" + inputController.text);
      //     },
      //     child: Text("Save name"))
    ],
  );
}


// // Get an icon for the device based on its type.  If there is no icon for the device, use a default icon


// Map<DeviceState, String> deviceStateText = {
//   DeviceState.CONNECTED: "Connected",
//   DeviceState.DISCONNECTED: "Disconnected",
//   DeviceState.NOT_PAIRED: "Not paired",
//   DeviceState.ERROR: "Error",
// };

// class Device {
//   String name;
//   String description;
//   DeviceState state;
//   int? battery;
//   DeviceType type;

//   Device(
//       {required this.name,
//       required this.description,
//       required this.state,
//       this.type = DeviceType.UNKNOWN,
//       this.battery});
// }

// enum DeviceType { WATCH, PHONE, HEADSET, SCALE, HOME, SPEAKER, UNKNOWN }

// enum DeviceState { CONNECTED, DISCONNECTED, NOT_PAIRED, ERROR }
