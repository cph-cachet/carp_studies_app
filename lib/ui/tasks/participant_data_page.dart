part of carp_study_app;

enum ParticipantStep {
  presentTypes,
  address,
  diagnosis,
  fullName,
  informedConsent,
  phoneNumber,
  socialSecurityNumber,
  review
}

class ParticipantDataPage extends StatefulWidget {
  static const String route = '/participant_data';
  const ParticipantDataPage({super.key});

  @override
  ParticipantDataPageState createState() => ParticipantDataPageState();
}

class ParticipantDataPageState extends State<ParticipantDataPage> {
  ParticipantStep currentStep = ParticipantStep.presentTypes;
  final ParticipantDataPageViewModel model = ParticipantDataPageViewModel();

  final Set<StepField> _allUsedStepFields = {};

  bool _nextEnabled = false;

  /// Always include the present types step at the beginning
  /// and the review step at the end.
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
    ParticipantStep.review: 'Review',
  };

  @override
  void initState() {
    super.initState();
    for (final key in _stepMap.keys) {
      if (model.expectedData.any(
          (dataType) => dataType!.attribute!.inputDataType.contains(key))) {
        _includedSteps.add(_stepMap[key]!);
      }
    }

    /// Always include the review step at the end
    _includedSteps.add(ParticipantStep.review);

    model._nonOptionalControllers = {
      model._address1Controller,
      model._streetController,
      model._postalCodeController,
      model._countryController,
      model._effectiveDateController,
      model._icd11CodeController,
      model._conclusionController,
      model._firstNameController,
      model._lastNameController,
      model._informedConsentDescriptionController,
      model._phoneNumberCodeController,
      model._phoneNumberController,
      model._ssnCountryController,
      model._ssnController,
    };

    for (final controller in model._nonOptionalControllers) {
      controller.addListener(_validateRequiredFields);
    }

    model.address1Field = StepField(
      title: "tasks.participant_data.address.address1",
      controller: model._address1Controller,
      focusNode: model._address1FocusNode,
      nextFocusNode: model._address2FocusNode,
    );
    model.address2Field = StepField(
      title: "tasks.participant_data.address.address2",
      controller: model._address2Controller,
      focusNode: model._address2FocusNode,
      nextFocusNode: model._streetFocusNode,
    );
    model.streetField = StepField(
      title: "tasks.participant_data.address.street",
      controller: model._streetController,
      focusNode: model._streetFocusNode,
      nextFocusNode: model._postalCodeFocusNode,
    );
    model.postalCodeField = StepField(
      title: "tasks.participant_data.address.postal_code",
      controller: model._postalCodeController,
      focusNode: model._postalCodeFocusNode,
      nextFocusNode: model._countryFocusNode,
    );
    model.countryField = StepField(
      title: "tasks.participant_data.address.country",
      controller: model._countryController,
      focusNode: model._countryFocusNode,
    );

    model.effectiveDateField = StepField(
      title: "tasks.participant_data.diagnosis.effective_date",
      controller: model._effectiveDateController,
      focusNode: model._effectiveDateFocusNode,
      nextFocusNode: model._diagnosisDescriptionFocusNode,
    );
    model.diagnosisDescriptionField = StepField(
      title: "tasks.participant_data.diagnosis.diagnosis_description",
      controller: model._diagnosisDescriptionController,
      focusNode: model._diagnosisDescriptionFocusNode,
      nextFocusNode: model._icd11CodeFocusNode,
    );
    model.icd11CodeField = StepField(
      title: "tasks.participant_data.diagnosis.icd11_code",
      controller: model._icd11CodeController,
      focusNode: model._icd11CodeFocusNode,
      nextFocusNode: model._conclusionFocusNode,
    );
    model.conclusionField = StepField(
      title: "tasks.participant_data.diagnosis.conclusion",
      controller: model._conclusionController,
      focusNode: model._conclusionFocusNode,
    );

    model.firstNameField = StepField(
      title: "tasks.participant_data.full_name.first_name",
      controller: model._firstNameController,
      focusNode: model._firstNameFocusNode,
      nextFocusNode: model._middleNameFocusNode,
    );
    model.middleNameField = StepField(
      title: "tasks.participant_data.full_name.middle_name",
      controller: model._middleNameController,
      focusNode: model._middleNameFocusNode,
      nextFocusNode: model._lastNameFocusNode,
    );
    model.lastNameField = StepField(
      title: "tasks.participant_data.full_name.last_name",
      controller: model._lastNameController,
      focusNode: model._lastNameFocusNode,
    );

    model.informedConsentDescriptionField = StepField(
      title: "tasks.participant_data.informed_consent.description",
      controller: model._informedConsentDescriptionController,
    );

    model.phoneNumberField = StepField(
      title: "tasks.participant_data.phone_number.phone_number",
      controller: model._phoneNumberController,
    );

    model.ssnField = StepField(
      title: "tasks.participant_data.ssn.ssn",
      controller: model._ssnController,
    );
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  /// Validates the required fields based on the current step.
  /// Updates the [_nextEnabled] state variable accordingly.
  /// This method is called whenever a relevant text field changes.
  void _validateRequiredFields() {
    setState(() {
      switch (currentStep) {
        case ParticipantStep.address:
          _nextEnabled = model._address1Controller.text.isNotEmpty &&
              model._streetController.text.isNotEmpty &&
              model._postalCodeController.text.isNotEmpty &&
              model._countryController.text.isNotEmpty;
          break;
        case ParticipantStep.diagnosis:
          _nextEnabled = model._effectiveDateController.text.isNotEmpty &&
              model._icd11CodeController.text.isNotEmpty &&
              model._conclusionController.text.isNotEmpty;
          break;
        case ParticipantStep.fullName:
          _nextEnabled = model._firstNameController.text.isNotEmpty &&
              model._lastNameController.text.isNotEmpty;
          break;
        case ParticipantStep.informedConsent:
          _nextEnabled =
              model._informedConsentDescriptionController.text.isNotEmpty;
          break;
        case ParticipantStep.phoneNumber:
          _nextEnabled = model._phoneNumberController.text.isNotEmpty;
          break;
        case ParticipantStep.socialSecurityNumber:
          _nextEnabled = model._ssnController.text.isNotEmpty;
          break;
        case ParticipantStep.review:
          _nextEnabled = true;
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDialogTitle(locale),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            child:
                                _buildStepContent(locale, model.expectedData),
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

  /// Builds the title of the dialog based on the current step.
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
      ParticipantStep.review:
          locale.translate("tasks.participant_data.review.title"),
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

  /// Builds the content of the current step based on the [_includedSteps].
  Widget _buildStepContent(
      RPLocalizations locale, Set<ExpectedParticipantData?> expectedData) {
    List<Widget> fields = [];
    switch (currentStep) {
      case ParticipantStep.presentTypes:
        fields.add(_buildPresentTypes(
          _includedSteps
              .where((step) =>
                  step != ParticipantStep.presentTypes &&
                  step != ParticipantStep.review)
              .map((step) => participantStepDescriptions[step])
              .toList(),
        ));
        break;
      case ParticipantStep.address:
        fields.addAll([
          _buildField(locale, model.address1Field),
          _buildField(locale, model.address2Field, isOptional: true),
          _buildField(locale, model.streetField),
          _buildField(locale, model.postalCodeField),
          _buildField(locale, model.countryField),
        ]);
        break;
      case ParticipantStep.diagnosis:
        fields.addAll([
          _buildField(locale, model.effectiveDateField, isDatePicker: true),
          _buildField(locale, model.diagnosisDescriptionField,
              isOptional: true),
          _buildField(locale, model.icd11CodeField),
          _buildField(locale, model.conclusionField, isThicc: true),
        ]);
        break;
      case ParticipantStep.fullName:
        fields.addAll([
          _buildField(locale, model.firstNameField),
          _buildField(locale, model.middleNameField, isOptional: true),
          _buildField(locale, model.lastNameField),
        ]);
        break;
      case ParticipantStep.informedConsent:
        fields.add(_buildField(locale, model.informedConsentDescriptionField));
        break;
      case ParticipantStep.phoneNumber:
        fields.add(
            _buildField(locale, model.phoneNumberField, isPhoneNumber: true));
        break;
      case ParticipantStep.socialSecurityNumber:
        fields.add(_buildField(locale, model.ssnField, isCPR: true));
        break;
      case ParticipantStep.review:
        fields.add(_buildReviewStep(
          locale,
          _allUsedStepFields,
        ));
        break;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields,
      ),
    );
  }

  /// Builds the present types section and the review section, displaying the steps that are included
  Widget _buildPresentTypes(List<String?> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.map((step) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "\u2022 ${step ?? ''}",
            textAlign: TextAlign.start,
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

  /// Builds the review (last) step, displaying all the fields and their values.
  Widget _buildReviewStep(RPLocalizations locale, Set<StepField> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(fields.length, (index) {
        final String field = fields.elementAt(index).title;
        String input = "";
        if (index < fields.length) {
          if (fields.elementAt(index).controller ==
              model._phoneNumberController) {
            input =
                "${model._phoneNumberCodeController.text} ${fields.elementAt(index).controller.text}";
          } else if (fields.elementAt(index).controller ==
              model._ssnController) {
            input =
                "${model._ssnCountryController.text} ${fields.elementAt(index).controller.text}";
          } else {
            input = fields.elementAt(index).controller.text;
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.translate(field),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              Text(
                input,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Is used to build all the text fields in the participant data page.
  /// Is called as many times as the number of steps in each participant data page.
  Widget _buildField(
    RPLocalizations locale,
    StepField stepField, {
    bool isPhoneNumber = false,
    bool isCPR = false,
    bool isOptional = false,
    bool isThicc = false,
    bool isDatePicker = false,
  }) {
    _validateRequiredFields();
    _allUsedStepFields.add(stepField);
    if (isPhoneNumber) {
      return InternationalPhoneNumberInput(
        onInputChanged: (phoneNumber) {
          model._phoneNumberCodeController.text = phoneNumber.dialCode ?? '';
        },
        textFieldController: stepField.controller,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          useBottomSheetSafeArea: true,
        ),
        inputDecoration: _buildInputDecoration(locale, stepField, isThicc),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
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
                      stepField.controller.clear();
                      model._ssnCountryController.text = value.code ?? '';
                      stepField.controller.text = stepField.controller.text;
                    },
                    initialSelection: 'DK',
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
              controller: stepField.controller,
              decoration: _buildInputDecoration(locale, stepField, isThicc),
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
            padding: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
                controller: stepField.controller,
                focusNode: stepField.focusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  if (stepField.nextFocusNode != null) {
                    FocusScope.of(context)
                        .requestFocus(stepField.nextFocusNode);
                  }
                },
                onTap: isDatePicker
                    ? () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          stepField.controller.text =
                              "${pickedDate.toLocal()}".split(' ')[0];
                        }
                      }
                    : null,
                keyboardType: TextInputType.multiline,
                maxLines: isThicc ? null : 1,
                decoration: _buildInputDecoration(locale, stepField, isThicc)),
          ),
        ],
      );
    }
  }

  InputDecoration _buildInputDecoration(
      RPLocalizations locale, StepField stepField, bool isThicc) {
    return InputDecoration(
      labelText: locale.translate(stepField.title),
      floatingLabelBehavior: FloatingLabelBehavior.always,
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
    );
  }

  /// Builds the action buttons at the bottom of the page.
  /// Includes "Cancel", "Previous", "Next", and "Submit" buttons.
  /// The "Next" button is enabled only if the required fields for the current step are filled.
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
      currentStep == ParticipantStep.presentTypes
          ? buildTranslatedButton("cancel", () {
              context.pop();
            }, true, null, null)
          : buildTranslatedButton("previous", () {
              setState(() {
                final idx = _includedSteps.indexOf(currentStep);
                if (currentStep.index - 1 >= 0) {
                  currentStep = _includedSteps[idx - 1];
                }
              });
            }, true, null, null),
      currentStep.index == ParticipantStep.values.length - 1
          ? buildTranslatedButton(
              "submit",
              () {
                bloc.setParticipantData(
                  bloc.study!.studyDeploymentId,
                  _setParticipantData(),
                  bloc.study!.participantRoleName,
                );
              },
              _nextEnabled,
              ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).extension<RPColors>()!.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              TextStyle(
                color: Colors.white,
              ),
            )
          : buildTranslatedButton(
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
                backgroundColor:
                    Theme.of(context).extension<RPColors>()!.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              TextStyle(
                color: Colors.white,
              ),
            ),
    ];
  }

  Map<String, Data> _setParticipantData() {
    // This method can be used to set the participant data
    // if needed before submitting.
    // Currently, it is called when the "Submit" button is pressed.

    final Map<String, Data> participantData = {};

    final Map<ParticipantStep, Map<String, Data>> participantStepToDataType = {
      ParticipantStep.address: {
        AddressInput.type: AddressInput(
          address1: model._address1Controller.text,
          address2: model._address2Controller.text,
          street: model._streetController.text,
          postalCode: model._postalCodeController.text,
          country: model._countryController.text,
        ),
      },
      ParticipantStep.diagnosis: {
        DiagnosisInput.type: DiagnosisInput(
          effectiveDate: DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
              .parse('${model._effectiveDateController.text}T00:00:00Z')
              .toUtc(),
          diagnosis: model._diagnosisDescriptionController.text,
          icd11Code: model._icd11CodeController.text,
          conclusion: model._conclusionController.text,
        ),
      },
      ParticipantStep.fullName: {
        FullNameInput.type: FullNameInput(
          firstName: model._firstNameController.text,
          middleName: model._middleNameController.text,
          lastName: model._lastNameController.text,
        ),
      },
      ParticipantStep.phoneNumber: {
        PhoneNumberInput.type: PhoneNumberInput(
          countryCode: model._phoneNumberCodeController.text,
          number: model._phoneNumberController.text,
        ),
      },
      ParticipantStep.socialSecurityNumber: {
        SocialSecurityNumberInput.type: SocialSecurityNumberInput(
          country: model._ssnCountryController.text,
          socialSecurityNumber: model._ssnController.text,
        ),
      },
    };
    for (final step in _includedSteps) {
      final dataMap = participantStepToDataType[step];
      if (dataMap != null) {
        participantData.addAll(dataMap);
      }
    }
    LocalSettings().isExpectedParticipantDataSet = true;
    return participantData;
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

class StepField {
  final String title;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  StepField({
    required this.title,
    required this.controller,
    this.focusNode,
    this.nextFocusNode,
  });
}
