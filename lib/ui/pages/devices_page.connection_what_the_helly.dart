part of carp_study_app;

/// State of Bluetooth connection UI.
enum CurrentSte3 { scan, instructions, done }

class ConnectionDialog3 extends StatefulWidget {
  final DeviceViewModel device;

  const ConnectionDialog3({super.key, required this.device});

  @override
  State<StatefulWidget> createState() => _ConnectionDialogState3();
}

class _ConnectionDialogState3 extends State<ConnectionDialog3> {
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
                    children: [
                      _buildDialogTitle(locale),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: _buildStepContent(locale),
                      ),
                      Row(
                        children: _buildActionButtons(locale),
                      ),
                    ],
                    // title: _buildDialogTitle(locale),
                    // content: SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.6,
                    //   child: _buildStepContent(locale),
                    // ),
                    // actions: _buildActionButtons(locale),
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
          "${locale.translate("pages.devices.connection.step.scan.1")} ${locale.translate(device.typeName)} ${locale.translate("pages.devices.connection.step.scan.2")}",
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
    AssetImage? assetImage;
    // switch ((
    //   widget.device.type,
    //   (
    //     widget.device.deviceManager
    //     as PolarDeviceManager?)
    //       ?.configuration
    //       ?.deviceType
    // )) {
    //   case (PolarDevice.DEVICE_TYPE, PolarDeviceType.H10) ||
    //         (PolarDevice.DEVICE_TYPE, PolarDeviceType.H9):
    //     assetImage =
    //         AssetImage('assets/instructions/polar_h9_h10_instructions.png');
    //     break;
    //   case (PolarDevice.DEVICE_TYPE, PolarDeviceType.SENSE):
    //     assetImage =
    //         AssetImage('assets/instructions/polar_sense_instructions.png');
    //     break;
    //   default:
    //     if (device is MovesenseDevice) {
    //       assetImage =
    //           AssetImage('assets/instructions/movesense_instructions.png');
    //     } else {
    //       assetImage = AssetImage('assets/instructions/connect_to_hw.png');
    //     }
    // }
    print("kill me ${widget.device.deviceManager}");
    switch (widget.device.deviceManager) {
      case PolarDeviceManager polarManager
          when widget.device.type == PolarDevice.DEVICE_TYPE 
          &&
              ((widget.device.deviceManager as PolarDeviceManager).configuration?.deviceType == PolarDeviceType.H10 ||
                  polarManager.configuration?.deviceType == PolarDeviceType.H9)
                  :
                  print("aaaa${polarManager.configuration?.deviceType}");
        assetImage =
            AssetImage('assets/instructions/polar_h9_h10_instructions.png');
        break;

      case PolarDeviceManager polarManager
          // when widget.device.type == PolarDevice.DEVICE_TYPE &&
          //     (widget.device.deviceManager as PolarDeviceManager).configuration?.deviceType == PolarDeviceType.SENSE
              :
              print("bbbb${polarManager.configuration?.deviceType}");
              print("bbbb${(widget.device.deviceManager as PolarDeviceManager).configuration?.deviceType}");
        assetImage =
            AssetImage('assets/instructions/polar_sense_instructions.png');
        break;

      case MovesenseDeviceManager ms:
      print("cccc${ms.configuration?.deviceType}");
        assetImage =
            AssetImage('assets/instructions/movesense_instructions.png');
        break;

      default:
      print("dddd${widget.device.deviceManager}");
        assetImage = AssetImage('assets/instructions/connect_to_hw.png');
    }

    Image connectionImage = Image(
      image: assetImage,
      width: MediaQuery.of(context).size.height * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
    );
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                connectionImage,
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
