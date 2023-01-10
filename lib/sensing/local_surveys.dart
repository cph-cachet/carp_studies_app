part of carp_study_app;

final surveys = _Surveys();

class _Surveys {
  final Survey _who5 = _WHO5Survey();
  Survey get who5 => _who5;

  final Survey _demographics = _DemographicSurvey();
  Survey get demographics => _demographics;

  final Survey _symptoms = _SymptomsSurvey();
  Survey get symptoms => _symptoms;

  final Survey _parkinsons = _ParkinsonsSurvey();
  Survey get parkinsons => _parkinsons;

  final Survey _parnas = _PARNASSurvey();
  Survey get parnas => _parnas;

  final Survey _exposure = _ExposureSurvey();
  Survey get exposure => _exposure;

  final Survey _control = _ControlSurvey();
  Survey get control => _control;

  final Survey _controlParents = _ControlParentsSurvey();
  Survey get controlParents => _controlParents;

  final Survey _patient = _PatientSurvey();
  Survey get patient => _patient;

  final Survey _patientParents = _PatientParentsSurvey();
  Survey get patientParents => _patientParents;

  final Survey _ecological = _EcologicalSurvey();
  Survey get ecological => _ecological;

  final Survey _ecologicalParents = _EcologicalParentsSurvey();
  Survey get ecologicalParents => _ecologicalParents;

  final Survey _appUX = _AppUXSurvey();
  Survey get appUX => _appUX;

  final Survey _informedConsent = _InformedConsentSurvey();
  Survey get informedConsent => _informedConsent;

  final Survey _trustScale = _TrustScaleSurvey();
  Survey get trustScale => _trustScale;

  final Survey _timedExposure = _TimedExposureSurvey();
  Survey get timedExposure => _timedExposure;

  final Survey _symptomHierarchyObsessions =
      _SymptomHierarchySurveyObsessions();
  Survey get symptomHierarchyObsessions => _symptomHierarchyObsessions;

  final Survey _symptomHierarchyCompulsions =
      _SymptomHierarchySurveyCompulsions();
  Survey get symptomHierarchyCoumpulsions => _symptomHierarchyCompulsions;
}

abstract class Survey {
  /// The title of this survey.
  String get title;

  /// A short description (one line) of this survey
  String get description;

  /// How many minutes will it take to do this survey?
  int get minutesToComplete;

  /// The duration of this app task, i.e. when it expire
  Duration get expire;

  /// The survey to fill out.
  RPTask get survey;
}

class _SymptomHierarchySurveyObsessions implements Survey {
  @override
  String get title => "survey.symptoms.obsessions.title";

  @override
  String get description => "survey.symptoms.obsessions.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.symptoms.obsessions.title", steps: [
        RPInstructionStep(
            identifier: "survey.symptoms.obsessions.instruction.id",
            title: "survey.symptoms.obsessions.instruction.title",
            text: "survey.symptoms.obsessions.instruction.text"),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.1.id",
          title: "survey.symptoms.obsessions.question.1.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.2.id",
          title: "survey.symptoms.obsessions.question.2.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.3.id",
          title: "survey.symptoms.obsessions.question.3.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.4.id",
          title: "survey.symptoms.obsessions.question.4.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.5.id",
          title: "survey.symptoms.obsessions.question.5.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.6.id",
          title: "survey.symptoms.obsessions.question.6.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.7.id",
          title: "survey.symptoms.obsessions.question.7.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.8.id",
          title: "survey.symptoms.obsessions.question.8.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.9.id",
          title: "survey.symptoms.obsessions.question.9.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.obsessions.question.10.id",
          title: "survey.symptoms.obsessions.question.10.title",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
            identifier: "survey.symptoms.obsessions.completition.id",
            title: "survey.symptoms.obsessions.completition.title",
            text: "survey.symptoms.obsessions.completition.text")
      ]);
}

class _SymptomHierarchySurveyCompulsions implements Survey {
  @override
  String get title => "survey.symptoms.compulsions.title";

  @override
  String get description => "survey.symptoms.compulsions.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.symptoms.compulsions.title", steps: [
        RPInstructionStep(
            identifier: "survey.symptoms.compulsions.instruction.id",
            title: "survey.symptoms.compulsions.instruction.title",
            text: "survey.symptoms.compulsions.instruction.text"),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.1.id",
          title: "survey.symptoms.compulsions.question.1.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.2.id",
          title: "survey.symptoms.compulsions.question.2.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.3.id",
          title: "survey.symptoms.compulsions.question.3.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.4.id",
          title: "survey.symptoms.compulsions.question.4.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.5.id",
          title: "survey.symptoms.compulsions.question.5.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.6.id",
          title: "survey.symptoms.compulsions.question.6.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.7.id",
          title: "survey.symptoms.compulsions.question.7.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.8.id",
          title: "survey.symptoms.compulsions.question.8.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.9.id",
          title: "survey.symptoms.compulsions.question.9.title",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.symptoms.compulsions.question.10.id",
          title: "survey.symptoms.compulsions.question.10.title",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
          identifier: "survey.symptoms.compulsions.completition.id",
          title: "survey.symptoms.compulsions.completition.title",
          text: "survey.symptoms.compulsions.completition.text",
        )
      ]);
}

class _TimedExposureSurvey implements Survey {
  @override
  String get title => "survey.symptoms.exposure.title";

  @override
  String get description => "survey.symptoms.exposure.description";

  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 10;

  final RPImageChoiceAnswerFormat _imageChoiceAnswerFormat =
      RPImageChoiceAnswerFormat(choices: [
    RPImageChoice(
        imageUrl: 'assets/icons/very-sad.png',
        value: 4,
        description: "survey.answerFormat.discomfort.unbearable"),
    RPImageChoice(
        imageUrl: 'assets/icons/sad.png',
        value: 3,
        description: "survey.answerFormat.discomfort.very"),
    RPImageChoice(
        imageUrl: 'assets/icons/ok.png',
        value: 2,
        description: "survey.answerFormat.discomfort.quite"),
    RPImageChoice(
        imageUrl: 'assets/icons/happy.png',
        value: 1,
        description: "survey.answerFormat.discomfort.certain"),
    RPImageChoice(
        imageUrl: 'assets/icons/very-happy.png',
        value: 0,
        description: "survey.answerFormat.discomfort.calm"),
  ]);

  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.symptoms.exposure.title", steps: [
        RPQuestionStep(
          identifier: "survey.symptoms.exposure.question.1.id",
          title: "survey.symptoms.exposure.question.1.text",
          answerFormat: _imageChoiceAnswerFormat,
        ),
      ]);
}

class _TrustScaleSurvey implements Survey {
  @override
  String get title => "survey.trustscale.title";

  @override
  String get description => "survey.trustscale.description";

  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.disagree", value: 0),
        RPChoice(text: "survey.answerFormat.agreement.disagree", value: 1),
        RPChoice(text: "survey.answerFormat.agreement.agree", value: 2),
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.agree", value: 3),
      ]);

  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.trustscale.title", steps: [
        RPInstructionStep(
            identifier: "survey.trustscale.instruction.id",
            title: "survey.trustscale.instruction.title",
            imagePath: 'assets/icons/smartphone.png',
            text: "survey.trustscale.instruction.text"),
        RPQuestionStep(
          identifier: "survey.trustscale.question.1.id",
          title: "survey.trustscale.question.1.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.2.id",
          title: "survey.trustscale.question.2.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.3.id",
          title: "survey.trustscale.question.3.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.4.id",
          title: "survey.trustscale.question.4.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.5.id",
          title: "survey.trustscale.question.5.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.6.id",
          title: "survey.trustscale.question.6.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.7.id",
          title: "survey.trustscale.question.7.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.8.id",
          title: "survey.trustscale.question.8.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.9.id",
          title: "survey.trustscale.question.9.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.10.id",
          title: "survey.trustscale.question.10.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.11.id",
          title: "survey.trustscale.question.11.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.12.id",
          title: "survey.trustscale.question.12.title",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.trustscale.question.13.id",
          title: "survey.trustscale.question.13.title",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
            identifier: "survey.trustscale.completition.id",
            title: "survey.trustscale.completition.title",
            text: "survey.trustscale.completition.text")
      ]);
}

class _InformedConsentSurvey implements Survey {
  @override
  String get title => "survey.informedconsent.title";

  @override
  String get description => "survey.informedconsent.description";

  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 4;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.understandable.extremely.not", value: 0),
        RPChoice(
            text: "survey.answerFormat.understandable.mostly.not", value: 1),
        RPChoice(
            text: "survey.answerFormat.understandable.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.understandable.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.navigable.extremely.easy", value: 0),
        RPChoice(text: "survey.answerFormat.navigable.mostly.easy", value: 1),
        RPChoice(
            text: "survey.answerFormat.navigable.mostly.difficult", value: 2),
        RPChoice(
            text: "survey.answerFormat.navigable.extremely.difficult",
            value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.value.extremely.valuable", value: 0),
        RPChoice(text: "survey.answerFormat.value.mostly.valuable", value: 1),
        RPChoice(text: "survey.answerFormat.value.mostly.inferior", value: 2),
        RPChoice(
            text: "survey.answerFormat.value.extremely.inferior", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.excitement.extremely.boring", value: 0),
        RPChoice(
            text: "survey.answerFormat.excitement.mostly.boring", value: 1),
        RPChoice(text: "survey.answerFormat.excitement.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.excitement.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.interesting.extremely.not", value: 0),
        RPChoice(text: "survey.answerFormat.interesting.mostly.not", value: 1),
        RPChoice(text: "survey.answerFormat.interesting.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.interesting.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.speed.extremely.fast", value: 0),
        RPChoice(text: "survey.answerFormat.speed.mostly.fast", value: 1),
        RPChoice(text: "survey.answerFormat.speed.mostly.slow", value: 2),
        RPChoice(text: "survey.answerFormat.speed.extremely.slow", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.complexity.extremely.complicated",
            value: 0),
        RPChoice(
            text: "survey.answerFormat.complexity.mostly.complicated",
            value: 1),
        RPChoice(text: "survey.answerFormat.complexity.mostly.easy", value: 2),
        RPChoice(
            text: "survey.answerFormat.complexity.extremely.easy", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.motivation.extremely.yes", value: 0),
        RPChoice(text: "survey.answerFormat.motivation.mostly.yes", value: 1),
        RPChoice(text: "survey.answerFormat.motivation.mostly.not", value: 2),
        RPChoice(
            text: "survey.answerFormat.motivation.extremely.not", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat9 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.efficiency.extremely.not", value: 0),
        RPChoice(text: "survey.answerFormat.efficiency.mostly.not", value: 1),
        RPChoice(text: "survey.answerFormat.efficiency.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.efficiency.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat10 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.clarity.extremely.clear", value: 0),
        RPChoice(text: "survey.answerFormat.clarity.mostly.clear", value: 1),
        RPChoice(
            text: "survey.answerFormat.clarity.mostly.confusing", value: 2),
        RPChoice(
            text: "survey.answerFormat.clarity.extremely.confusing", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat11 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.practicality.extremely.not", value: 0),
        RPChoice(text: "survey.answerFormat.practicality.mostly.not", value: 1),
        RPChoice(text: "survey.answerFormat.practicality.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.practicality.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat12 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.organization.extremely.organized",
            value: 0),
        RPChoice(
            text: "survey.answerFormat.organization.mostly.organized",
            value: 1),
        RPChoice(
            text: "survey.answerFormat.organization.mostly.cluttered",
            value: 2),
        RPChoice(
            text: "survey.answerFormat.organization.extremely.cluttered",
            value: 3),
      ]);
  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.informedconsent.title", steps: [
        RPInstructionStep(
            identifier: "survey.informedconsent.instruction.id",
            title: "survey.informedconsent.instruction.title",
            imagePath: 'assets/icons/smartphone.png',
            text: "survey.informedconsent.instruction.text"),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.1.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.2.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.3.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.4.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.5.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.6.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.7.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.8.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat8,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.9.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat9,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.10.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat10,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.11.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat11,
        ),
        RPQuestionStep(
          identifier: "survey.informedconsent.question.12.id",
          title: "survey.informedconsent.question.text",
          answerFormat: choiceAnswerFormat12,
        ),
        RPCompletionStep(
            identifier: "survey.informedconsent.completition.id",
            title: "survey.informedconsent.completition.title",
            text: "survey.informedconsent.completition.text")
      ]);
}

class _AppUXSurvey implements Survey {
  @override
  String get title => "survey.appux.title";

  @override
  String get description => "survey.appux.description";

  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.support.extremely.obstructive",
            value: 0),
        RPChoice(
            text: "survey.answerFormat.support.mostly.obstructive", value: 1),
        RPChoice(
            text: "survey.answerFormat.support.mostly.supportive", value: 2),
        RPChoice(
            text: "survey.answerFormat.support.extremely.supportive", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.difficulty.extremely.complicated",
            value: 0),
        RPChoice(
            text: "survey.answerFormat.difficulty.mostly.complicated",
            value: 1),
        RPChoice(text: "survey.answerFormat.difficulty.mostly.easy", value: 2),
        RPChoice(
            text: "survey.answerFormat.difficulty.extremely.easy", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.efficiency.extremely.not", value: 0),
        RPChoice(text: "survey.answerFormat.efficiency.mostly.not", value: 1),
        RPChoice(text: "survey.answerFormat.efficiency.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.efficiency.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.clarity.extremely.confusing", value: 0),
        RPChoice(
            text: "survey.answerFormat.clarity.mostly.confusing", value: 1),
        RPChoice(text: "survey.answerFormat.clarity.mostly.clear", value: 2),
        RPChoice(text: "survey.answerFormat.clarity.extremely.clear", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.excitement.extremely.boring", value: 0),
        RPChoice(
            text: "survey.answerFormat.excitement.mostly.boring", value: 1),
        RPChoice(
            text: "survey.answerFormat.excitement.mostly.exciting", value: 2),
        RPChoice(
            text: "survey.answerFormat.excitement.extremely.exciting",
            value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.interesting.extremely.not", value: 0),
        RPChoice(text: "survey.answerFormat.interesting.mostly.not", value: 1),
        RPChoice(text: "survey.answerFormat.interesting.mostly.yes", value: 2),
        RPChoice(
            text: "survey.answerFormat.interesting.extremely.yes", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.conventionality.extremely.conventional",
            value: 0),
        RPChoice(
            text: "survey.answerFormat.conventionality.mostly.conventional",
            value: 1),
        RPChoice(
            text: "survey.answerFormat.conventionality.mostly.inventive",
            value: 2),
        RPChoice(
            text: "survey.answerFormat.conventionality.extremely.inventive",
            value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.innovation.extremely.usual", value: 0),
        RPChoice(text: "survey.answerFormat.innovation.mostly.usual", value: 1),
        RPChoice(
            text: "survey.answerFormat.innovation.mostly.leading", value: 2),
        RPChoice(
            text: "survey.answerFormat.innovation.extremely.leading", value: 3),
      ]);

  @override
  RPTask get survey => RPOrderedTask(identifier: "survey.appux.title", steps: [
        RPInstructionStep(
            identifier: "survey.appux.instruction.id",
            title: "survey.appux.instruction.title",
            imagePath: 'assets/icons/smartphone.png',
            text: "survey.appux.instruction.text"),
        RPQuestionStep(
          identifier: "survey.appux.question.1.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.2.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.3.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.4.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.5.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.6.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.7.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          identifier: "survey.appux.question.8.id",
          title: "survey.appux.question.text",
          answerFormat: choiceAnswerFormat8,
        ),
        RPCompletionStep(
            identifier: "survey.appux.completition.id",
            title: "survey.appux.completition.title",
            text: "survey.appux.completition.text")
      ]);
}

class _EcologicalParentsSurvey implements Survey {
  @override
  String get title => "survey.ecological.parents.title";

  @override
  String get description => "survey.ecological.parents.description";

  @override
  Duration get expire => const Duration(days: 1);

  @override
  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.no", value: 0),
        RPChoice(text: "survey.answerFormat.yes", value: 1),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.instensity.slightly", value: 1),
        RPChoice(text: "survey.answerFormat.instensity.little", value: 2),
        RPChoice(text: "survey.answerFormat.instensity.moderately", value: 3),
        RPChoice(text: "survey.answerFormat.instensity.quite", value: 4),
        RPChoice(text: "survey.answerFormat.instensity.extremely", value: 5),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.company.alone", value: 0),
        RPChoice(text: "survey.answerFormat.company.child", value: 1),
        RPChoice(text: "survey.answerFormat.company.other.child", value: 2),
        RPChoice(text: "survey.answerFormat.company.other.parent", value: 3),
        RPChoice(text: "survey.answerFormat.company.friend", value: 4),
        RPChoice(text: "survey.answerFormat.company.others", value: 5)
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.ecological.parents.title",
        steps: [
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.1.id",
            title: "survey.ecological.parents.question.1.text",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep(
              identifier: "survey.ecological.parents.instruction.id",
              title: "survey.ecological.parents.instruction.title",
              text: "survey.ecological.parents.instruction.text"),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.2.id",
            title: "survey.ecological.parents.question.2.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.3.id",
            title: "survey.ecological.parents.question.3.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.4.id",
            title: "survey.ecological.parents.question.4.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.5.id",
            title: "survey.ecological.parents.question.5.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.6.id",
            title: "survey.ecological.parents.question.6.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.7.id",
            title: "survey.ecological.parents.question.7.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.8.id",
            title: "survey.ecological.parents.question.8.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.9.id",
            title: "survey.ecological.parents.question.9.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.10.id",
            title: "survey.ecological.parents.question.10.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.parents.question.11.id",
            title: "survey.ecological.parents.question.11.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep(
            identifier: "survey.ecological.parents.completition.id",
            title: "survey.ecological.parents.completition.title",
            text: "survey.ecological.parents.completition.text",
          )
        ],
      );
}

class _EcologicalSurvey implements Survey {
  @override
  String get title => "survey.ecological.child.title";

  @override
  String get description => "survey.ecological.child.description";

  @override
  Duration get expire => const Duration(days: 1);

  @override
  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.no", value: 0),
        RPChoice(text: "survey.answerFormat.yes", value: 1),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.instensity.slightly", value: 1),
        RPChoice(text: "survey.answerFormat.instensity.little", value: 2),
        RPChoice(text: "survey.answerFormat.instensity.moderately", value: 3),
        RPChoice(text: "survey.answerFormat.instensity.quite", value: 4),
        RPChoice(text: "survey.answerFormat.instensity.extremely", value: 5),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.company.alone", value: 0),
        RPChoice(text: "survey.answerFormat.company.parent", value: 1),
        RPChoice(text: "survey.answerFormat.company.other.parent", value: 2),
        RPChoice(text: "survey.answerFormat.company.sibling", value: 3),
        RPChoice(text: "survey.answerFormat.company.friend", value: 4),
        RPChoice(text: "survey.answerFormat.company.others", value: 5)
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.ecological.child.title",
        steps: [
          RPQuestionStep(
            identifier: "survey.ecological.child.question.1.id",
            title: "survey.ecological.child.question.1.text",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep(
              identifier: "survey.ecological.child.instruction.id",
              title: "survey.ecological.child.instruction.title",
              imagePath: 'assets/icons/survey.png',
              text: "survey.ecological.child.instruction.text"),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.2.id",
            title: "survey.ecological.child.question.2.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.3.id",
            title: "survey.ecological.child.question.3.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.4.id",
            title: "survey.ecological.child.question.4.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.5.id",
            title: "survey.ecological.child.question.5.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.6.id",
            title: "survey.ecological.child.question.6.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.7.id",
            title: "survey.ecological.child.question.7.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.8.id",
            title: "survey.ecological.child.question.8.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.9.id",
            title: "survey.ecological.child.question.9.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.10.id",
            title: "survey.ecological.child.question.10.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "survey.ecological.child.question.11.id",
            title: "survey.ecological.child.question.11.text",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep(
            identifier: "survey.ecological.child.completition.id",
            title: "survey.ecological.child.completition.title",
            text: "survey.ecological.child.completition.text",
          )
        ],
      );
}

class _PatientParentsSurvey implements Survey {
  @override
  String get title => "survey.biosensor.patient.parent.title";

  @override
  String get description => "survey.biosensor.patient.parent.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.disagree", value: 0),
        RPChoice(text: "survey.answerFormat.agreement.disagree", value: 1),
        RPChoice(text: "survey.answerFormat.agreement.agree", value: 2),
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.agree", value: 3),
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.biosensor.patient.parent.title",
        steps: [
          RPInstructionStep(
              identifier: "survey.biosensor.patient.parent.instruction.id",
              title: "survey.biosensor.patient.parent.instruction.title",
              imagePath: 'assets/icons/wristwatch.png',
              text: "survey.biosensor.patient.parent.instruction.text"),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.1.id",
            title: "survey.biosensor.patient.parent.question.1.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.2.id",
            title: "survey.biosensor.patient.parent.question.2.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.3.id",
            title: "survey.biosensor.patient.parent.question.3.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.4.id",
            title: "survey.biosensor.patient.parent.question.4.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.5.id",
            title: "survey.biosensor.patient.parent.question.5.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.6.id",
            title: "survey.biosensor.patient.parent.question.6.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.7.id",
            title: "survey.biosensor.patient.parent.question.7.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.8.id",
            title: "survey.biosensor.patient.parent.question.8.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.9.id",
            title: "survey.biosensor.patient.parent.question.9.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.10.id",
            title: "survey.biosensor.patient.parent.question.10.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.11.id",
            title: "survey.biosensor.patient.parent.question.11.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.12.id",
            title: "survey.biosensor.patient.parent.question.12.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.13.id",
            title: "survey.biosensor.patient.parent.question.13.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.parent.question.14.id",
            title: "survey.biosensor.patient.parent.question.14.text",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "survey.biosensor.patient.parent.completition.id",
            title: "survey.biosensor.patient.parent.completition.title",
            text: "survey.biosensor.patient.parent.completition.text",
          )
        ],
      );
}

class _PatientSurvey implements Survey {
  @override
  String get title => "survey.biosensor.patient.title";

  @override
  String get description => "survey.biosensor.patient.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.disagree", value: 0),
        RPChoice(text: "survey.answerFormat.agreement.disagree", value: 1),
        RPChoice(text: "survey.answerFormat.agreement.agree", value: 2),
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.agree", value: 3),
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.biosensor.patient.title",
        steps: [
          RPInstructionStep(
              identifier: "survey.biosensor.patient.instruction.id",
              title: "survey.biosensor.patient.instruction.title",
              imagePath: 'assets/icons/wristwatch.png',
              text: "survey.biosensor.patient.instruction.text"),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.1.id",
            title: "survey.biosensor.patient.question.1.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.2.id",
            title: "survey.biosensor.patient.question.2.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.3.id",
            title: "survey.biosensor.patient.question.3.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.4.id",
            title: "survey.biosensor.patient.question.4.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.5.id",
            title: "survey.biosensor.patient.question.5.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.6.id",
            title: "survey.biosensor.patient.question.6.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.7.id",
            title: "survey.biosensor.patient.question.7.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.8.id",
            title: "survey.biosensor.patient.question.8.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.9.id",
            title: "survey.biosensor.patient.question.9.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.10.id",
            title: "survey.biosensor.patient.question.10.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.11.id",
            title: "survey.biosensor.patient.question.11.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.12.id",
            title: "survey.biosensor.patient.question.12.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.13.id",
            title: "survey.biosensor.patient.question.13.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.patient.question.14.id",
            title: "survey.biosensor.patient.question.14.text",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "survey.biosensor.patient.completition.id",
            title: "survey.biosensor.patient.completition.title",
            text: "survey.biosensor.patient.completition.text",
          )
        ],
      );
}

class _ControlParentsSurvey implements Survey {
  @override
  String get title => "survey.biosensor.control.parent.title";

  @override
  String get description => "survey.biosensor.control.parent.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.disagree", value: 0),
        RPChoice(text: "survey.answerFormat.agreement.disagree", value: 1),
        RPChoice(text: "survey.answerFormat.agreement.agree", value: 2),
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.agree", value: 3),
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.biosensor.control.parent.title",
        steps: [
          RPInstructionStep(
              identifier: "survey.biosensor.control.parent.instruction.id",
              title: "survey.biosensor.control.parent.instruction.title",
              imagePath: 'assets/icons/wristwatch.png',
              text: "survey.biosensor.control.parent.instruction.text"),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.1.id",
            title: "survey.biosensor.control.parent.question.1.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.2.id",
            title: "survey.biosensor.control.parent.question.2.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.3.id",
            title: "survey.biosensor.control.parent.question.3.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.4.id",
            title: "survey.biosensor.control.parent.question.4.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.5.id",
            title: "survey.biosensor.control.parent.question.5.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.6.id",
            title: "survey.biosensor.control.parent.question.6.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.7.id",
            title: "survey.biosensor.control.parent.question.7.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.8.id",
            title: "survey.biosensor.control.parent.question.8.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.9.id",
            title: "survey.biosensor.control.parent.question.9.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.10.id",
            title: "survey.biosensor.control.parent.question.10.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.11.id",
            title: "survey.biosensor.control.parent.question.11.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.12.id",
            title: "survey.biosensor.control.parent.question.12.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.13.id",
            title: "survey.biosensor.control.parent.question.13.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.parent.question.14.id",
            title: "survey.biosensor.control.parent.question.14.text",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "survey.biosensor.control.parent.completition.id",
            title: "survey.biosensor.control.parent.completition.title",
            text: "survey.biosensor.control.parent.completition.text",
          )
        ],
      );
}

class _ControlSurvey implements Survey {
  @override
  String get title => "survey.biosensor.control.patient.title";

  @override
  String get description => "survey.biosensor.control.patient.description";
  @override
  Duration get expire => const Duration(days: 7);

  @override
  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.disagree", value: 0),
        RPChoice(text: "survey.answerFormat.agreement.disagree", value: 1),
        RPChoice(text: "survey.answerFormat.agreement.agree", value: 2),
        RPChoice(
            text: "survey.answerFormat.agreement.strongly.agree", value: 3),
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "survey.biosensor.control.patient.title",
        steps: [
          RPInstructionStep(
              identifier: "survey.biosensor.control.patient.instruction.id",
              title: "survey.biosensor.control.patient.instruction.title",
              imagePath: 'assets/icons/wristwatch.png',
              text: "survey.biosensor.control.patient.instruction.text"),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.1.id",
            title: "survey.biosensor.control.patient.question.1.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.2.id",
            title: "survey.biosensor.control.patient.question.2.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.3.id",
            title: "survey.biosensor.control.patient.question.3.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.4.id",
            title: "survey.biosensor.control.patient.question.4.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.5.id",
            title: "survey.biosensor.control.patient.question.5.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.6.id",
            title: "survey.biosensor.control.patient.question.6.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.7.id",
            title: "survey.biosensor.control.patient.question.7.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.8.id",
            title: "survey.biosensor.control.patient.question.8.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.9.id",
            title: "survey.biosensor.control.patient.question.9.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.10.id",
            title: "survey.biosensor.control.patient.question.10.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.11.id",
            title: "survey.biosensor.control.patient.question.11.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.12.id",
            title: "survey.biosensor.control.patient.question.12.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.13.id",
            title: "survey.biosensor.control.patient.question.13.text",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "survey.biosensor.control.patient.question.14.id",
            title: "survey.biosensor.control.patient.question.14.text",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "survey.biosensor.control.patient.completition.id",
            title: "survey.biosensor.control.patient.completition.title",
            text: "survey.biosensor.control.patient.completition.text",
          )
        ],
      );
}

class _ExposureSurvey implements Survey {
  @override
  String get title => "survey.exposure.title";

  @override
  String get description => "survey.exposure.description";

  @override
  Duration get expire => const Duration(days: 1);

  @override
  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.discomfort.future.more", value: 0),
        RPChoice(text: "survey.answerFormat.discomfort.future.same", value: 1),
        RPChoice(text: "survey.answerFormat.discomfort.future.less", value: 2),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.reward.read", value: 0),
        RPChoice(text: "survey.answerFormat.reward.eat", value: 1),
        RPChoice(text: "survey.answerFormat.reward.tvshow", value: 2),
        RPChoice(text: "survey.answerFormat.reward.plan", value: 3),
        RPChoice(text: "survey.answerFormat.reward.game", value: 4),
        RPChoice(text: "survey.answerFormat.reward.videogame", value: 5),
        RPChoice(text: "survey.answerFormat.reward.other", value: 6),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.no", value: 0),
        RPChoice(text: "survey.answerFormat.yes", value: 1),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.obsesion.dirt", value: 0),
        RPChoice(text: "survey.answerFormat.obsesion.harm", value: 1),
        RPChoice(text: "survey.answerFormat.obsesion.sexuality", value: 2),
        RPChoice(text: "survey.answerFormat.obsesion.collect", value: 3),
        RPChoice(text: "survey.answerFormat.obsesion.superstition", value: 4),
        RPChoice(text: "survey.answerFormat.obsesion.disease", value: 5),
        RPChoice(text: "survey.answerFormat.obsesion.offense", value: 6),
        RPChoice(text: "survey.answerFormat.obsesion.symmetry", value: 7),
        RPChoice(text: "survey.answerFormat.obsesion.right", value: 8),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.compulsion.cleaning", value: 0),
        RPChoice(text: "survey.answerFormat.compulsion.checking", value: 1),
        RPChoice(text: "survey.answerFormat.compulsion.repeating", value: 2),
        RPChoice(text: "survey.answerFormat.compulsion.counting", value: 3),
        RPChoice(text: "survey.answerFormat.compulsion.fixing", value: 4),
        RPChoice(text: "survey.answerFormat.compulsion.collecting", value: 5),
        RPChoice(text: "survey.answerFormat.compulsion.superstition", value: 6),
        RPChoice(text: "survey.answerFormat.compulsion.parents", value: 7),
        RPChoice(text: "survey.answerFormat.compulsion.right", value: 8),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "survey.answerFormat.discomfort.more", value: 0),
        RPChoice(text: "survey.answerFormat.discomfort.mixed", value: 1),
        RPChoice(text: "survey.answerFormat.discomfort.same", value: 2),
        RPChoice(text: "survey.answerFormat.discomfort.less", value: 3),
      ]);

  @override
  RPTask get survey =>
      RPOrderedTask(identifier: "survey.exposure.title", steps: [
        RPInstructionStep(
            identifier: "survey.exposure.instruction.1.id",
            title: "survey.exposure.instruction.1.title",
            imagePath: 'assets/icons/survey.png',
            text: "survey.exposure.instruction.1.text"),
        RPQuestionStep(
          identifier: "survey.exposure.question.1.id",
          title: "survey.exposure.question.1.text",
          answerFormat: choiceAnswerFormat1,
        ),
        RPInstructionStep(
            identifier: "survey.exposure.instruction.2.id",
            title: "survey.exposure.instruction.2.title",
            text: "survey.exposure.instruction.2.text"),
        RPQuestionStep(
          identifier: "survey.exposure.question.2.id",
          title: "survey.exposure.question.1=2.text",
          answerFormat: choiceAnswerFormat2,
        ),

        RPQuestionStep(
          identifier: "survey.exposure.question.3.id",
          title: "survey.exposure.question.3.text",
          answerFormat: choiceAnswerFormat3,
        ),

        RPQuestionStep(
          identifier: "survey.exposure.question.4.id",
          title: "survey.exposure.question.4.text",
          answerFormat: choiceAnswerFormat4,
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.5.id",
          title: "survey.exposure.question.5.text",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),

////////////////////////////////
        RPQuestionStep(
          identifier: "survey.exposure.question.6.id",
          title: "survey.exposure.question.6.text",
          answerFormat: choiceAnswerFormat3,
        ),

        RPQuestionStep(
          identifier: "survey.exposure.question.7.id",
          title: "survey.exposure.question.7.text",
          answerFormat: choiceAnswerFormat5,
          optional: true,
        ),

        RPQuestionStep(
          identifier: "survey.exposure.question.8.id",
          title: "survey.exposure.question.8.text",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),

        RPQuestionStep(
            identifier: "survey.exposure.question.9.id",
            title: "survey.exposure.question.9.text",
            answerFormat: RPTextAnswerFormat(),
            optional: true),

        RPInstructionStep(
            identifier: "survey.exposure.instruction.3.id",
            title: "survey.exposure.instruction.3.title",
            imagePath: 'assets/images/timer_task.png',
            text: "survey.exposure.instruction.3.text"),

        RPQuestionStep(
          identifier: "survey.exposure.question.10.id",
          title: "survey.exposure.question.10.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.11.id",
          title: "survey.exposure.question.11.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.12.id",
          title: "survey.exposure.question.12.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.13.id",
          title: "survey.exposure.question.13.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.14.id",
          title: "survey.exposure.question.14.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "survey.exposure.question.15.id",
          title: "survey.exposure.question.15.text",
          answerFormat:
              RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
            identifier: "survey.exposure.question.16.id",
            title: "survey.exposure.question.16.text",
            answerFormat: choiceAnswerFormat6),

        RPCompletionStep(
          identifier: "survey.exposure.completition.id",
          title: "survey.exposure.completition.title",
          text: "survey.exposure.completition.text",
        )
      ]);
}

class _PARNASSurvey implements Survey {
  @override
  String get title => 'Positive & Negative Affect';

  @override
  String get description => 'A short survey on you current fealings';

  @override
  Duration get expire => const Duration(days: 2);

  @override
  int get minutesToComplete => 4;

  final RPChoiceAnswerFormat _locationChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "Alone", value: 1),
        RPChoice(
            text: "With my other children who are not part of the study",
            value: 2),
        RPChoice(text: "With my child who is part of the study", value: 3),
        RPChoice(text: "With the child's other parent", value: 3),
        RPChoice(text: "With my friends", value: 4),
        RPChoice(text: "With others", value: 5),
      ]);

  final RPChoiceAnswerFormat _parnasAnswerFormat = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Much", value: 5),
        RPChoice(text: "Pretty much", value: 4),
        RPChoice(text: "Moderate", value: 3),
        RPChoice(text: "A little", value: 2),
        RPChoice(text: "Not at all", value: 1),
      ]);

  @override
  RPTask get survey => RPOrderedTask(identifier: "demo_survey", steps: [
        RPInstructionStep(
            identifier: "parnas_instrux",
            title: "Where are you?",
            text:
                "In the following question, please indicate where you are, and who you are with."),
        RPQuestionStep(
          identifier: "location",
          title: "Right now I am...",
          answerFormat: _locationChoices,
        ),
        RPInstructionStep(
            identifier: "parnas_instrux_2",
            title: "International Positive and Negative Affect Schedule",
            text: "In the following questions, please indicate how "
                "much each of the stated emotions is affecting you at the moment."),
        RPQuestionStep(
          identifier: "parnas_1",
          title: "Upset",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_2",
          title: "Hostile",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_3",
          title: "Alert",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_4",
          title: "Ashamed",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_5",
          title: "Inspired",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_6",
          title: "Nervous",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_7",
          title: "Determined",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_8",
          title: "Attentive",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_9",
          title: "Afraid",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "parnas_10",
          title: "Active",
          answerFormat: _parnasAnswerFormat,
        ),
      ]);
}

class _WHO5Survey implements Survey {
  @override
  String get title => "WHO5 Well-Being";
  @override
  String get description => "A short 5-item survey on your well-being.";
  @override
  int get minutesToComplete => 1;
  @override
  Duration get expire => const Duration(days: 5);

  static final List<RPChoice> _choices = [
    RPChoice(text: "All of the time", value: 5),
    RPChoice(text: "Most of the time", value: 4),
    RPChoice(text: "More than half of the time", value: 3),
    RPChoice(text: "Less than half of the time", value: 2),
    RPChoice(text: "Some of the time", value: 1),
    RPChoice(text: "At no time", value: 0),
  ];

  final RPChoiceAnswerFormat _choiceAnswerFormat = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: _choices);

  @override
  RPTask get survey => RPOrderedTask(identifier: "who5_survey", steps: [
        RPInstructionStep(
            identifier: "who_5_instrux",
            title: "WHO Well-Being Index",
            text:
                "Please indicate for each of the following five statements which is closest to how you have been feeling over the last two weeks. "
                "Notice that higher numbers mean better well-being.\n\n"
                "Example: If you have felt cheerful and in good spirits more than half of the time during the last two weeks, "
                "select the box with the label 'More than half of the time'."),
        RPQuestionStep(
          identifier: "who5_1",
          title: "I have felt cheerful and in good spirits",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "who5_2",
          title: "I have felt calm and relaxed",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "who5_3",
          title: "I have felt active and vigorous",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "who5_4",
          title: "I woke up feeling fresh and rested",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "who5_5",
          title: "My daily life has been filled with things that interest me",
          answerFormat: _choiceAnswerFormat,
        ),
        RPCompletionStep(
          identifier: "who5_completion",
          title: "Finished",
          text: "Thank you for filling out the survey!",
        )
      ]);
}

class _DemographicSurvey implements Survey {
  @override
  String get title => "Demographics";
  @override
  String get description => "A short 4-item survey on your background.";
  @override
  int get minutesToComplete => 2;
  @override
  Duration get expire => const Duration(days: 5);

  final RPChoiceAnswerFormat _sexChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Femal", value: 1),
        RPChoice(text: "Male", value: 2),
        RPChoice(text: "Other", value: 3),
        RPChoice(text: "Prefer not to say", value: 4),
      ]);

  final RPChoiceAnswerFormat _ageChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Under 20", value: 1),
        RPChoice(text: "20-29", value: 2),
        RPChoice(text: "30-39", value: 3),
        RPChoice(text: "40-49", value: 4),
        RPChoice(text: "50-59", value: 5),
        RPChoice(text: "60-69", value: 6),
        RPChoice(text: "70-79", value: 7),
        RPChoice(text: "80-89", value: 8),
        RPChoice(text: "90 and above", value: 9),
        RPChoice(text: "Prefer not to say", value: 10),
      ]);

  final RPChoiceAnswerFormat _medicalChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "None", value: 1),
        RPChoice(text: "Asthma", value: 2),
        RPChoice(text: "Cystic fibrosis", value: 3),
        RPChoice(text: "COPD/Emphysema", value: 4),
        RPChoice(text: "Pulmonary fibrosis", value: 5),
        RPChoice(text: "Other lung disease  ", value: 6),
        RPChoice(text: "High Blood Pressure", value: 7),
        RPChoice(text: "Angina", value: 8),
        RPChoice(
            text: "Previous stroke or Transient ischaemic attack  ", value: 9),
        RPChoice(text: "Valvular heart disease", value: 10),
        RPChoice(text: "Previous heart attack", value: 11),
        RPChoice(text: "Other heart disease", value: 12),
        RPChoice(text: "Diabetes", value: 13),
        RPChoice(text: "Cancer", value: 14),
        RPChoice(text: "Previous organ transplant", value: 15),
        RPChoice(text: "HIV or impaired immune system", value: 16),
        RPChoice(text: "Other long-term condition", value: 17),
        RPChoice(text: "Prefer not to say", value: 18),
      ]);

  final RPChoiceAnswerFormat _smokeChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Never smoked", value: 1),
        RPChoice(text: "Ex-smoker", value: 2),
        RPChoice(text: "Current smoker (less than once a day", value: 3),
        RPChoice(text: "Current smoker (1-10 cigarettes pr day", value: 4),
        RPChoice(text: "Current smoker (11-20 cigarettes pr day", value: 5),
        RPChoice(text: "Current smoker (21+ cigarettes pr day", value: 6),
        RPChoice(text: "Prefer not to say", value: 7),
      ]);

  @override
  RPTask get survey => RPOrderedTask(identifier: "demographic_survey", steps: [
        RPQuestionStep(
          identifier: "demographic_1",
          title: "Which is your biological sex?",
          answerFormat: _sexChoices,
        ),
        RPQuestionStep(
          identifier: "demographic_2",
          title: "How old are you?",
          answerFormat: _ageChoices,
        ),
        RPQuestionStep(
          identifier: "demographic_3",
          title: "Do you have any of these medical conditions?",
          answerFormat: _medicalChoices,
        ),
        RPQuestionStep(
          identifier: "demographic_4",
          title: "Do you, or have you, ever smoked (including e-cigarettes)?",
          answerFormat: _smokeChoices,
        ),
      ]);
}

class _SymptomsSurvey implements Survey {
  @override
  String get title => "Symptoms";
  @override
  String get description => "A short 1-item survey on your daily symptoms.";
  @override
  int get minutesToComplete => 1;
  @override
  Duration get expire => const Duration(days: 1);

  final RPChoiceAnswerFormat _symptomsChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "None", value: 1),
        RPChoice(text: "Fever (warmer than usual)", value: 2),
        RPChoice(text: "Dry cough", value: 3),
        RPChoice(text: "Wet cough", value: 4),
        RPChoice(text: "Sore throat, runny or blocked nose", value: 5),
        RPChoice(text: "Loss of taste and smell", value: 6),
        RPChoice(
            text: "Difficulty breathing or feeling short of breath", value: 7),
        RPChoice(text: "Tightness in your chest", value: 8),
        RPChoice(text: "Dizziness, confusion or vertigo", value: 9),
        RPChoice(text: "Headache", value: 10),
        RPChoice(text: "Muscle aches", value: 11),
        RPChoice(text: "Chills", value: 12),
        RPChoice(text: "Prefer not to say", value: 13),
      ]);

  @override
  RPTask get survey => RPOrderedTask(identifier: "symptoms_survey", steps: [
        RPQuestionStep(
          identifier: "symptoms_1",
          title: "Do you have any of the following symptoms today?",
          answerFormat: _symptomsChoices,
        ),
      ]);
}

// NOTE that normally we would spell Parkinson's with an "'", but this makes a conclict
// when writing it to the SQLite database.
class _ParkinsonsSurvey implements Survey {
  @override
  String get title => "The Parkinsons Disease Activities of Daily Living Scale";
  @override
  String get description =>
      "A new simple and brief subjective measure of disability in Parkinsons disease";
  @override
  int get minutesToComplete => 1;
  @override
  Duration get expire => const Duration(days: 1);

  final RPChoiceAnswerFormat _symptomsChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(
            text: "No difficulties with day-to-day activities.",
            detailText:
                "For example: Your Parkinsons disease at present is not affecting "
                "your daily living.",
            value: 1),
        RPChoice(
            text: "Mild difficulties with day-to-day activities.",
            detailText:
                "For example: Slowness with some aspects of housework, gardening or "
                "shopping. Able to dress and manage personal hygiene completely "
                "independently but rate is slower. You may feel that your medication "
                "is not quite effective as it was.",
            value: 2),
        RPChoice(
            text: "Moderate difficulties with day-to-day activities.",
            detailText:
                "For example: Your Parkinsons disease is interfering with your daily activities. "
                "It is increasingly difficult to do simple activities without some help such as rising "
                "from a chair, washing, dressing, shopping, housework. You may have some "
                "difficulties walking and may require assistance. Difficulties with "
                "recreational activities or the ability to drive a car. "
                "The medication is now less effective.",
            value: 3),
        RPChoice(
            text: "High levels of difficulties with day-to-day activities.",
            detailText:
                "For example: You now require much more assistance with activities of "
                "daily living such as washing, dressing, housework or feeding yourself. "
                "You may have greater difficulties with mobility and find you "
                "are becoming more dependent for assistance from others or aids and appliances. "
                "Your medication appears to be significantly less effective.",
            value: 4),
        RPChoice(
            text: "Extreme difficulties with day-to-day activities.",
            detailText:
                "For example: You require assistance in all daily activities. "
                "These may include dressing, washing, feeding yourself or walking unaided. "
                "You may now be housebound and obtain little or no benefit from your medication.",
            value: 5),
      ]);

  @override
  RPTask get survey => RPOrderedTask(identifier: "parkinsons_survey", steps: [
        RPQuestionStep(
          identifier: "parkinsons_1",
          title:
              "Please tick one of the descriptions that best describes how your "
              "Parkinsons disease has affected your day-to-day activities in the last month.",
          answerFormat: _symptomsChoices,
        ),
      ]);
}
