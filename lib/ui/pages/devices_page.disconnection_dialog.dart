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
        title: const DialogTitle(
          title: "pages.devices.connection.disconnect_bluetooth.title",
        ),
        content: SizedBox(
          child: disconnectBluetooth(context, device),
        ));
  }

  Widget disconnectBluetooth(BuildContext context, DeviceModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          "${locale.translate("pages.devices.connection.disconnect_bluetooth.message")} ${locale.translate(device.name ?? '')}?",
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        ),
        TextButton(
          onPressed: () {
            device.disconnectFromDevice(device.deviceManager);
            if (context.canPop()) context.pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                locale.translate("cancel"),
              ),
              Text(
                locale.translate(
                    "pages.devices.connection.disconnect_bluetooth.disconnect"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
