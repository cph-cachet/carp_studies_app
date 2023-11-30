part of carp_study_app;

// import 'package:carp_study_app/main.dart';
// import 'package:flutter/material.dart';

class DisconnectionDialog extends StatelessWidget {
  final DeviceModel device;

  const DisconnectionDialog({Key? key, required this.device}) : super(key: key);

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
                          "pages.devices.connection.disconnect_bluetooth"))
                      .trim(),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => {
                    // selectedDevice: BluetoothDevice?
                    // widget: Widget from stateful. woops
                    bloc.disconnectFromDevice(
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
}
