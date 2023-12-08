part of '../../main.dart';

class AuthorizationDialog extends StatelessWidget {
  final DeviceModel device;

  const AuthorizationDialog({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: Text(
          locale.translate(
              "pages.devices.connection.bluetooth_authorization.title"),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: authorizationionInstructions(context, device),
        ));
  }

  Widget authorizationionInstructions(
      BuildContext context, DeviceModel device) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  locale.translate(
                      "pages.devices.connection.bluetooth_authorization.message"),
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
                  onPressed: () => AppSettings.openAppSettings(
                      type: AppSettingsType.settings),
                  child: Text(
                      locale.translate("pages.devices.connection.settings")),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
