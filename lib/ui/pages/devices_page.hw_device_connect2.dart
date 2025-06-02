part of carp_study_app;

/// State of Bluetooth connection UI.
enum CurrentStep3 { scan, instructions, done }

class HWDeviceConnectPage2 extends StatefulWidget {
  final DeviceViewModel device;

  const HWDeviceConnectPage2({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => _HWDeviceConnectPage2State();
}

class _HWDeviceConnectPage2State extends State<HWDeviceConnectPage2> {
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

  CurrentStep3 currentStep = CurrentStep3.scan;
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
                      /// THIS IS FOR INSTRUCTIONS!!!!!
                      ///
                      ///
                      ///
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(20),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withValues(alpha: 0.1),
                      //         blurRadius: 10,
                      //         spreadRadius: 2,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Image.asset(
                      //     _deviceTypeIcon[widget.device.type]!,
                      //     height: 250,
                      //     width: 250,
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
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
                      Text(
                        "${locale.translate("pages.devices.connection.step.scan.1")}"
                        "${locale.translate(widget.device.typeName)}"
                        "${locale.translate("pages.devices.connection.step.scan.2")}",
                        style: healthServiceConnectMessageStyle.copyWith(
                            color: Theme.of(context)
                                .extension<RPColors>()!
                                .grey900),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: StreamBuilder<List<ScanResult>>(
                            stream: FlutterBluePlus.scanResults,
                            initialData: const [],
                            builder: (context, snapshot) {
                              // for (var element in snapshot.data!) {
                              //   print(
                              //       "e ${element.advertisementData.manufacturerData.entries}");
                              //   print(
                              //       "k ${element.advertisementData.manufacturerData.keys}");
                              //   if (element.advertisementData.serviceUuids
                              //       .isNotEmpty) {
                              //     print("uu ${{
                              //       element.advertisementData.serviceUuids
                              //     }}");
                              //   }
                              // }

                              return SingleChildScrollView(
                                child: Column(
                                  children: snapshot.data!
                                      .where((element) =>
                                          element
                                              .device.platformName.isNotEmpty &&
                                          (element.advertisementData.advName
                                                  .contains("Polar") ||
                                              element.advertisementData.advName
                                                  .contains("Movesense")))
                                      .toList()
                                      .asMap()
                                      .entries
                                      .map(
                                        (bluetoothDevice) => ListTile(
                                          selected:
                                              bluetoothDevice.key == selected,
                                          title: Text(bluetoothDevice
                                              .value.device.platformName),
                                          selectedTileColor: Theme.of(context)
                                              .primaryColor
                                              .withValues(alpha: 0.2),
                                          onTap: () {
                                            selectedDevice =
                                                bluetoothDevice.value.device;
                                            setState(() {
                                              selected = bluetoothDevice.key;
                                            });
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            }),
                      ),
                      Text(
                        locale
                            .translate("pages.devices.connection.step.start.3"),
                        style: aboutCardContentStyle,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            child: Text(locale.translate("Next"),
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .extension<RPColors>()!
                                  .primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                            ),
                            onPressed: selectedDevice != null
                                ? () {
                                    FlutterBluePlus.stopScan();
                                    if (selectedDevice != null) {
                                      widget.device
                                          .connectToDevice(selectedDevice!);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (context) =>
                                                HealthServiceConnectPage2()),
                                      );
                                    }
                                  }
                                : null,
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
      CurrentStep3.scan: const DialogTitle(
        title: "pages.devices.connection.step.start.title",
      ),
      CurrentStep3.instructions: DialogTitle(
        title: "pages.devices.connection.step.how_to.title",
        deviceName: selectedDevice?.platformName,
        titleEnd: "pages.devices.connection.step.how_to.device",
      ),
      CurrentStep3.done: DialogTitle(
        title: "pages.devices.connection.step.confirm.title",
        deviceName: selectedDevice?.platformName,
      ),
    };

    return stepTitleMap[currentStep] ??
        Container(); // Return a default widget if necessary
  }

  Widget _buildStepContent(RPLocalizations locale) {
    final stepContentMap = {
      CurrentStep3.scan: stepContent(currentStep, widget.device),
      CurrentStep3.instructions: connectionInstructions(widget.device, context),
      CurrentStep3.done: confirmDevice(selectedDevice, context),
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
      CurrentStep3.scan: [
        buildTranslatedButton("pages.devices.connection.instructions", () {
          setState(() => currentStep = CurrentStep3.instructions);
        }, true),
        buildTranslatedButton("next", () {
          if (selectedDevice != null) {
            setState(() => currentStep = CurrentStep3.done);
          }
        }, selectedDevice != null),
      ],
      CurrentStep3.instructions: [
        buildTranslatedButton("settings", () {
          Platform.isAndroid
              ? OpenSettingsPlusAndroid().bluetooth()
              : OpenSettingsPlusIOS().bluetooth();
        }, true),
        buildTranslatedButton("ok", () {
          setState(() => currentStep = CurrentStep3.scan);
        }, true),
      ],
      CurrentStep3.done: [
        buildTranslatedButton("back", () {
          setState(() => currentStep = CurrentStep3.scan);
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
    CurrentStep3 currentStep,
    DeviceViewModel device,
  ) {
    if (currentStep == CurrentStep3.scan) {
      return scanWidget(device, context);
    } else if (currentStep == CurrentStep3.instructions) {
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

  static const Map<String, String> _deviceTypeIcon = {
    PolarDevice.DEVICE_TYPE: "assets/instructions/how_to_connect_polar.png",
    MovesenseDevice.DEVICE_TYPE:
        "assets/instructions/how_to_connect_movesense.png",
  };
}
