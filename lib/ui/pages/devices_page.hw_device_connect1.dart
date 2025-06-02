part of carp_study_app;

/// State of Bluetooth connection UI.
enum CurrentStep2 { scan, instructions, done }

class HWDeviceConnectPage1 extends StatefulWidget {
  final DeviceViewModel device;

  const HWDeviceConnectPage1({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => _HWDeviceConnectPage1State();
}

class _HWDeviceConnectPage1State extends State<HWDeviceConnectPage1> {
  CurrentStep2 currentStep = CurrentStep2.scan;
  BluetoothDevice? selectedDevice;
  int selected = 40;

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                child: const CarpAppBar(hasProfileIcon: true),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/instructions/connect_to_hw.png',
                          height: 250,
                          width: 250,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        locale.translate(
                            "pages.devices.connection.step.start.title"),
                        style: healthServiceConnectTitleStyle.copyWith(
                            color: Theme.of(context)
                                .extension<RPColors>()!
                                .primary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: locale.translate(
                                  "pages.devices.connection.step.start.1"),
                            ),
                            TextSpan(
                              text: locale.translate(
                                  "pages.devices.connection.instructions"),
                              style: TextStyle(
                                color: Theme.of(context)
                                    .extension<RPColors>()!
                                    .primary,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Platform.isAndroid
                                      ? OpenSettingsPlusAndroid().bluetooth()
                                      : OpenSettingsPlusIOS().bluetooth();
                                },
                            ),
                            TextSpan(
                              text: locale.translate(
                                "pages.devices.connection.step.start.2",
                              ),
                            ),
                          ],
                        ),
                        style: healthServiceConnectMessageStyle.copyWith(
                            color: Theme.of(context)
                                .extension<RPColors>()!
                                .grey900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            child: Text(locale.translate("cancel")),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: Text(
                              locale.translate("Next"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .extension<RPColors>()!
                                  .primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => HWDeviceConnectPage2(
                                        device: widget.device)),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogTitle(RPLocalizations locale) {
    final stepTitleMap = {
      CurrentStep2.scan: const DialogTitle(
        title: "pages.devices.connection.step.start.title",
      ),
      CurrentStep2.instructions: DialogTitle(
        title: "pages.devices.connection.step.how_to.title",
        deviceName: selectedDevice?.platformName,
        titleEnd: "pages.devices.connection.step.how_to.device",
      ),
      CurrentStep2.done: DialogTitle(
        title: "pages.devices.connection.step.confirm.title",
        deviceName: selectedDevice?.platformName,
      ),
    };

    return stepTitleMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  Widget _buildStepContent(RPLocalizations locale) {
    final stepContentMap = {
      CurrentStep2.scan: stepContent(currentStep, widget.device),
      CurrentStep2.instructions: connectionInstructions(widget.device, context),
      CurrentStep2.done: confirmDevice(selectedDevice, context),
    };

    return stepContentMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  List<Widget> _buildActionButtons(RPLocalizations locale) {
    Widget buildTranslatedButton(
        String key, VoidCallback onPressed, bool enabled) {
      return TextButton(
        onPressed: enabled ? onPressed : null,
        child: Text(locale.translate(key).toUpperCase()),
      );
    }

    final stepButtonConfigs = {
      CurrentStep2.scan: [
        buildTranslatedButton("pages.devices.connection.instructions", () {
          setState(() => currentStep = CurrentStep2.instructions);
        }, true),
        buildTranslatedButton("next", () {
          if (selectedDevice != null) {
            setState(() => currentStep = CurrentStep2.done);
          }
        }, selectedDevice != null),
      ],
      CurrentStep2.instructions: [
        buildTranslatedButton("settings", () {
          Platform.isAndroid
              ? OpenSettingsPlusAndroid().bluetooth()
              : OpenSettingsPlusIOS().bluetooth();
        }, true),
        buildTranslatedButton("ok", () {
          setState(() => currentStep = CurrentStep2.scan);
        }, true),
      ],
      CurrentStep2.done: [
        buildTranslatedButton("back", () {
          setState(() => currentStep = CurrentStep2.scan);
        }, true),
        buildTranslatedButton("done", () {
          FlutterBluePlus.stopScan();
          if (selectedDevice != null) {
            widget.device.connectToDevice(selectedDevice!);
            context.pop(true);
          }
        }, true),
      ],
    };
    return stepButtonConfigs[currentStep] ?? [];
  }

  Widget stepContent(
    CurrentStep2 currentStep,
    DeviceViewModel device,
  ) {
    if (currentStep == CurrentStep2.scan) {
      return scanWidget(device, context);
    } else if (currentStep == CurrentStep2.instructions) {
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
                        selectedTileColor: Theme.of(context)
                            .primaryColor
                            .withValues(alpha: 0.2),
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
