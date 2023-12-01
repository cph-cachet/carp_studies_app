part of '../../main.dart';

class DisconnectionDialog extends StatelessWidget {
  final DeviceModel device;

  const DisconnectionDialog({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: const Text("Disconnect bluetooth"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: disconnectBluetooth(context, device),
        ));
  }

  Widget disconnectBluetooth(BuildContext context, DeviceModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  (locale.translate(
                          "pages.devices.connection.disconnect_bluetooth")),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => {
                    // selectedDevice: BluetoothDevice?
                    // widget: Widget from stateful. woops
                    disconnectFromDevice(
                      device.deviceManager,
                    ),
                    context.pop()
                  },
                  child: Text(locale.translate("pages.devices.connection.ok")),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Disconnect from the currently connected device
  void disconnectFromDevice(DeviceManager device) {
    if (device is BTLEDeviceManager) {
      device.btleAddress = '';
      device.btleName = '';
    }

    // when the device id is updated, save the deployment
    Sensing().controller?.saveDeployment();

    device.disconnect();
  }
}
