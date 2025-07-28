part of carp_study_app;

class ParticipantDataPageViewModel extends ViewModel {
  Set<ExpectedParticipantData?> get expectedData =>
      bloc.expectedParticipantData;

  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _streetController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;

  late TextEditingController _effectiveDateController;
  late TextEditingController _diagnosisDescriptionController;
  late TextEditingController _icd11CodeController;
  late TextEditingController _conclusionController;

  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  late TextEditingController _informedConsentDescriptionController;

  late TextEditingController _phoneNumberCodeController;
  late TextEditingController _phoneNumberController;

  late TextEditingController _ssnCountryController;
  late TextEditingController _ssnController;

  late FocusNode _address1FocusNode;
  late FocusNode _address2FocusNode;
  late FocusNode _streetFocusNode;
  late FocusNode _postalCodeFocusNode;
  late FocusNode _countryFocusNode;
  late FocusNode _effectiveDateFocusNode;
  late FocusNode _diagnosisDescriptionFocusNode;
  late FocusNode _icd11CodeFocusNode;
  late FocusNode _conclusionFocusNode;
  late FocusNode _firstNameFocusNode;
  late FocusNode _middleNameFocusNode;
  late FocusNode _lastNameFocusNode;

  late StepField address1Field;
  late StepField address2Field;
  late StepField streetField;
  late StepField postalCodeField;
  late StepField countryField;
  late StepField effectiveDateField;
  late StepField diagnosisDescriptionField;
  late StepField icd11CodeField;
  late StepField conclusionField;
  late StepField firstNameField;
  late StepField middleNameField;
  late StepField lastNameField;
  late StepField informedConsentDescriptionField;
  late StepField phoneNumberField;
  late StepField ssnField;

  late Set<TextEditingController> _nonOptionalControllers;

  @override
  void clear() {
    _address1Controller.clear();
    _address2Controller.clear();
    _streetController.clear();
    _postalCodeController.clear();
    _countryController.clear();
    _effectiveDateController.clear();
    _diagnosisDescriptionController.clear();
    _icd11CodeController.clear();
    _conclusionController.clear();
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _informedConsentDescriptionController.clear();
    _phoneNumberCodeController.clear();
    _phoneNumberController.clear();
    _ssnCountryController.clear();
    _ssnController.clear();
    _address1FocusNode.unfocus();
    _address2FocusNode.unfocus();
    _streetFocusNode.unfocus();
    _postalCodeFocusNode.unfocus();
    _countryFocusNode.unfocus();
    _effectiveDateFocusNode.unfocus();
    _diagnosisDescriptionFocusNode.unfocus();
    _icd11CodeFocusNode.unfocus();
    _conclusionFocusNode.unfocus();
    _firstNameFocusNode.unfocus();
    _middleNameFocusNode.unfocus();
    _lastNameFocusNode.unfocus();
    _nonOptionalControllers.clear();
    super.clear();
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
    _phoneNumberCodeController.dispose();
    _phoneNumberController.dispose();
    _ssnCountryController.dispose();
    _ssnController.dispose();
    super.dispose();
  }
}
