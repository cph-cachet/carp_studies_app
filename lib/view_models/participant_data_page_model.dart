part of carp_study_app;

class ParticipantDataPageViewModel extends ViewModel {
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
  late StepField ssnField;
  late StepField phoneNumberField;

  late final Set<TextEditingController> _nonOptionalControllers;

}