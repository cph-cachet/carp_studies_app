part of carp_study_app;

class EnableBluetoothDialog extends StatelessWidget {
  final DeviceViewModel device;

  const EnableBluetoothDialog({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: const DialogTitle(
            title: "pages.devices.connection.enable_bluetooth.title"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: enableBluetoothInstructions(context, device),
        ));
  }

  Widget enableBluetoothInstructions(
      BuildContext context, DeviceViewModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  locale.translate(
                      "pages.devices.connection.enable_bluetooth.message1"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/instructions/bluetooth_enable_bar.png'),
                  ),
                ),
                Text(
                  locale.translate(
                      "pages.devices.connection.enable_bluetooth.message2"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),

                /// TODO: Localise this image, take a screenshot of the settings page in Danish
                if (Platform.isAndroid || Platform.isIOS)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Image(
                      image: AssetImage(
                          'assets/instructions/bluetooth_enable_connections_bar.png'),
                    ),
                  ),
                Text(
                  locale.translate(
                      "pages.devices.connection.enable_bluetooth.message3"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.canPop() ? context.pop() : null,
                      child: Text(
                        locale.translate("pages.devices.connection.ok"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
