part of carp_study_app;

class ParticipantDataPageViewModel extends ViewModel {
  Set<ExpectedParticipantData?> get expectedData =>
      bloc.expectedParticipantData;

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

  final TextEditingController _ssnCountryController =
      TextEditingController(text: "DK");
  final TextEditingController _ssnController = TextEditingController();

  final TextEditingController _phoneNumberCodeController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _address1FocusNode = FocusNode();
  final FocusNode _address2FocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _postalCodeFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _effectiveDateFocusNode = FocusNode();
  final FocusNode _diagnosisDescriptionFocusNode = FocusNode();
  final FocusNode _icd11CodeFocusNode = FocusNode();
  final FocusNode _conclusionFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

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
