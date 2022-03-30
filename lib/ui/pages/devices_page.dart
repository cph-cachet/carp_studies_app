part of carp_study_app;

class DevicesPage extends StatefulWidget {
  // final DevicesPageViewModel model;
  // const DevicesPage(this.model);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
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
        children: [
          SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Icon(Icons.devices_other),
              title: Text("Devices"),
            ),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder<DeviceStatus>(
                stream: devices.first.deviceEvents,
                builder: (context, AsyncSnapshot<DeviceStatus> snapshot) {
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

Widget _buildDeviceCard(BuildContext context, DeviceModel device) {
  return Center(
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: StreamBuilder<DeviceStatus>(
        stream: device.deviceEvents,
        initialData: DeviceStatus.unknown,
        builder: (context, AsyncSnapshot<DeviceStatus> snapshot) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: device.icon,
              title: Text(device.name!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(device.id),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(device.statusString!),
                      device.batteryLevel == null
                          ? SizedBox.shrink()
                          : Row(
                              children: [
                                SizedBox(width: 5),
                                Transform.rotate(
                                    angle: 90 * pi / 180, child: Icon(Icons.battery_std_outlined)),
                                Text(device.batteryLevel.toString() + "%")
                              ],
                            ),
                    ],
                  ),
                ],
              ),
              trailing: device.status == DeviceStatus.connected
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : device.status == DeviceStatus.disconnected
                      ? Text("CONNECT")
                      : Text("PAIR"),
              onTap: () => _showConnectionDialog(context, 0, device),
            ),
            const Divider(),
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
            titlePadding: EdgeInsets.symmetric(vertical: 10),
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
                    ? Image(image: AssetImage('assets/icons/bluetooth.png'), width: 220, height: 220)
                    : Image(image: AssetImage('assets/icons/connected.png'), width: 220, height: 220),
                SizedBox(height: 15),
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
              height: 120,
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: _currentStep == 0
                      ? Text(
                          "Make sure the " +
                              device.name! +
                              " is charged and turned on. Then go to the ‘Bluetooth Settings’ in your phone, press ‘Pair new device’ and select the " +
                              device.name! +
                              ". Once is paired come back and press 'NEXT'.",
                          style: aboutCardContentStyle,
                        )
                      : Text(
                          "Now you can connect the " + device.name! + " to this app.",
                          style: aboutCardContentStyle,
                        ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            actions: _currentStep == 0
                ? [
                    TextButton(child: Text("GO TO SETTINGS"), onPressed: () => {}),
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
