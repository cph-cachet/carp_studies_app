part of '../../main.dart';

class DisconnectionDialog extends StatelessWidget {
  final DeviceModel device;

  const DisconnectionDialog({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: Text(locale
            .translate("pages.devices.connection.disconnect_bluetooth.title")),
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
                      "pages.devices.connection.disconnect_bluetooth.message ${device.name}}?")),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => {
                    device.disconnectFromDevice(device.deviceManager),
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
