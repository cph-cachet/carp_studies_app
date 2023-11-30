part of carp_study_app;

class ConnectionDialog extends StatefulWidget {
  final DeviceModel device;

  const ConnectionDialog({Key? key, required this.device}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  @override
  initState() {
    super.initState();
    FlutterBluePlus.startScan();
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => context.pop(),
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
          AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
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
            bloc.connectToDevice(
              selectedDevice!,
              widget.device.deviceManager,
            );
            context.pop();
          }
        }),
      ],
    };
    return stepButtonConfigs[currentStep] ?? [];
  }

  Widget stepTitle(
    CurrentStep currentStep,
    DeviceModel device,
    BuildContext context,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    Widget buildStepTitle(String translationKey, BuildContext context,
            {Color? color, String suffix = ""}) =>
        Column(
          children: [
            Text(
              locale.translate(translationKey) + suffix,
              style: sectionTitleStyle.copyWith(color: color),
            ),
          ],
        );

    final stepTitleMap = {
      CurrentStep.scan: buildStepTitle(
        "pages.devices.connection.step.start.title",
        context,
        color: Theme.of(context).primaryColor,
      ),
      CurrentStep.instructions: buildStepTitle(
        "pages.devices.connection.step.how_to.title",
        context,
        color: Theme.of(context).primaryColor,
        suffix: " ${locale.translate(device.name!)}",
      ),
      CurrentStep.done: buildStepTitle(
        "${locale.translate(device.name!)} ${locale.translate("pages.devices.connection.step.confirm.title")}",
        context,
        color: Theme.of(context).primaryColor,
      ),
    };

    return stepTitleMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  Widget stepContent(
    CurrentStep currentStep,
    DeviceModel device,
  ) {
    if (currentStep == CurrentStep.scan) {
      return scanWidget(device, context);
    } else if (currentStep == CurrentStep.instructions) {
      return connectionInstructions(device, context);
    } else {
      return confirmDevice(selectedDevice, context);
    }
  }

  Widget scanWidget(DeviceModel device, BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

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
          "${locale.translate("pages.devices.connection.step.start.3")} ${locale.translate(device.name!)}  ${locale.translate("pages.devices.connection.step.start.4")} ${locale.translate(device.name!)} ${locale.translate("pages.devices.connection.step.start.5")}",
          style: aboutCardContentStyle,
          textAlign: TextAlign.justify,
        )
      ],
    );
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
