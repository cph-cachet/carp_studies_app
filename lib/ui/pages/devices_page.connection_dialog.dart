part of carp_study_app;

/// State of Bluetooth connection UI.
enum CurrentStep { scan, instructions, done }

class ConnectionDialog extends StatefulWidget {
  final DeviceViewModel device;

  const ConnectionDialog({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  @override
  initState() {
    super.initState();
    FlutterBluePlus.startScan();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

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
    final stepTitleMap = {
      CurrentStep.scan: const DialogTitle(
        title: "pages.devices.connection.step.start.title",
      ),
      CurrentStep.instructions: const DialogTitle(
        title: "pages.devices.connection.step.how_to.title",
      ),
      CurrentStep.done: DialogTitle(
        title: "pages.devices.connection.step.confirm.title",
        deviceName: selectedDevice?.platformName,
      ),
    };

    return stepTitleMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  Widget _buildStepContent(RPLocalizations locale) {
    final stepContentMap = {
      CurrentStep.scan: stepContent(currentStep, widget.device),
      CurrentStep.instructions: connectionInstructions(widget.device, context),
      CurrentStep.done: confirmDevice(selectedDevice, context),
    };

    return stepContentMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  List<Widget> _buildActionButtons(RPLocalizations locale) {
    Widget buildTranslatedButton(String key, VoidCallback onPressed) {
      return TextButton(
        onPressed: onPressed,
        child: Text(locale.translate(key).toUpperCase()),
      );
    }

    final stepButtonConfigs = {
      CurrentStep.scan: [
        buildTranslatedButton("pages.devices.connection.instructions", () {
          setState(() => currentStep = CurrentStep.instructions);
        }),
        buildTranslatedButton("pages.devices.connection.next", () {
          if (selectedDevice != null) {
            setState(() => currentStep = CurrentStep.done);
          }
        }),
      ],
      CurrentStep.instructions: [
        buildTranslatedButton("pages.devices.connection.settings", () {
          OpenSettingsPlusIOS().bluetooth();
        }),
        buildTranslatedButton("pages.devices.connection.ok", () {
          setState(() => currentStep = CurrentStep.scan);
        }),
      ],
      CurrentStep.done: [
        buildTranslatedButton("pages.devices.connection.back", () {
          setState(() => currentStep = CurrentStep.scan);
        }),
        buildTranslatedButton("pages.devices.connection.done", () {
          FlutterBluePlus.stopScan();
          if (selectedDevice != null) {
            widget.device.connectToDevice(selectedDevice!);
            context.pop(true);
          }
        }),
      ],
    };
    return stepButtonConfigs[currentStep] ?? [];
  }

  Widget stepContent(
    CurrentStep currentStep,
    DeviceViewModel device,
  ) {
    if (currentStep == CurrentStep.scan) {
      return scanWidget(device, context);
    } else if (currentStep == CurrentStep.instructions) {
      return connectionInstructions(device, context);
    } else {
      return confirmDevice(selectedDevice, context);
    }
  }

  Widget scanWidget(DeviceViewModel device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          "${locale.translate("pages.devices.connection.step.start.1")} ${locale.translate(device.typeName)} ${locale.translate("pages.devices.connection.step.start.2")}",
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
                    .where((element) => element.device.platformName.isNotEmpty)
                    .toList()
                    .asMap()
                    .entries
                    .map(
                      (bluetoothDevice) => ListTile(
                        selected: bluetoothDevice.key == selected,
                        title: Text(bluetoothDevice.value.device.platformName),
                        selectedTileColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        onTap: () {
                          selectedDevice = bluetoothDevice.value.device;
                          setState(() {
                            selected = bluetoothDevice.key;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        Text(
          locale.translate("pages.devices.connection.step.start.3"),
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  Widget connectionInstructions(DeviceViewModel device, BuildContext context) {
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
          ("${locale.translate("pages.devices.connection.step.confirm.1")} '${device?.platformName}' ${locale.translate("pages.devices.connection.step.confirm.2")}")
              .trim(),
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
