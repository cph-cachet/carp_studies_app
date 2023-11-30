part of carp_study_app;

// import 'package:carp_study_app/main.dart';
// import 'package:flutter/material.dart';

class AuthorizationDialog extends StatelessWidget {

  final DeviceModel device;

  const AuthorizationDialog({Key? key, required this.device}) : super(key: key);

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
        child: _buildContent(locale),
      )
    );
  }

  Widget _buildContent(RPLocalizations locale) {

    return authorizationionInstructions(widget.device, context) ??
        Container(); // Return a default widget if necessary
  }

  Widget authorizationionInstructions(DeviceModel device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                    image: const AssetImage('assets/icons/connection.png'),
                    width: MediaQuery.of(context).size.height * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  locale.translate(device.connectionInstructions!),
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

  Widget confirmAuthorization(BluetoothDevice? device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Image(
            image: const AssetImage('assets/icons/connection_done.png'),
            width: MediaQuery.of(context).size.height * 0.2,
            height: MediaQuery.of(context).size.height * 0.2),
        Text(
          ("${locale.translate("pages.devices.connection.step.confirm.1")} '${device?.localName}' ${locale.translate("pages.devices.connection.step.confirm.2")}")
              .trim(),
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
  
}