part of carp_study_app;

class ConnectionDialog extends StatefulWidget {
  final DeviceModel device;

  const ConnectionDialog({Key? key, required this.device}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  CurrentStep currentStep = CurrentStep.scan;
  BluetoothDevice? selectedDevice;
  int selected = 40;

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.symmetric(vertical: 4),
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
      title: _buildDialogTitle(locale),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: _buildStepContent(locale),
      ),
      actions: _buildActionButtons(locale),
    );
  }

  Widget _buildDialogTitle(RPLocalizations locale) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              padding: const EdgeInsets.only(right: 8),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stepTitle(currentStep, widget.device, context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent(RPLocalizations locale) {
    switch (currentStep) {
      case CurrentStep.scan:
        return stepContent(currentStep, widget.device, selectedDevice);
      case CurrentStep.instructions:
        return connectionInstructions(widget.device, context);
      case CurrentStep.done:
        return confirmDevice(selectedDevice, context);
      default:
        return Container(); // Return a default widget or an empty container
    }
  }

  List<Widget> _buildActionButtons(RPLocalizations locale) {
    Widget tButton(String text, VoidCallback onPressed) {
      return TextButton(
        onPressed: onPressed,
        child: Text(text.toUpperCase()),
      );
    }

    if (currentStep == CurrentStep.scan) {
      return [
        TextButton(
          child: Text(locale
              .translate("pages.devices.connection.instructions")
              .toUpperCase()),
          onPressed: () => setState(() {
            currentStep = CurrentStep.instructions;
          }),
        ),
        TextButton(
          child: Text(
              locale.translate("pages.devices.connection.next").toUpperCase()),
          onPressed: () {
            if (selectedDevice != null) {
              setState(() {
                currentStep = CurrentStep.done;
              });
            }
          },
        ),
      ];
    } else if (currentStep == CurrentStep.instructions) {
      return [
        TextButton(
          child: Text(locale
              .translate("pages.devices.connection.settings")
              .toUpperCase()),
          onPressed: () => OpenSettings.openBluetoothSetting(),
        ),
        TextButton(
          child: Text(
              locale.translate("pages.devices.connection.ok").toUpperCase()),
          onPressed: () => setState(() {
            currentStep = CurrentStep.scan;
          }),
        ),
      ];
    } else {
      return [
        TextButton(
          child: Text(
              locale.translate("pages.devices.connection.back").toUpperCase()),
          onPressed: () => setState(() {
            currentStep = CurrentStep.scan;
          }),
        ),
        TextButton(
          child: Text(
              locale.translate("pages.devices.connection.done").toUpperCase()),
          onPressed: () {
            FlutterBluePlus.stopScan();
            if (selectedDevice != null) {
              bloc.connectToDevice(
                selectedDevice!,
                widget.device.deviceManager,
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ];
    }
  }

  Widget stepTitle(
    CurrentStep currentStep,
    DeviceModel device,
    BuildContext context,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    switch (currentStep) {
      case CurrentStep.scan:
        return Column(
          children: [
            Text(
              locale.translate("pages.devices.connection.step.start.title"),
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
      case CurrentStep.instructions:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${locale.translate("pages.devices.connection.step.how_to.title")} ${locale.translate(device.name!)}",
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
      case CurrentStep.done:
        return Column(
          children: [
            Text(
              "${locale.translate(device.name!)} ${locale.translate("pages.devices.connection.step.confirm.title")}",
              style: sectionTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ],
        );
    }
  }

  Widget stepContent(
    CurrentStep currentStep,
    DeviceModel device,
    BluetoothDevice? selectedDevice,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    if (currentStep == CurrentStep.scan) {
      return Column(
        children: [
          Text(
            "${locale.translate("pages.devices.connection.step.start.1")} ${locale.translate(device.name!)} ${locale.translate("pages.devices.connection.step.start.2")}",
            style: aboutCardContentStyle,
            textAlign: TextAlign.justify,
          ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              initialData: const [],
              builder: (context, snapshot) => SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .where((element) => element.device.localName.isNotEmpty)
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (bluetoothDevice) => ListTile(
                          selected: bluetoothDevice.key == selected,
                          title: Text(bluetoothDevice.value.device.localName),
                          selectedTileColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          onTap: () {
                            selectedDevice = bluetoothDevice.value.device;
                            setState(() => selected = bluetoothDevice.key);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Text(
            "${locale.translate("pages.devices.connection.step.start.3")} ${locale.translate(device.name!)}  ${locale.translate("pages.devices.connection.step.start.4")} ${locale.translate(device.name!)} ${locale.translate("pages.devices.connection.step.start.5")}",
            style: aboutCardContentStyle,
            textAlign: TextAlign.justify,
          )
        ],
      );
    } else {
      return (currentStep == CurrentStep.instructions)
          ? connectionInstructions(device, context)
          : confirmDevice(selectedDevice, context);
    }
  }

  Widget connectionInstructions(DeviceModel device, BuildContext context) {
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

  Widget confirmDevice(BluetoothDevice? device, BuildContext context) {
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
