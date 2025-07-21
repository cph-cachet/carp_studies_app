part of carp_study_app;

enum ParticipantStep {
  presentTypes,
  address,
  diagnosis,
  fullName,
  informedConsent,
  phoneNumber,
  socialSecurityNumber
}

class ParticipantDataPage extends StatefulWidget {
  static const String route = '/participant_data';
  const ParticipantDataPage({super.key});

  @override
  ParticipantDataPageState createState() => ParticipantDataPageState();
}

class ParticipantDataPageState extends State<ParticipantDataPage> {
  ParticipantStep currentStep = ParticipantStep.presentTypes;
  Set<ExpectedParticipantData?> expectedData = bloc.expectedParticipantData;

  late final List<TextEditingController> _requiredControllers;
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _effectiveDateController =
      TextEditingController();
  final TextEditingController _diagnosisDescriptionController =
      TextEditingController();
  final TextEditingController _icd11CodeController = TextEditingController();
  final TextEditingController _conclusionController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _informedConsentDescriptionController =
      TextEditingController();

  final TextEditingController _ssnController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  bool _nextEnabled = false;

  final List<ParticipantStep> _includedSteps = [ParticipantStep.presentTypes];

  final Map<String, ParticipantStep> _stepMap = {
    "address": ParticipantStep.address,
    "diagnosis": ParticipantStep.diagnosis,
    "full_name": ParticipantStep.fullName,
    "informed_consent": ParticipantStep.informedConsent,
    "phone_number": ParticipantStep.phoneNumber,
    "ssn": ParticipantStep.socialSecurityNumber,
  };

  final Map<ParticipantStep, String> participantStepDescriptions = {
    ParticipantStep.address: 'Address',
    ParticipantStep.diagnosis: 'Diagnosis',
    ParticipantStep.fullName: 'Full Name',
    ParticipantStep.informedConsent: 'Informed Consent',
    ParticipantStep.phoneNumber: 'Phone Number',
    ParticipantStep.socialSecurityNumber: 'Social Security Number',
  };

  @override
  void initState() {
    super.initState();
    for (final key in _stepMap.keys) {
      if (expectedData.any(
          (dataType) => dataType!.attribute!.inputDataType.contains(key))) {
        _includedSteps.add(_stepMap[key]!);
      }
    }

    _requiredControllers = [
      _address1Controller,
      _streetController,
      _postalCodeController,
      _countryController,
      _effectiveDateController,
      _icd11CodeController,
      _conclusionController,
      _firstNameController,
      _lastNameController,
      _informedConsentDescriptionController,
      _phoneNumberController,
      _ssnController,
    ];

    for (final controller in _requiredControllers) {
      controller.addListener(_validateRequiredFields);
    }
  }

  @override
  void dispose() {
    _address1Controller.dispose();
    _address2Controller.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _effectiveDateController.dispose();
    _diagnosisDescriptionController.dispose();
    _icd11CodeController.dispose();
    _conclusionController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _informedConsentDescriptionController.dispose();
    _phoneNumberController.dispose();
    _ssnController.dispose();
    super.dispose();
  }

  void _validateRequiredFields() {
    setState(() {
      switch (currentStep) {
        case ParticipantStep.address:
          _nextEnabled = _address1Controller.text.isNotEmpty &&
              _streetController.text.isNotEmpty &&
              _postalCodeController.text.isNotEmpty &&
              _countryController.text.isNotEmpty;
          break;
        case ParticipantStep.diagnosis:
          _nextEnabled = _effectiveDateController.text.isNotEmpty &&
              _icd11CodeController.text.isNotEmpty &&
              _conclusionController.text.isNotEmpty;
          break;
        case ParticipantStep.fullName:
          _nextEnabled = _firstNameController.text.isNotEmpty &&
              _lastNameController.text.isNotEmpty;
          break;
        case ParticipantStep.informedConsent:
          _nextEnabled = _informedConsentDescriptionController.text.isNotEmpty;
          break;
        case ParticipantStep.phoneNumber:
          _nextEnabled = _phoneNumberController.text.isNotEmpty;
          break;
        case ParticipantStep.socialSecurityNumber:
          _nextEnabled = _ssnController.text.isNotEmpty;
          break;
        default:
          _nextEnabled = false;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: const CarpAppBar(
                      hasProfileIcon: false,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    color: Theme.of(context).extension<RPColors>()!.grey900!,
                    onPressed: () {
                      _showCancelConfirmationDialog();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      _buildDialogTitle(locale),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            child: _buildStepContent(locale, expectedData),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _buildActionButtons(locale),
                        ),
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
      ParticipantStep.presentTypes:
          locale.translate("tasks.participant_data.present_data.title"),
      ParticipantStep.address:
          locale.translate("tasks.participant_data.address.title"),
      ParticipantStep.diagnosis:
          locale.translate("tasks.participant_data.diagnosis.title"),
      ParticipantStep.fullName:
          locale.translate("tasks.participant_data.full_name.title"),
      ParticipantStep.informedConsent:
          locale.translate("tasks.participant_data.informed_consent.title"),
      ParticipantStep.phoneNumber:
          locale.translate("tasks.participant_data.phone_number.title"),
      ParticipantStep.socialSecurityNumber:
          locale.translate("tasks.participant_data.ssn.title"),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                stepTitleMap[currentStep] ?? '',
                style: healthServiceConnectMessageStyle.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(
      RPLocalizations locale, Set<ExpectedParticipantData?> expectedData) {
    final stepContentMap = {
      ParticipantStep.presentTypes: [
        _buildPresentTypes(
          _includedSteps,
        )
      ],
      ParticipantStep.address: [
        _buildField(locale, _address1Controller,
            title: "tasks.participant_data.address.address1"),
        _buildField(locale, _address2Controller,
            title: "tasks.participant_data.address.address2"),
        _buildField(locale, _streetController,
            title: "tasks.participant_data.address.street"),
        _buildField(locale, _postalCodeController,
            title: "tasks.participant_data.address.postal_code"),
        _buildField(locale, _countryController,
            title: "tasks.participant_data.address.country"),
      ],
      ParticipantStep.diagnosis: [
        _buildField(locale, _effectiveDateController,
            title: "tasks.participant_data.diagnosis.effective_date"),
        _buildField(locale, _diagnosisDescriptionController,
            title: "tasks.participant_data.diagnosis.diagnosis_description",
            isOptional: true),
        _buildField(locale, _icd11CodeController,
            title: "tasks.participant_data.diagnosis.icd11_code"),
        _buildField(locale, _conclusionController,
            title: "tasks.participant_data.diagnosis.conclusion",
            isThicc: true),
      ],
      ParticipantStep.fullName: [
        _buildField(locale, _firstNameController,
            title: "tasks.participant_data.full_name.first_name"),
        _buildField(
          locale,
          _middleNameController,
          title: "tasks.participant_data.full_name.middle_name",
          isOptional: true,
        ),
        _buildField(locale, _lastNameController,
            title: "tasks.participant_data.full_name.last_name"),
      ],
      ParticipantStep.informedConsent: [
        _buildField(locale, _informedConsentDescriptionController,
            title: "tasks.participant_data.informed_consent.description"),
      ],
      ParticipantStep.socialSecurityNumber: [
        _buildField(locale, _ssnController,
            title: "tasks.participant_data.ssn.country", isCPR: true),
      ],
      ParticipantStep.phoneNumber: [
        _buildField(locale, _phoneNumberController,
            title: "tasks.participant_data.phone_number.country",
            isPhoneNumber: true),
      ],
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...(stepContentMap[currentStep] ?? []),
        ],
      ),
    );
  }

  Widget _buildPresentTypes(List<ParticipantStep> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .where((step) => step != ParticipantStep.presentTypes)
          .map((step) {
        final description = participantStepDescriptions[step] ?? '';
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildField(
    RPLocalizations locale,
    TextEditingController controller, {
    required String title,
    bool isPhoneNumber = false,
    bool isCPR = false,
    bool isOptional = false,
    bool isThicc = false,
  }) {
    _validateRequiredFields();
    if (isPhoneNumber) {
      return InternationalPhoneNumberInput(
        onInputChanged: (phoneNumber) {
          print(phoneNumber.phoneNumber);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          useBottomSheetSafeArea: true,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        textFieldController: controller,
        formatInput: true,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
      );
    } else if (isCPR) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 125,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).extension<RPColors>()!.grey600!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: CountryCodePicker(
                    onChanged: (value) {
                      controller.text =
                          '${value.code}${_phoneNumberController.text}';
                    },
                    // initialSelection: country,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: false,
                    textStyle: audioContentStyle.copyWith(
                      color: Theme.of(context).extension<RPColors>()!.grey900!,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              onChanged: (value) {
                controller.text = value;
              },
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              locale.translate(title),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              onChanged: (value) {
                controller.text = value;
              },
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: isThicc ? null : 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding: isThicc
                    ? const EdgeInsets.symmetric(horizontal: 16, vertical: 70)
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      );
    }
  }

  List<Widget> _buildActionButtons(RPLocalizations locale) {
    Widget buildTranslatedButton(String key, VoidCallback onPressed,
        bool enabled, ButtonStyle? buttonStyle, TextStyle? buttonTextStyle) {
      return ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: Text(
          locale.translate(key).toUpperCase(),
          style: buttonTextStyle,
        ),
        style: buttonStyle,
      );
    }

    return [
      buildTranslatedButton("previous", () {
        setState(() {
          final idx = _includedSteps.indexOf(currentStep);
          if (currentStep.index - 1 >= 0) {
            currentStep = _includedSteps[idx - 1];
          }
        });
      }, true, null, null),
      buildTranslatedButton(
        "next",
        () {
          setState(() {
            final idx = _includedSteps.indexOf(currentStep);
            if (currentStep.index + 1 < ParticipantStep.values.length) {
              currentStep = _includedSteps[idx + 1];
            }
          });
        },
        currentStep == ParticipantStep.presentTypes ? true : _nextEnabled,
        ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).extension<RPColors>()!.primary,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        TextStyle(
          color: Colors.white,
        ),
      ),
    ];
  }

  Future<void> _showCancelConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.translate("pages.audio_task.discard")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                context.pop();
                context.pop();
              },
            )
          ],
        );
      },
    );
  }
}
