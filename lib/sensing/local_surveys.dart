part of carp_study_app;

final surveys = _Surveys();

class _Surveys {
  Survey _who5 = _WHO5Survey();
  Survey get who5 => _who5;

  Survey _demographics = _DemographicSurvey();
  Survey get demographics => _demographics;

  Survey _symptoms = _SymptomsSurvey();
  Survey get symptoms => _symptoms;

  Survey _parnas = _PARNASSurvey();
  Survey get parnas => _parnas;

  Survey _exposure = _ExposureSurvey();
  Survey get exposure => _exposure;

  Survey _control = _ControlSurvey();
  Survey get control => _control;

  Survey _controlParents = _ControlParentsSurvey();
  Survey get controlParents => _controlParents;

  Survey _patient = _PatientSurvey();
  Survey get patient => _patient;

  Survey _patientParents = _PatientParentsSurvey();
  Survey get patientParents => _patientParents;

  Survey _ecological = _EcologicalSurvey();
  Survey get ecological => _ecological;

  Survey _ecologicalParents = _EcologicalParentsSurvey();
  Survey get ecologicalParents => _ecologicalParents;

  Survey _appUX = _AppUXSurvey();
  Survey get appUX => _appUX;

  Survey _informedConsent = _InformedConsentSurvey();
  Survey get informedConsent => _informedConsent;

  Survey _trustScale = _TrustScaleSurvey();
  Survey get trustScale => _trustScale;

  Survey _timedExposure = _TimedExposureSurvey();
  Survey get timedExposure => _timedExposure;

  Survey _symptomHierarchyObsessions = _SymptomHierarchySurveyObsessions();
  Survey get symptomHierarchyObsessions => _symptomHierarchyObsessions;

  Survey _symptomHierarchyCompulsions = _SymptomHierarchySurveyCompulsions();
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
  String get title => 'Symptom Hierarchy: Obsessions';

  String get description =>
      'This form is designed to help you keep track of how your obsessions change from week to week.';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPTask get survey => RPOrderedTask(identifier: "Symptom Hierarchy: Obsessions", steps: [
        RPInstructionStep(
            identifier: "instruction",
            title: "Obsessions",
            text:
                "Symptom Hierarchy: Obsessions\n\n\nObsessions are unwanted thoughts or images that keep popping into your head and that you can't stop thinking about, even though you want to be rid of them.\n\nOn the next pages, you will see obsessions that many people with OCD have. Tell us how upset or scared each obsession has been for you over the past week by choosing the number that best matches how you feel. 0 means that you have not had the obsession or that it is not at all unpleasant and 10 means that the obsession is so upsetting you can’t stand it."),
        RPQuestionStep(
          identifier: "question1",
          title: "Fear/ disgust of pollution, infection, dirt, bacteria, diseases",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question2",
          title: "Fear of harming yourself or others (body or feelings)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question3",
          title: "Disturbing thoughts/ images about sex, pregnancy or sexuality",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question4",
          title: "Need to collect things or fear of losing something",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question5",
          title:
              "Magical/superstitious thoughts or actions (e.g. lucky numbers or words; stepping on a crack can break someone’s back)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question6",
          title: "Worry about having a disease or that a body part or your appearance looks wrong",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question7",
          title: "Fear of offending God or Satan or worry about what is right and wrong",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question8",
          title:
              "Symmetry and order (e.g. that things must lie in a certain way, or things must be in order)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question9",
          title: "Needing to do something until it feels right or not wrong",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question10",
          title: "Here you can describe other obsessions that have not been mentioned",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
          identifier: "completion",
          title: "Hurray!",
          text:
              "You are finished recording your obsessions for this week. By keeping track of your obsessions and compulsions, you're taking back control, so OCD doesn't control you.",
        )
      ]);
}

class _SymptomHierarchySurveyCompulsions implements Survey {
  String get title => 'Symptom Hierarchy: Compulsions';

  String get description =>
      'This form is designed to help you keep track of how your compulsions change from week to week.';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPTask get survey => RPOrderedTask(identifier: "Symptom Hierarchy: Compulsions", steps: [
        RPInstructionStep(
            identifier: "instruction",
            title: "Compulsions",
            text:
                "Symptom hierarchy: Compulsions\n\n\nCompulsions are things that OCD wants you to do. If you try to resist doing these things or try not to do what OCD tells to, you may feel afraid, worried, frustrated, angry or upset.\n\nOn the next pages there will be some compulsions that many people with OCD have. Tell us how upset each compulsion (or trying to resist the compulsion) has been for you over the past week by choosing the number that best matches how you feel. 0 means that you do not have that compulsion or that does not bother you and 10 means that the compulsion upsets you so much that you can’t stand it."),
        RPQuestionStep(
          identifier: "question1",
          title: "Washing or cleaning",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question2",
          title: "Checking (like if you have remembered to lock the door)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question3",
          title: "Repeating actions (like turning the lights on and off several times)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question4",
          title: "Counting things",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question5",
          title: "Fixing things or try to get things the same or symmetrical",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question6",
          title: "Collecting things or difficulty throwing things away",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question7",
          title:
              "Magical/superstitious behavior (e.g. doing or saying things a certain number of times to prevent something terrible from happening)",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question8",
          title: "Involving others (like your parents) in a ritual or asking for reassurance",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question9",
          title: "Needing to do something until it feels right",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question10",
          title: "Here you can describe other compulsions that have not been mentioned",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
          identifier: "completion",
          title: "Hurray!",
          text:
              "You are finished recording your compulsions for this week. By keeping track of your obsessions and compulsions, you're taking back control, so OCD doesn't control you.",
        )
      ]);
}

class _TimedExposureSurvey implements Survey {
  String get title => "Weekly exposure and response prevention";

  String get description => 'Describe the obsession and/or the compulsion you are working on';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 10; // TODO: review time

  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat(choices: [
    RPImageChoice(imageUrl: 'assets/icons/very-sad.png', value: 4, description: "Unbearable"),
    RPImageChoice(imageUrl: 'assets/icons/sad.png', value: 3, description: "Very great discomfort"),
    RPImageChoice(imageUrl: 'assets/icons/ok.png', value: 2, description: "Quite a lot of discomfort"),
    RPImageChoice(imageUrl: 'assets/icons/happy.png', value: 1, description: "A certain discomfort"),
    RPImageChoice(imageUrl: 'assets/icons/very-happy.png', value: 0, description: "Calm"),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "Timed_Exposure_exercise", steps: [
        RPQuestionStep(
          identifier: "question1",
          title: "How scared or upset do you feel?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
      ]);
}

class _TrustScaleSurvey implements Survey {
  String get title => 'Trust in the Mobile App';

  String get description => 'We would like to know what it was like for you to use the mobile app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Strongly disagree", value: 0),
    RPChoice(text: "Slightly disagree", value: 1),
    RPChoice(text: "Agree", value: 2),
    RPChoice(text: "Strongly agree", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "User Experience with App", steps: [
        RPInstructionStep(
            identifier: "instruction",
            title: " ",
            imagePath: 'assets/icons/smartphone.png',
            text:
                "We would like to know what it was like for you to use the mobile app.\n\nPlease read each statement and chose the number (0, 1, 2, or 3) that best describes how you feel."),
        RPQuestionStep(
          identifier: "question1",
          title: "I believe that there could be negative consequences when using this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question2",
          title: "I feel I must be cautious when using this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question3",
          title: "It is risky to interact with this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question4",
          title: "I think that this mobile app is competent and effective in supporting the research study",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question5",
          title: "I think that this mobile app performs its role as a tool for research very well",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question6",
          title:
              "I believe that this mobile app has all the functionalities I would expect from a research study app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question7",
          title: "When I use this mobile app, I feel I can count on it completely",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question8",
          title: "I can always rely on the mobile app for guidance and assistance",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question9",
          title: "I can trust the information presented to me by the mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question10",
          title: "I believe that the mobile app provides me with benefits",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question11",
          title: "I believe that the mobile app will show me how to get support if I need help",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question12",
          title: "I believe that the mobile app attends to my needs and preferences",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question13",
          title: "Is there anything else you would like to tell us about your experience?",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),
        RPCompletionStep(
            identifier: "completion",
            title: "Thank you for completing the product evaluation questionnaire!",
            text: " ")
      ]);
}

class _InformedConsentSurvey implements Survey {
  String get title => 'Evaluation of the mobile app consent';

  String get description => 'We would like to know your experience with the informed consent'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 4;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely not understandable.", value: 0),
    RPChoice(text: "Mostly not understandable.", value: 1),
    RPChoice(text: "Mostly understandable.", value: 2),
    RPChoice(text: "Extremely understandable.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely easy to navigate.", value: 0),
    RPChoice(text: "Mostly easy to navigate.", value: 1),
    RPChoice(text: "Mostly difficult to navigate.", value: 2),
    RPChoice(text: "Extremely difficult to navigate.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely valuable.", value: 0),
    RPChoice(text: "Mostly valuable.", value: 1),
    RPChoice(text: "Mostly inferior.", value: 2),
    RPChoice(text: "Extremely inferior.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely boring.", value: 0),
    RPChoice(text: "Mostly boring.", value: 1),
    RPChoice(text: "Mostly exciting.", value: 2),
    RPChoice(text: "Extremely exciting.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely not interesting.", value: 0),
    RPChoice(text: "Mostly not interesting.", value: 1),
    RPChoice(text: "Mostly interesting.", value: 2),
    RPChoice(text: "Extremely interesting.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely fast.", value: 0),
    RPChoice(text: "Mostly fast.", value: 1),
    RPChoice(text: "Mostly slow.", value: 2),
    RPChoice(text: "Extremely slow.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely complicated.", value: 0),
    RPChoice(text: "Mostly complicated.", value: 1),
    RPChoice(text: "Mostly easy to understand.", value: 2),
    RPChoice(text: "Extremely easy to understand.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely motivating.", value: 0),
    RPChoice(text: "Mostly motivating.", value: 1),
    RPChoice(text: "Mostly demotivating.", value: 2),
    RPChoice(text: "Extremely demotivating.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat9 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely inefficient.", value: 0),
    RPChoice(text: "Mostly inefficient.", value: 1),
    RPChoice(text: "Mostly efficient.", value: 2),
    RPChoice(text: "Extremely efficient.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat10 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely clear.", value: 0),
    RPChoice(text: "Mostly clear.", value: 1),
    RPChoice(text: "Mostly confusing.", value: 2),
    RPChoice(text: "Extremely confusing.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat11 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely impractical.", value: 0),
    RPChoice(text: "Mostly impractical.", value: 1),
    RPChoice(text: "Mostly practical.", value: 2),
    RPChoice(text: "Extremely practical.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat12 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely organized.", value: 0),
    RPChoice(text: "Mostly organized.", value: 1),
    RPChoice(text: "Mostly cluttered.", value: 2),
    RPChoice(text: "Extremely cluttered.", value: 3),
  ]);
  RPTask get survey => RPOrderedTask(identifier: "Informed consent", steps: [
        RPInstructionStep(
            identifier: "instruction",
            title: " ",
            imagePath: 'assets/icons/smartphone.png',
            text:
                "Please make your evaluation of the app informed consent now.\n\nThe questionnaire consists of attributes that may apply to the app informed consent. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!"),
        RPQuestionStep(
          identifier: "question1",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question2",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          identifier: "question3",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          identifier: "question4",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          identifier: "question5",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          identifier: "question6",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          identifier: "question7",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          identifier: "question8",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat8,
        ),
        RPQuestionStep(
          identifier: "question9",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat9,
        ),
        RPQuestionStep(
          identifier: "question10",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat10,
        ),
        RPQuestionStep(
          identifier: "question11",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat11,
        ),
        RPQuestionStep(
          identifier: "question12",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat12,
        ),
        RPCompletionStep(
            identifier: "completion",
            title: "Thank you for completing the product evaluation questionnaire!",
            text: " ")
      ]);
}

class _AppUXSurvey implements Survey {
  String get title => 'User Experience with the Mobile App';

  String get description => 'We would like to know your experience with the app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely obstructive.", value: 0),
    RPChoice(text: "Mostly obstructive.", value: 1),
    RPChoice(text: "Mostly supportive.", value: 2),
    RPChoice(text: "Extremely supportive.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely complicated.", value: 0),
    RPChoice(text: "Mostly complicated.", value: 1),
    RPChoice(text: "Mostly easy.", value: 2),
    RPChoice(text: "Extremely easy.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely inefficient.", value: 0),
    RPChoice(text: "Mostly inefficient.", value: 1),
    RPChoice(text: "Mostly efficient.", value: 2),
    RPChoice(text: "Extremely efficient.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely confusing.", value: 0),
    RPChoice(text: "Mostly confusing.", value: 1),
    RPChoice(text: "Mostly clear.", value: 2),
    RPChoice(text: "Extremely clear.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely boring.", value: 0),
    RPChoice(text: "Mostly boring.", value: 1),
    RPChoice(text: "Mostly exciting.", value: 2),
    RPChoice(text: "Extremely exciting.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely not interesting.", value: 0),
    RPChoice(text: "Mostly not interesting.", value: 1),
    RPChoice(text: "Mostly interesting.", value: 2),
    RPChoice(text: "Extremely interesting.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely conventional.", value: 0),
    RPChoice(text: "Mostly conventional.", value: 1),
    RPChoice(text: "Mostly inventive.", value: 2),
    RPChoice(text: "Extremely inventive.", value: 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Extremely usual.", value: 0),
    RPChoice(text: "Mostly usual.", value: 1),
    RPChoice(text: "Mostly leading edge.", value: 2),
    RPChoice(text: "Extremely leading edge.", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "User Experience with App", steps: [
        RPInstructionStep(
            identifier: "instruction",
            title: " ",
            imagePath: 'assets/icons/smartphone.png',
            text:
                "Please make your evaluation of this mobile app now.\n\nThe questionnaire consists of attributes that may apply to the app. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!"),
        RPQuestionStep(
          identifier: "question1",
          title: "The app is:",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "question2",
          title: "The app is:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          identifier: "question3",
          title: "The app is:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          identifier: "question4",
          title: "The app is:",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          identifier: "question5",
          title: "The app is:",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          identifier: "question6",
          title: "The app is:",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          identifier: "question7",
          title: "The app is:",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          identifier: "question8",
          title: "The app is:",
          answerFormat: choiceAnswerFormat8,
        ),
        RPCompletionStep(
            identifier: "completion",
            title: "Thank you for completing the product evaluation questionnaire!",
            text: " ")
      ]);
}

class _EcologicalParentsSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "No", value: 0),
    RPChoice(text: "Yes", value: 1),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Very slightly or not at all", value: 1),
    RPChoice(text: "A little", value: 2),
    RPChoice(text: "Moderately", value: 3),
    RPChoice(text: "Quite a bit", value: 4),
    RPChoice(text: "Extremely", value: 5),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "I am alone", value: 0),
    RPChoice(text: "I am with my child who is participating in the study", value: 1),
    RPChoice(text: "I am with my child(ren) who is/are not participating in the study", value: 2),
    RPChoice(text: "I am with my participating child’s other parent)", value: 3),
    RPChoice(text: "I am with my friends", value: 4),
    RPChoice(text: "I am with others we have not mentioned", value: 5)
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "Ecological Momentary Assessment Parent",
        steps: [
          RPQuestionStep(
            identifier: "question1",
            title: "Are you alone?",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep(
              identifier: "instruction",
              title: " ",
              text: "Indicate the extent you have felt this way over the past week."),
          RPQuestionStep(
            identifier: "question7",
            title: "Upset",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "Hostile",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "Alert",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "Ashamed",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "Inspired",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question12",
            title: "Nervous",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question13",
            title: "Determined",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question14",
            title: "Attentive",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question15",
            title: "Afraid",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question16",
            title: "Active",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep(
            identifier: "completion",
            title: "Thank you for telling us how you feel",
            text: "by answering this survey you are helping us connect feelings to physiological signals",
          )
        ],
      );
}

class _EcologicalSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "No", value: 0),
    RPChoice(text: "Yes", value: 1),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Very slightly or not at all", value: 1),
    RPChoice(text: "A little", value: 2),
    RPChoice(text: "Moderately", value: 3),
    RPChoice(text: "Quite a bit", value: 4),
    RPChoice(text: "Extremely", value: 5),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "I am alone", value: 0),
    RPChoice(text: "I am with my mother/father who is also participating in the study", value: 1),
    RPChoice(text: "I am  with my other parent who is not participating in the study", value: 2),
    RPChoice(text: "I am with my sister(s) and/ or brother(s)", value: 3),
    RPChoice(text: "I am with my friends", value: 4),
    RPChoice(text: "I am with others we have not mentioned", value: 5)
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "Ecological Momentary Assessment Child",
        steps: [
          RPQuestionStep(
            identifier: "question1",
            title: "Are you alone?",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep(
              identifier: "instruction",
              title: "We would like to know your current mood",
              imagePath: 'assets/icons/survey.png',
              text:
                  "Below are a list of different feelings and emotions.\n\nPlease read each feeling and choose the option that best matches how much you feel each feeling right now."),
          RPQuestionStep(
            identifier: "question2",
            title: "Miserable",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question3",
            title: "Mad",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question4",
            title: "Lively",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question5",
            title: "Sad",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question6",
            title: "Joyful",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question7",
            title: "Scared",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "Cheerful",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "Happy",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "Afraid",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "Proud",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep(
            identifier: "completion",
            title: "Thank you for telling us how you feel",
            text: "By answering this survey you are helping us connect how you feel to your bodily signals",
          )
        ],
      );
}

class _PatientParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Strongly disagree", value: 0),
    RPChoice(text: "Slightly disagree", value: 1),
    RPChoice(text: "Agree", value: 2),
    RPChoice(text: "Strongly agree", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "PATIENT_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        steps: [
          RPInstructionStep(
              identifier: "instruction",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png',
              text:
                  "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel."),
          RPQuestionStep(
            identifier: "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question13",
            title: "I remembered to push the button on the wristband each time my child’s OCD bothered me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
              identifier: "completion",
              title: "You are done!",
              text:
                  "Thank you for telling us what you think about the wristband. Your answers will be taken into account")
        ],
      );
}

class _PatientSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Strongly disagree", value: 0),
    RPChoice(text: "Slightly disagree", value: 1),
    RPChoice(text: "Agree", value: 2),
    RPChoice(text: "Strongly agree", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "PATIENT_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        steps: [
          RPInstructionStep(
              identifier: "instruction",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png',
              text:
                  "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel."),
          RPQuestionStep(
            identifier: "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question13",
            title: "I remembered to push the button on the wristband every time OCD was bothering me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "completion",
            title: "You are done!",
            text:
                "Thank you for telling us what you think about the wristband. Your answers will help us make the wristband better",
          )
        ],
      );
}

class _ControlParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Strongly disagree", value: 0),
    RPChoice(text: "Slightly disagree", value: 1),
    RPChoice(text: "Agree", value: 2),
    RPChoice(text: "Strongly agree", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "KONTROL_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        steps: [
          RPInstructionStep(
              identifier: "instruction",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png',
              text:
                  "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel."),
          RPQuestionStep(
            identifier: "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question13",
            title: "I remembered to push the button on the wristband each time my child’s stress botheredme.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "completion",
            title: "You are done!",
            text:
                "Thank you for telling us what you think about the wristband. Your answers will be taken into account",
          )
        ],
      );
}

class _ControlSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Strongly disagree", value: 0),
    RPChoice(text: "Slightly disagree", value: 1),
    RPChoice(text: "Agree", value: 2),
    RPChoice(text: "Strongly agree", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(
        identifier: "KONTROL_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        steps: [
          RPInstructionStep(
              identifier: "instruction",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png',
              text:
                  "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel."),
          RPQuestionStep(
            identifier: "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question13",
            title: "I remembered to push the button on the wristband every time stress was bothering me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            identifier: "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep(
            identifier: "completion",
            title: "You are done!",
            text:
                "Thank you for telling us what you think about the wristband. Your answers will help us make the wristband better",
          )
        ],
      );
}

class _ExposureSurvey implements Survey {
  String get title => "Fight back against OCD";

  String get description => 'Describe the obsession and/or the compulsion you are working on';

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10; // TODO: review time

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "My discomfort/fear/disgust will grow and grow until I can't take it any more", value: 0),
    RPChoice(text: "My discomfort/fear/disgust will not change", value: 1),
    RPChoice(text: "I will feel less discomfort/fear/disgust over time", value: 2),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Read an exciting book", value: 0),
    RPChoice(text: "Eat something delicious", value: 1),
    RPChoice(text: "Watch an episode of your favorite series", value: 2),
    RPChoice(text: "Do something fun with friends/ family (make a plan)", value: 3),
    RPChoice(text: "Play a game", value: 4),
    RPChoice(text: "Play a computer/videogame", value: 5),
    RPChoice(text: "I will do something not listed here", value: 6),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "No", value: 0),
    RPChoice(text: "Yes", value: 1),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat4 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "Fear/ disgust of pollution, infection, dirt, bacteria, diseases", value: 0),
    RPChoice(text: "Fear of harming myself or others (physically or emotionally)", value: 1),
    RPChoice(text: "Disturbing thoughts/ images about sex, pregnancy or sexuality", value: 2),
    RPChoice(text: "Need to collect things or fear of losing something", value: 3),
    RPChoice(
        text:
            "Magical/superstitious thoughts or actions (e.g. lucky numbers or words; stepping on a crack can break someone’s back)",
        value: 4),
    RPChoice(
        text: "Worry about having a disease or that a body part or your appearance looks wrong)", value: 5),
    RPChoice(text: "Fear of offending God or Satan or worry about what is right and wrong", value: 6),
    RPChoice(
        text: "Symmetry and order (e.g. that things must lie in a certain way, or things must be in order)",
        value: 7),
    RPChoice(text: "Needing to do something until it feels right or not wrong", value: 8),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat5 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "Washing or cleaning", value: 0),
    RPChoice(text: "Checking (like if you have remembered to lock the door)", value: 1),
    RPChoice(text: "Repeating actions (like turning the lights on and off several times)", value: 2),
    RPChoice(text: "Counting things", value: 3),
    RPChoice(text: "Fixing things or trying to get things in a certain place or symmetrical", value: 4),
    RPChoice(text: "Collecting things or difficulty throwing things away", value: 5),
    RPChoice(
        text:
            "Magical/superstitious behavior (like doing or saying things a certain number of times to prevent something bad from happening)",
        value: 6),
    RPChoice(text: "Involving your parents in a ritual or asking for reassurance", value: 7),
    RPChoice(text: "Doing something until it feels right", value: 8),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "My discomfort grew until I couldn’t stand it anymore", value: 0),
    RPChoice(text: "My discomfort went up and down", value: 1),
    RPChoice(text: "My discomfort did not really change", value: 2),
    RPChoice(text: "I felt less discomfort with time", value: 3),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "Exposure_SUDS_v2_2021.04.22", steps: [
        RPInstructionStep(
            identifier: "instruction1",
            title: "Exposure and response prevention",
            imagePath: 'assets/icons/survey.png',
            text:
                "This survey is designed to help you practice fighting OCD. To take back control from OCD, you must do the opposite of what OCD wants you to do. For example, you may touch some food left over on your plate or say some “dangerous” words. Or, if the OCD tells you to touch things a certain number of times, don't do it. Going against OCD can be scary or upsetting. But, to take control back from OCD, you can’t run away from the discomfort or fear - you must tough it out.\n\nDuring the exercise, notice what happens to the feeling of discomfort for up to 15 minutes.\n\nWhile you practice going against OCD, your parents or your therapist can help you use this form."),
        RPQuestionStep(
          identifier: "question1",
          title:
              "What do you think is going to happen to your feelings of discomfort, fear or disgust when you practice doing the opposite of what OCD wants you to do? ",
          answerFormat: choiceAnswerFormat1,
        ),
        RPInstructionStep(
            identifier: "instruction2",
            title: " ",
            text:
                "Many children and adolescents think that their fear or discomfort will get worse and worse when they practice going against OCD, but that is not what happens.\n\nFor many children and adolescents, the fear/discomfort goes up and down during the exercise. For some people, the fear/discomfort becomes less during the exercise. Others find that their fear/discomfort does not really change during the exercise, but then they learn that fear and discomfort are not dangerous. With lots of practice, you should really notice that you feel less fear, disgust or discomfort."),
        RPQuestionStep(
          identifier: "question2",
          title:
              "Before you start practicing going against OCD, prepare for the exercise by answering some questions.\n\nYou're going to do something difficult and that should be rewarded. How will you reward yourself after the exercise of fighting OCD?",
          answerFormat: choiceAnswerFormat2,
        ),

        RPQuestionStep(
          identifier: "question3",
          title:
              "In the exercise, I will work on an obsession.\n\n(Obsessions are unwanted thoughts or images that keep popping into your head and that you can't stop thinking about, even though you want to be rid of them.)",
          answerFormat: choiceAnswerFormat3,
        ),

        // TODO: if previous question is no skip
        RPQuestionStep(
          identifier: "question4",
          title: "The obsession I want to work on now is about:",
          answerFormat: choiceAnswerFormat4,
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question5",
          title:
              "You can describe the obsession you want to work on here, if you would like to describe it detail or if you could not find an obsession in the list.",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),

////////////////////////////////
        RPQuestionStep(
          identifier: "question6",
          title:
              "I want to work with a compulsion.\n\n\n(Compulsions are things that OCD wants you to do. If you try to resist doing these things or try not to do what OCD tells you to, you may feel afraid, worried, frustrated, angry or upset.)",
          answerFormat: choiceAnswerFormat3,
        ),

        // TODO: if previous question is no skip
        RPQuestionStep(
          identifier: "question7",
          title: "The compulsion I will work on is about:",
          answerFormat: choiceAnswerFormat5,
          optional: true,
        ),

        RPQuestionStep(
          identifier: "question8",
          title:
              "You can describe the compulsion you want to work on here, if you would like to describe it detail or if you could not find a compulsion in the list.",
          answerFormat: RPTextAnswerFormat(),
          optional: true,
        ),

        RPQuestionStep(
            identifier: "question9",
            title:
                "Describe how you will practice going against OCD. How do you want to work on the obsession and/or compulsion (for example touching the toilet seat or making your desk messy):",
            answerFormat: RPTextAnswerFormat(),
            optional: true),

        RPInstructionStep(
            identifier: "instruction",
            title: " ",
            imagePath: 'assets/images/timer_task.png',
            text:
                "On the next pages, you will be asked to note how much fear or discomfort you experience while you go against OCD.\n\nStart by noting how uncomfortable it is for you to think about doing the exercise you just described on a scale of 0 to 10. 0 means that you are completely calm or not at all afraid. 10 means that you are so scared or upset you can’t stand it."),

        // TODO: TIMER STEP IN BETWEEN ALL OF THE FOLLOWING QUESTIONS
        RPQuestionStep(
          identifier: "question10",
          title: "How much discomfort do you feel after 1 minute?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question11",
          title: "How much discomfort do you feel after 3 minutes?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question12",
          title: "How much discomfort do you feel after 5 minutes?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question13",
          title: "How much discomfort do you feel after 7 minutes?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question14",
          title: "How much discomfort do you feel after 10 minutes?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
          identifier: "question15",
          title: "How much discomfort do you feel after 15 minutes?",
          answerFormat: RPSliderAnswerFormat(minValue: 0, maxValue: 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep(
            identifier: "question16",
            title:
                "Well done! You stayed with some difficult feelings!\n\nWhat happened to those difficult feelings when you practiced doing the opposite of what OCD wants?",
            answerFormat: choiceAnswerFormat6),

        RPCompletionStep(
          identifier: "completion",
          title: "You are done with the exercise!",
          text: "Remember to give yourself that reward",
        )
      ]);
}

class _ExposureOldSurvey implements Survey {
  String get title => 'Tvangstanker & -handlinger';

  String get description => 'Skriv tvangstanken og/eller tvangshandlingen som du arbejder på';

  Duration get expire => const Duration(days: 2);

  int get minutesToComplete => 10;

  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat(choices: [
    RPImageChoice(imageUrl: 'assets/icons/very-sad.png', value: 0, description: 'Uudholdelig'),
    RPImageChoice(imageUrl: 'assets/icons/sad.png', value: 1, description: 'Meget stor ubehag'),
    RPImageChoice(imageUrl: 'assets/icons/ok.png', value: 2, description: 'Ret stor ubehag'),
    RPImageChoice(imageUrl: 'assets/icons/happy.png', value: 3, description: 'En vis ubehag'),
    RPImageChoice(imageUrl: 'assets/icons/very-happy.png', value: 4, description: 'Rolig'),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat1 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Nej", value: 0),
    RPChoice(text: "Ja", value: 1),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(
        text: "Denne eksponeringsopgave handler ikke om en tvangstanke",
        value: 0), // TODO: if 0 is selected, no other option is available
    RPChoice(text: "Forurening/kontaminering (snavs, bakterier, sygdomme)", value: 1),
    RPChoice(text: "At skade dig selv eller andre (fysisk eller følelsesmæssigt)", value: 2),
    RPChoice(text: "At gøre noget du ikke vil (fx stjæle noget)", value: 3),
    RPChoice(text: "Voldsomme eller uhyggelige billeder", value: 4),
    RPChoice(text: "Sex, graviditet, eller seksualitet", value: 5),
    RPChoice(text: "At samle ting eller miste noget", value: 6),
    RPChoice(
        text: "Magiske/overtroiske tanker eller handlinger (fx lykketal/uheldstal, at blive forvandlet)",
        value: 7),
    RPChoice(
        text:
            "Bekymring for at have en sygdom eller at en kropsdel eller udseende er mærkeligt eller grimt ud",
        value: 8),
    RPChoice(
        text:
            "Frygt for at fornærme religiøse objekter eller optaget af, hvad der er rigtigt/forkert og moral",
        value: 9),
    RPChoice(text: "Symmetri og orden", value: 10),
    RPChoice(text: "Behov for at vide eller huske", value: 11),
    RPChoice(text: "Frygt for at sige visse ord", value: 12),
    RPChoice(text: "Frygt for ikke præcist at sige det rigtige", value: 13),
    RPChoice(text: "Påtrængende billeder, forestillinger, lyde, ord, musik eller tal", value: 14),
    RPChoice(
        text:
            "Ubehagelig fornemmelse af, at det ikke føles rigtigt, føles ufuldstændigt eller tomhedsfornemmelse, når ritualer ikke udføres på en bestemt måde",
        value: 15),
    RPChoice(text: "Andet", value: 16), // TODO: textbox to describe
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(
        text: "Denne eksponeringsopgave handler ikke om en tvangstanke",
        value: 0), // TODO: if 0 is selected, no other option is available
    RPChoice(text: "Renlighed eller rengøring", value: 1),
    RPChoice(text: "Kontrollere eller tjekke", value: 2),
    RPChoice(text: "Gentage", value: 3),
    RPChoice(text: "Tælle ting", value: 4),
    RPChoice(text: "Ordne ting eller søge at få ting ens", value: 5),
    RPChoice(text: "Samle ting eller svært ved at smide ting væk", value: 6),
    RPChoice(text: "Magisk/overtroisk adfærd", value: 7),
    RPChoice(
        text:
            "Behov for at involvere andre i et ritual, beroligende forsikringer eller få dine forældrene til at medvirke i eller udføre dine kontroltvang",
        value: 8),
    RPChoice(
        text:
            "Mentale ritualer (fremsige fraser eller remser eller gennemgå noget, som man har gjort, sagt eller tænkt igen og igen i tankerne)",
        value: 9),
    RPChoice(text: "Berette, spørge, bekende", value: 10),
    RPChoice(text: "Ritualiseret spisemønster", value: 11),
    RPChoice(text: "Skrive lister", value: 12),
    RPChoice(text: "Føle, banke, gnide", value: 13),
    RPChoice(text: "Gøre ting, indtil det føles rigtigt", value: 14),
    RPChoice(text: "Ritualer, der involverer blinken eller stirren", value: 15),
    RPChoice(text: "Trække hår ud", value: 16),
    RPChoice(text: "Anden selvskadende eller selvdestruktiv adfærd", value: 17),
    RPChoice(text: "Andet", value: 18), // TODO: textbox to describe
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Ja, jeg udført en tvangshandling", value: 0),
    RPChoice(text: "Ja, udført en anden slags sikkerhedsadfærd", value: 1),
    RPChoice(text: "Nej", value: 2),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "demo_survey", steps: [
        RPQuestionStep(
          identifier: "questionStep1ID",
          title:
              "Min behandler har givet mig eksponering og respons præventions øvelser for til hjemmearbejde.",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          identifier: "questionStep2ID",
          title: "Tvangstanken jeg vil arbejde med nu, handler om:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          identifier: "questionStep3ID",
          title: "Tvangshandlingen jeg vil arbejde med nu, handler om:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          identifier: "questionStep4ID",
          title:
              "Beskriv eksponeringsøvelsen (hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen):",
          answerFormat: RPTextAnswerFormat(),
        ),
        RPQuestionStep(
          identifier: "questionStep5ID",
          title: "Skriv tiden når du starter med eksponeringsøvelsen:",
          answerFormat: RPDateTimeAnswerFormat(dateTimeAnswerStyle: RPDateTimeAnswerStyle.TimeOfDay),
        ),
        RPInstructionStep(
            identifier: "",
            title: "Tvangstanker og -handlinger",
            text:
                "Skriv hvor meget ubehag eller angst du oplever lige inden øvelsen og efter 5, 10, og 15 minutter ved hjælp af en skala fra 0–10 på (0 = rolig, ingen angst, 10 = Maksimal angst/ uro). Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned."),
        RPQuestionStep(
          identifier: "exposure_1",
          title: "Hvor megen ubehag eller angst oplever du lige nu?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "exposure_2",
          title: "Hvor megen ubehag eller angst oplever du efter 5 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "exposure_3",
          title: "Hvor megen ubehag eller angst oplever du efter 10 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "exposure_4",
          title: "Hvor megen ubehag eller angst oplever du efter 15 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          identifier: "questionStep6ID",
          title: "Jeg har brugt sikkerhedsadfærd under øvelsen:",
          answerFormat: choiceAnswerFormat6,
        ),
        RPCompletionStep(
          identifier: "completion",
          title: "Godt gået!",
          text: "Du har arbejdet på at forstyrre på OCD’en.",
        )

        /* RPInstructionStep(title: "Tvangstanker og -handlinger")
          ..text = "I denne øvelse skal du først notere en tvangstanke eller -handling som du arbejder på. "
              "Derefter skal du beskrive hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen.\n\n"
              "Når du så starter med at arbejde med øvelsen, så skal du notere hvor meget "
              "ubehag eller angst du oplever undervejs.\n\n"
              "Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned.",
        RPQuestionStep(
            "thought",
            "Skriv tvangstanken og/eller tvangshandlingen som du arbejder på",
            RPIntegerAnswerFormat(text: 0, 200)),
        RPQuestionStep(
            "exercise",
            "Beskriv eksponeringsøvelsen, dvs. hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen",
            RPIntegerAnswerFormat(text: 0, 200)),
        RPInstructionStep(title: "Tvangstanker og -handlinger")
          ..text = "Nu skal du begynde at arbejde med øvelsen. "
              "Mens du gør det, så skal du skrive hvor meget "
              "ubehag eller angst du oplever lige nu og efter 5, 10, og 15 minutter.\n\n"
              "Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned.", */
      ]);
}

class _PARNASSurvey implements Survey {
  String get title => 'Positive & Negative Affect';

  String get description => 'A short survey on you current fealings';

  Duration get expire => const Duration(days: 2);

  int get minutesToComplete => 4;

  final RPChoiceAnswerFormat _locationChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "Alone", value: 1),
    RPChoice(text: "With my other children who are not part of the study", value: 2),
    RPChoice(text: "With my child who is part of the study", value: 3),
    RPChoice(text: "With the child's other parent", value: 3),
    RPChoice(text: "With my friends", value: 4),
    RPChoice(text: "With others", value: 5),
  ]);

  final RPChoiceAnswerFormat _parnasAnswerFormat =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Much", value: 5),
    RPChoice(text: "Pretty much", value: 4),
    RPChoice(text: "Moderate", value: 3),
    RPChoice(text: "A little", value: 2),
    RPChoice(text: "Not at all", value: 1),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "demo_survey", steps: [
        RPInstructionStep(
            identifier: "parnas_instrux",
            title: "Where are you?",
            text: "In the following question, please indicate where you are, and who you are with."),
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
  String get title => "WHO5 Well-Being";
  String get description => "A short 5-item survey on your well-being.";
  int get minutesToComplete => 1;
  Duration get expire => const Duration(days: 5);

  static List<RPChoice> _choices = [
    RPChoice(text: "All of the time", value: 5),
    RPChoice(text: "Most of the time", value: 4),
    RPChoice(text: "More than half of the time", value: 3),
    RPChoice(text: "Less than half of the time", value: 2),
    RPChoice(text: "Some of the time", value: 1),
    RPChoice(text: "At no time", value: 0),
  ];

  final RPChoiceAnswerFormat _choiceAnswerFormat =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: _choices);

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
          identifier: "who5_ompletion",
          title: "Finished",
          text: "Thank you for filling out the survey!",
        )
      ]);
}

class _DemographicSurvey implements Survey {
  String get title => "Demographics";
  String get description => "A short 4-item survey on your background.";
  int get minutesToComplete => 2;
  Duration get expire => const Duration(days: 5);

  final RPChoiceAnswerFormat _sexChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Femal", value: 1),
    RPChoice(text: "Male", value: 2),
    RPChoice(text: "Other", value: 3),
    RPChoice(text: "Prefer not to say", value: 4),
  ]);

  final RPChoiceAnswerFormat _ageChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
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

  final RPChoiceAnswerFormat _medicalChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "None", value: 1),
    RPChoice(text: "Asthma", value: 2),
    RPChoice(text: "Cystic fibrosis", value: 3),
    RPChoice(text: "COPD/Emphysema", value: 4),
    RPChoice(text: "Pulmonary fibrosis", value: 5),
    RPChoice(text: "Other lung disease  ", value: 6),
    RPChoice(text: "High Blood Pressure", value: 7),
    RPChoice(text: "Angina", value: 8),
    RPChoice(text: "Previous stroke or Transient ischaemic attack  ", value: 9),
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

  final RPChoiceAnswerFormat _smokeChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: [
    RPChoice(text: "Never smoked", value: 1),
    RPChoice(text: "Ex-smoker", value: 2),
    RPChoice(text: "Current smoker (less than once a day", value: 3),
    RPChoice(text: "Current smoker (1-10 cigarettes pr day", value: 4),
    RPChoice(text: "Current smoker (11-20 cigarettes pr day", value: 5),
    RPChoice(text: "Current smoker (21+ cigarettes pr day", value: 6),
    RPChoice(text: "Prefer not to say", value: 7),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "demo_survey", steps: [
        RPQuestionStep(
          identifier: "demo_1",
          title: "Which is your biological sex?",
          answerFormat: _sexChoices,
        ),
        RPQuestionStep(
          identifier: "demo_2",
          title: "How old are you?",
          answerFormat: _ageChoices,
        ),
        RPQuestionStep(
          identifier: "demo_3",
          title: "Do you have any of these medical conditions?",
          answerFormat: _medicalChoices,
        ),
        RPQuestionStep(
          identifier: "demo_4",
          title: "Do you, or have you, ever smoked (including e-cigarettes)?",
          answerFormat: _smokeChoices,
        ),
      ]);
}

class _SymptomsSurvey implements Survey {
  String get title => "Symptoms";
  String get description => "A short 1-item survey on your daily symptoms.";
  int get minutesToComplete => 1;
  Duration get expire => const Duration(days: 1);

  RPChoiceAnswerFormat _symptomsChoices =
      RPChoiceAnswerFormat(answerStyle: RPChoiceAnswerStyle.MultipleChoice, choices: [
    RPChoice(text: "None", value: 1),
    RPChoice(text: "Fever (warmer than usual)", value: 2),
    RPChoice(text: "Dry cough", value: 3),
    RPChoice(text: "Wet cough", value: 4),
    RPChoice(text: "Sore throat, runny or blocked nose", value: 5),
    RPChoice(text: "Loss of taste and smell", value: 6),
    RPChoice(text: "Difficulty breathing or feeling short of breath", value: 7),
    RPChoice(text: "Tightness in your chest", value: 8),
    RPChoice(text: "Dizziness, confusion or vertigo", value: 9),
    RPChoice(text: "Headache", value: 10),
    RPChoice(text: "Muscle aches", value: 11),
    RPChoice(text: "Chills", value: 12),
    RPChoice(text: "Prefer not to say", value: 13),
  ]);

  RPTask get survey => RPOrderedTask(identifier: "symptoms_survey", steps: [
        RPQuestionStep(
          identifier: "sym_1",
          title: "Do you have any of the following symptoms today?",
          answerFormat: _symptomsChoices,
        ),
      ]);
}
