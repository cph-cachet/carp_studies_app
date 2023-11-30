part of carp_study_app;

// import 'package:carp_study_app/main.dart';
// import 'package:flutter/material.dart';

class EnableBluetoothDialog extends StatelessWidget {
  final DeviceModel device;

  const EnableBluetoothDialog({Key? key, required this.device})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: const Text("Enable bluetooth"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _buildContent(context, device, locale),
        ));
  }

  Widget _buildContent(
      BuildContext context, DeviceModel device, RPLocalizations locale) {
    return enableBluetoothInstructions(context, device) ??
        Container(); // Return a default widget if necessary
  }

  Widget enableBluetoothInstructions(BuildContext context, DeviceModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  (locale.translate(
                          "pages.devices.connection.enable_bluetooth"))
                      .trim(),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                Image(
                    image: const AssetImage('assets/icons/connection.png'),
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  locale.translate(device.connectionInstructions!),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => context.pop(),
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
