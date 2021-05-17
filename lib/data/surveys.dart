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

  RPTask get survey => RPOrderedTask("Symptom Hierarchy: Obsessions", [
        RPInstructionStep(
          title: "Obsessions",
        )..text =
            "Symptom Hierarchy: Obsessions\n\n\nObsessions are unwanted thoughts or images that keep popping into your head and that you can't stop thinking about, even though you want to be rid of them.\n\nOn the next pages, you will see obsessions that many people with OCD have. Tell us how upset or scared each obsession has been for you over the past week by choosing the number that best matches how you feel. 0 means that you have not had the obsession or that it is not at all unpleasant and 10 means that the obsession is so upsetting you can’t stand it.",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "Fear/ disgust of pollution, infection, dirt, bacteria, diseases",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question2",
          "Fear of harming yourself or others (body or feelings)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question3",
          "Disturbing thoughts/ images about sex, pregnancy or sexuality",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question4",
          "Need to collect things or fear of losing something",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "Magical/superstitious thoughts or actions (e.g. lucky numbers or words; stepping on a crack can break someone’s back)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question6",
          "Worry about having a disease or that a body part or your appearance looks wrong",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question7",
          "Fear of offending God or Satan or worry about what is right and wrong",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question8",
          "Symmetry and order (e.g. that things must lie in a certain way, or things must be in order)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question9",
          "Needing to do something until it feels right or not wrong",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question10",
          "Here you can describe other obsessions that have not been mentioned",
          RPTextAnswerFormat.withParams(" "),
          optional: true,
        ),
        RPCompletionStep("completion")
          ..title = "Hurray!"
          ..text =
              "You are finished recording your obsessions for this week. By keeping track of your obsessions and compulsions, you're taking back control, so OCD doesn't control you.",
      ]);
}

class _SymptomHierarchySurveyCompulsions implements Survey {
  String get title => 'Symptom Hierarchy: Compulsions';

  String get description =>
      'This form is designed to help you keep track of how your compulsions change from week to week.';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPTask get survey => RPOrderedTask("Symptom Hierarchy: Compulsions", [
        RPInstructionStep(
          title: "Compulsions",
        )..text =
            "Symptom hierarchy: Compulsions\n\n\nCompulsions are things that OCD wants you to do. If you try to resist doing these things or try not to do what OCD tells to, you may feel afraid, worried, frustrated, angry or upset.\n\nOn the next pages there will be some compulsions that many people with OCD have. Tell us how upset each compulsion (or trying to resist the compulsion) has been for you over the past week by choosing the number that best matches how you feel. 0 means that you do not have that compulsion or that does not bother you and 10 means that the compulsion upsets you so much that you can’t stand it.",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "Washing or cleaning",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question2",
          "Checking (like if you have remembered to lock the door)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question3",
          "Repeating actions (like turning the lights on and off several times)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question4",
          "Counting things",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "Fixing things or try to get things the same or symmetrical",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question6",
          "Collecting things or difficulty throwing things away",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question7",
          "Magical/superstitious behavior (e.g. doing or saying things a certain number of times to prevent something terrible from happening)",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question8",
          "Involving others (like your parents) in a ritual or asking for reassurance",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question9",
          "Needing to do something until it feels right",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question10",
          "Here you can describe other compulsions that have not been mentioned",
          RPTextAnswerFormat.withParams(" "),
          optional: true,
        ),
        RPCompletionStep("completion")
          ..title = "Hurray!"
          ..text =
              "You are finished recording your compulsions for this week. By keeping track of your obsessions and compulsions, you're taking back control, so OCD doesn't control you.",
      ]);
}

class _TimedExposureSurvey implements Survey {
  String get title => "Weekly exposure and response prevention";

  String get description => 'Describe the obsession and/or the compulsion you are working on';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 10; // TODO: review time

  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat.withParams([
    RPImageChoice.withParams(Image.asset('assets/icons/very-sad.png'), 0, "Unbearable"),
    RPImageChoice.withParams(Image.asset('assets/icons/sad.png'), 0, "Very great discomfort"),
    RPImageChoice.withParams(Image.asset('assets/icons/ok.png'), 0, "Quite a lot of discomfort"),
    RPImageChoice.withParams(Image.asset('assets/icons/happy.png'), 0, "A certain discomfort"),
    RPImageChoice.withParams(Image.asset('assets/icons/very-happy.png'), 0, "Calm"),
  ]);

  RPTask get survey => RPOrderedTask("Timed_Exposure_exercise", [
        RPQuestionStep.withAnswerFormat(
          "question1",
          "How scared or upset do you feel?",
          _imageChoiceAnswerFormat,
        ),
      ]);
}

class _TrustScaleSurvey implements Survey {
  String get title => 'Trust in the Mobile App';

  String get description => 'We would like to know what it was like for you to use the mobile app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Strongly disagree", 0),
    RPChoice.withParams("Slightly disagree", 1),
    RPChoice.withParams("Agree", 2),
    RPChoice.withParams("Strongly agree", 3),
  ]);

  RPTask get survey => RPOrderedTask("User Experience with App", [
        RPInstructionStep(title: " ", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "We would like to know what it was like for you to use the mobile app.\n\nPlease read each statement and chose the number (0, 1, 2, or 3) that best describes how you feel.",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "I believe that there could be negative consequences when using this mobile app",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question2",
          "I feel I must be cautious when using this mobile app",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question3",
          "It is risky to interact with this mobile app",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question4",
          "I think that this mobile app is competent and effective in supporting the research study",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "I think that this mobile app performs its role as a tool for research very well",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question6",
          "I believe that this mobile app has all the functionalities I would expect from a research study app",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question7",
          "When I use this mobile app, I feel I can count on it completely",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question8",
          "I can always rely on the mobile app for guidance and assistance",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question9",
          "I can trust the information presented to me by the mobile app",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question10",
          "I believe that the mobile app provides me with benefits",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question11",
          "I believe that the mobile app will show me how to get support if I need help",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question12",
          "I believe that the mobile app attends to my needs and preferences",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question13",
          "Is there anything else you would like to tell us about your experience?",
          RPTextAnswerFormat.withParams(''),
          optional: true,
        ),
        RPCompletionStep("completion")
          ..title = "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _InformedConsentSurvey implements Survey {
  String get title => 'Evaluation of the mobile app consent';

  String get description => 'We would like to know your experience with the informed consent'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 4;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely not understandable.", 0),
    RPChoice.withParams("Mostly not understandable.", 1),
    RPChoice.withParams("Mostly understandable.", 2),
    RPChoice.withParams("Extremely understandable.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely easy to navigate.", 0),
    RPChoice.withParams("Mostly easy to navigate.", 1),
    RPChoice.withParams("Mostly difficult to navigate.", 2),
    RPChoice.withParams("Extremely difficult to navigate.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely valuable.", 0),
    RPChoice.withParams("Mostly valuable.", 1),
    RPChoice.withParams("Mostly inferior.", 2),
    RPChoice.withParams("Extremely inferior.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely boring.", 0),
    RPChoice.withParams("Mostly boring.", 1),
    RPChoice.withParams("Mostly exciting.", 2),
    RPChoice.withParams("Extremely exciting.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely not interesting.", 0),
    RPChoice.withParams("Mostly not interesting.", 1),
    RPChoice.withParams("Mostly interesting.", 2),
    RPChoice.withParams("Extremely interesting.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely fast.", 0),
    RPChoice.withParams("Mostly fast.", 1),
    RPChoice.withParams("Mostly slow.", 2),
    RPChoice.withParams("Extremely slow.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely complicated.", 0),
    RPChoice.withParams("Mostly complicated.", 1),
    RPChoice.withParams("Mostly easy to understand.", 2),
    RPChoice.withParams("Extremely easy to understand.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely motivating.", 0),
    RPChoice.withParams("Mostly motivating.", 1),
    RPChoice.withParams("Mostly demotivating.", 2),
    RPChoice.withParams("Extremely demotivating.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat9 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely inefficient.", 0),
    RPChoice.withParams("Mostly inefficient.", 1),
    RPChoice.withParams("Mostly efficient.", 2),
    RPChoice.withParams("Extremely efficient.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat10 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely clear.", 0),
    RPChoice.withParams("Mostly clear.", 1),
    RPChoice.withParams("Mostly confusing.", 2),
    RPChoice.withParams("Extremely confusing.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat11 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely impractical.", 0),
    RPChoice.withParams("Mostly impractical.", 1),
    RPChoice.withParams("Mostly practical.", 2),
    RPChoice.withParams("Extremely practical.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat12 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely organized.", 0),
    RPChoice.withParams("Mostly organized.", 1),
    RPChoice.withParams("Mostly cluttered.", 2),
    RPChoice.withParams("Extremely cluttered.", 3),
  ]);
  RPTask get survey => RPOrderedTask("Informed consent", [
        RPInstructionStep(title: " ", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "Please make your evaluation of the app informed consent now.\n\nThe questionnaire consists of attributes that may apply to the app informed consent. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "The app informed consent was:",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question2",
          "The app informed consent was:",
          choiceAnswerFormat2,
        ),
        RPQuestionStep.withAnswerFormat(
          "question3",
          "The app informed consent was:",
          choiceAnswerFormat3,
        ),
        RPQuestionStep.withAnswerFormat(
          "question4",
          "The app informed consent was:",
          choiceAnswerFormat4,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "The app informed consent was:",
          choiceAnswerFormat5,
        ),
        RPQuestionStep.withAnswerFormat(
          "question6",
          "The app informed consent was:",
          choiceAnswerFormat6,
        ),
        RPQuestionStep.withAnswerFormat(
          "question7",
          "The app informed consent was:",
          choiceAnswerFormat7,
        ),
        RPQuestionStep.withAnswerFormat(
          "question8",
          "The app informed consent was:",
          choiceAnswerFormat8,
        ),
        RPQuestionStep.withAnswerFormat(
          "question9",
          "The app informed consent was:",
          choiceAnswerFormat9,
        ),
        RPQuestionStep.withAnswerFormat(
          "question10",
          "The app informed consent was:",
          choiceAnswerFormat10,
        ),
        RPQuestionStep.withAnswerFormat(
          "question11",
          "The app informed consent was:",
          choiceAnswerFormat11,
        ),
        RPQuestionStep.withAnswerFormat(
          "question11",
          "The app informed consent was:",
          choiceAnswerFormat12,
        ),
        RPCompletionStep("completion")
          ..title = "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _AppUXSurvey implements Survey {
  String get title => 'User Experience with the Mobile App';

  String get description => 'We would like to know your experience with the app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely obstructive.", 0),
    RPChoice.withParams("Mostly obstructive.", 1),
    RPChoice.withParams("Mostly supportive.", 2),
    RPChoice.withParams("Extremely supportive.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely complicated.", 0),
    RPChoice.withParams("Mostly complicated.", 1),
    RPChoice.withParams("Mostly easy.", 2),
    RPChoice.withParams("Extremely easy.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely inefficient.", 0),
    RPChoice.withParams("Mostly inefficient.", 1),
    RPChoice.withParams("Mostly efficient.", 2),
    RPChoice.withParams("Extremely efficient.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely confusing.", 0),
    RPChoice.withParams("Mostly confusing.", 1),
    RPChoice.withParams("Mostly clear.", 2),
    RPChoice.withParams("Extremely clear.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely boring.", 0),
    RPChoice.withParams("Mostly boring.", 1),
    RPChoice.withParams("Mostly exciting.", 2),
    RPChoice.withParams("Extremely exciting.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely not interesting.", 0),
    RPChoice.withParams("Mostly not interesting.", 1),
    RPChoice.withParams("Mostly interesting.", 2),
    RPChoice.withParams("Extremely interesting.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely conventional.", 0),
    RPChoice.withParams("Mostly conventional.", 1),
    RPChoice.withParams("Mostly inventive.", 2),
    RPChoice.withParams("Extremely inventive.", 3),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Extremely usual.", 0),
    RPChoice.withParams("Mostly usual.", 1),
    RPChoice.withParams("Mostly leading edge.", 2),
    RPChoice.withParams("Extremely leading edge.", 3),
  ]);

  RPTask get survey => RPOrderedTask("User Experience with App", [
        RPInstructionStep(title: " ", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "Please make your evaluation of this mobile app now.\n\nThe questionnaire consists of attributes that may apply to the app. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "The app is:",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "question2",
          "The app is:",
          choiceAnswerFormat2,
        ),
        RPQuestionStep.withAnswerFormat(
          "question3",
          "The app is:",
          choiceAnswerFormat3,
        ),
        RPQuestionStep.withAnswerFormat(
          "question4",
          "The app is:",
          choiceAnswerFormat4,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "The app is:",
          choiceAnswerFormat5,
        ),
        RPQuestionStep.withAnswerFormat(
          "question6",
          "The app is:",
          choiceAnswerFormat6,
        ),
        RPQuestionStep.withAnswerFormat(
          "question7",
          "The app is:",
          choiceAnswerFormat7,
        ),
        RPQuestionStep.withAnswerFormat(
          "question8",
          "The app is:",
          choiceAnswerFormat8,
        ),
        RPCompletionStep("completion")
          ..title = "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _EcologicalParentsSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("No", 0),
    RPChoice.withParams("Yes", 1),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Very slightly or not at all", 1),
    RPChoice.withParams("A little", 2),
    RPChoice.withParams("Moderately", 3),
    RPChoice.withParams("Quite a bit", 4),
    RPChoice.withParams("Extremely", 5),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("I am alone", 0),
    RPChoice.withParams("I am with my child who is participating in the study", 1),
    RPChoice.withParams("I am with my child(ren) who is/are not participating in the study", 2),
    RPChoice.withParams("I am with my participating child’s other parent)", 3),
    RPChoice.withParams("I am with my friends", 4),
    RPChoice.withParams("I am with others we have not mentioned", 5)
  ]);

  RPTask get survey => RPOrderedTask(
        "Ecological Momentary Assessment Child",
        [
          RPQuestionStep.withAnswerFormat(
            "question1",
            "Are you alone?",
            choiceAnswerFormat3,
          ),
          RPInstructionStep(title: " ")
            ..text = "Indicate the extent you have felt this way over the past week.",
          RPQuestionStep.withAnswerFormat(
            "question7",
            "Upset",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "Hostile",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "Alert",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "Ashamed",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "Inspired",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "Nervous",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "Determined",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Attentive",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question15",
            "Afraid",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "questio16",
            "Active",
            choiceAnswerFormat2,
          ),
          RPCompletionStep("completion")
            ..title = "Well done!" // thank you for telling us how you feel
            ..text = " ", // by telling us how you feel you are helping us learn what the of the wristband
          //by answering this survey you are helping us connect feelings to physiological signals
        ],
      );
}

class _EcologicalSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("No", 0),
    RPChoice.withParams("Yes", 1),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Very slightly or not at all", 1),
    RPChoice.withParams("A little", 2),
    RPChoice.withParams("Moderately", 3),
    RPChoice.withParams("Quite a bit", 4),
    RPChoice.withParams("Extremely", 5),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("I am alone", 0),
    RPChoice.withParams("I am with my mother/father who is also participating in the study", 1),
    RPChoice.withParams("I am  with my other parent who is not participating in the study", 2),
    RPChoice.withParams("I am with my sister(s) and/ or brother(s)", 3),
    RPChoice.withParams("I am with my friends", 4),
    RPChoice.withParams("I am with others we have not mentioned", 5)
  ]);

  RPTask get survey => RPOrderedTask(
        "Ecological Momentary Assessment Child",
        [
          RPQuestionStep.withAnswerFormat(
            "question1",
            "Are you alone?",
            choiceAnswerFormat3,
          ),
          RPInstructionStep(
              title: "We would like to know your current mood", imagePath: 'assets/icons/survey.png')
            ..text =
                "Below are a list of different feelings and emotions.\n\nPlease read each feeling and choose the option that best matches how much you feel each feeling right now.",
          RPQuestionStep.withAnswerFormat(
            "question7",
            "Miserable",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "Mad",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "Lively",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "Sad",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "Joyful",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "Scared",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "Cheerful",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Happy",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question15",
            "Afraid",
            choiceAnswerFormat2,
          ),
          RPQuestionStep.withAnswerFormat(
            "question16",
            "Proud",
            choiceAnswerFormat2,
          ),
          RPCompletionStep("completion")
            ..title = "Thank you for telling us how you feel" //
            ..text =
                "By answering this survey you are helping us connect how you feel to your bodily signals",
        ],
      );
}

class _PatientParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Strongly disagree", 0),
    RPChoice.withParams("Slightly disagree", 1),
    RPChoice.withParams("Agree", 2),
    RPChoice.withParams("Strongly agree", 3),
  ]);

  RPTask get survey => RPOrderedTask(
        "PATIENT_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        [
          RPInstructionStep(title: "Wristband with biosensor", imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep.withAnswerFormat(
            "question1",
            "I like how the wristband looks.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question2",
            "The wristband looks too big.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question3",
            "I was embarrassed to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question4",
            "The wristband looks cool.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question5",
            "The wristband attracted too much attention.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question6",
            "The wristband was comfortable.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question7",
            "The wristband fit well around my wrist.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "The wristband was easy to use.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "The wristband was easy to charge.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "I often forgot to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "I wanted to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "It was irritating to push the button on the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "I remembered to push the button on the wristband each time my child’s OCD bothered me.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Is there anything else you would like to tell us about your experience wearing the wristband?",
            RPTextAnswerFormat.withParams(''),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "You are done!"
            ..text =
                "Thank you for telling us what you think about the wristband. Your answers will be taken into account"
        ],
      );
}

class _PatientSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Strongly disagree", 0),
    RPChoice.withParams("Slightly disagree", 1),
    RPChoice.withParams("Agree", 2),
    RPChoice.withParams("Strongly agree", 3),
  ]);

  RPTask get survey => RPOrderedTask(
        "PATIENT_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        [
          RPInstructionStep(title: "Wristband with biosensor", imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep.withAnswerFormat(
            "question1",
            "I like how the wristband looks.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question2",
            "The wristband looks too big.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question3",
            "I was embarrassed to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question4",
            "The wristband looks cool.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question5",
            "The wristband attracted too much attention.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question6",
            "The wristband was comfortable.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question7",
            "The wristband fit well around my wrist.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "The wristband was easy to use.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "The wristband was easy to charge.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "I often forgot to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "I wanted to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "It was irritating to push the button on the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "I remembered to push the button on the wristband every time OCD was bothering me.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Is there anything else you would like to tell us about your experience wearing the wristband?",
            RPTextAnswerFormat.withParams(''),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "You are done!"
            ..text =
                "Thank you for telling us what you think about the wristband. Your answers will help us make the wristband better",
        ],
      );
}

class _ControlParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Strongly disagree", 0),
    RPChoice.withParams("Slightly disagree", 1),
    RPChoice.withParams("Agree", 2),
    RPChoice.withParams("Strongly agree", 3),
  ]);

  RPTask get survey => RPOrderedTask(
        "KONTROL_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        [
          RPInstructionStep(title: "Wristband with biosensor", imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep.withAnswerFormat(
            "question1",
            "I like how the wristband looks.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question2",
            "The wristband looks too big.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question3",
            "I was embarrassed to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question4",
            "The wristband looks cool.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question5",
            "The wristband attracted too much attention.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question6",
            "The wristband was comfortable.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question7",
            "The wristband fit well around my wrist.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "The wristband was easy to use.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "The wristband was easy to charge.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "I often forgot to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "I wanted to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "It was irritating to push the button on the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "I remembered to push the button on the wristband each time my child’s stress botheredme.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Is there anything else you would like to tell us about your experience wearing the wristband?",
            RPTextAnswerFormat.withParams(''),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "You are done!" //
            ..text =
                "Thank you for telling us what you think about the wristband. Your answers will be taken into account",
        ],
      );
}

class _ControlSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description => "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Strongly disagree", 0),
    RPChoice.withParams("Slightly disagree", 1),
    RPChoice.withParams("Agree", 2),
    RPChoice.withParams("Strongly agree", 3),
  ]);

  RPTask get survey => RPOrderedTask(
        "KONTROL_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        [
          RPInstructionStep(title: "Wristband with biosensor", imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep.withAnswerFormat(
            "question1",
            "I like how the wristband looks.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question2",
            "The wristband looks too big.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question3",
            "I was embarrassed to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question4",
            "The wristband looks cool.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question5",
            "The wristband attracted too much attention.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question6",
            "The wristband was comfortable.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question7",
            "The wristband fit well around my wrist.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question8",
            "The wristband was easy to use.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question9",
            "The wristband was easy to charge.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question10",
            "I often forgot to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question11",
            "I wanted to wear the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question12",
            "It was irritating to push the button on the wristband.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question13",
            "I remembered to push the button on the wristband every time stress was bothering me.",
            choiceAnswerFormat1,
          ),
          RPQuestionStep.withAnswerFormat(
            "question14",
            "Is there anything else you would like to tell us about your experience wearing the wristband?",
            RPTextAnswerFormat.withParams(''),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "You are done!"
            ..text =
                "Thank you for telling us what you think about the wristband. Your answers will help us make the wristband better",
        ],
      );
}

class _ExposureSurvey implements Survey {
  String get title => "Fight back against OCD";

  String get description => 'Describe the obsession and/or the compulsion you are working on';

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10; // TODO: review time

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("My discomfort/fear/disgust will grow and grow until I can't take it any more", 0),
    RPChoice.withParams("My discomfort/fear/disgust will not change", 1),
    RPChoice.withParams("I will feel less discomfort/fear/disgust over time", 2),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Read an exciting book", 0),
    RPChoice.withParams("Eat something delicious", 1),
    RPChoice.withParams("Watch an episode of your favorite series", 2),
    RPChoice.withParams("Do something fun with friends/ family (make a plan)", 2),
    RPChoice.withParams("Play a game", 4),
    RPChoice.withParams("Play a computer/videogame", 5),
    RPChoice.withParams("I will do something not listed here", 6),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("No", 0),
    RPChoice.withParams("Yes", 1),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat4 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("Fear/ disgust of pollution, infection, dirt, bacteria, diseases", 0),
    RPChoice.withParams("Fear of harming myself or others (physically or emotionally)", 1),
    RPChoice.withParams("Disturbing thoughts/ images about sex, pregnancy or sexuality", 2),
    RPChoice.withParams("Need to collect things or fear of losing something", 3),
    RPChoice.withParams(
        "Magical/superstitious thoughts or actions (e.g. lucky numbers or words; stepping on a crack can break someone’s back)",
        4),
    RPChoice.withParams(
        "Worry about having a disease or that a body part or your appearance looks wrong)", 5),
    RPChoice.withParams("Fear of offending God or Satan or worry about what is right and wrong", 6),
    RPChoice.withParams(
        "Symmetry and order (e.g. that things must lie in a certain way, or things must be in order)", 7),
    RPChoice.withParams("Needing to do something until it feels right or not wrong", 8),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat5 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("Washing or cleaning", 0),
    RPChoice.withParams("Checking (like if you have remembered to lock the door)", 1),
    RPChoice.withParams("Repeating actions (like turning the lights on and off several times)", 2),
    RPChoice.withParams("Counting things", 3),
    RPChoice.withParams("Fixing things or trying to get things in a certain place or symmetrical", 4),
    RPChoice.withParams("Collecting things or difficulty throwing things away", 5),
    RPChoice.withParams(
        "Magical/superstitious behavior (like doing or saying things a certain number of times to prevent something bad from happening)",
        6),
    RPChoice.withParams("Involving your parents in a ritual or asking for reassurance", 7),
    RPChoice.withParams("Doing something until it feels right", 8),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("My discomfort grew until I couldn’t stand it anymore", 0),
    RPChoice.withParams("My discomfort went up and down", 1),
    RPChoice.withParams("My discomfort did not really change", 2),
    RPChoice.withParams("I felt less discomfort with time", 3),
  ]);

  // RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat.withParams([
  //   RPImageChoice.withParams(Image.asset('assets/icons/very-sad.png'), 0, "Unbearable"),
  //   RPImageChoice.withParams(Image.asset('assets/icons/sad.png'), 0, "Very great discomfort"),
  //   RPImageChoice.withParams(Image.asset('assets/icons/ok.png'), 0, "Quite a lot of discomfort"),
  //   RPImageChoice.withParams(Image.asset('assets/icons/happy.png'), 0, "A certain discomfort"),
  //   RPImageChoice.withParams(Image.asset('assets/icons/very-happy.png'), 0, "Calm"),
  // ]);
  // RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
  //   RPChoice.withParams("Yes, I did a compulsion", 0),
  //   RPChoice.withParams("Yes, I used another type of safety behavior", 1),
  //   RPChoice.withParams("No, I completed the task without any safety behaviors", 2),
  // ]);

  RPTask get survey => RPOrderedTask("Exposure_SUDS_v2_2021.04.22", [
        RPInstructionStep(title: "Exposure and response prevention", imagePath: 'assets/icons/survey.png')
          ..text =
              "This survey is designed to help you practice fighting OCD. To take back control from OCD, you must do the opposite of what OCD wants you to do. For example, you may touch some food left over on your plate or say some “dangerous” words. Or, if the OCD tells you to touch things a certain number of times, don't do it. Going against OCD can be scary or upsetting. But, to take control back from OCD, you can’t run away from the discomfort or fear - you must tough it out.\n\nDuring the exercise, notice what happens to the feeling of discomfort for up to 15 minutes.\n\nWhile you practice going against OCD, your parents or your therapist can help you use this form.",
        RPQuestionStep.withAnswerFormat(
          "question1",
          "What do you think is going to happen to your feelings of discomfort, fear or disgust when you practice doing the opposite of what OCD wants you to do? ",
          choiceAnswerFormat1,
        ),
        RPInstructionStep(title: " ")
          ..text =
              "Many children and adolescents think that their fear or discomfort will get worse and worse when they practice going against OCD, but that is not what happens.\n\nFor many children and adolescents, the fear/discomfort goes up and down during the exercise. For some people, the fear/discomfort becomes less during the exercise. Others find that their fear/discomfort does not really change during the exercise, but then they learn that fear and discomfort are not dangerous. With lots of practice, you should really notice that you feel less fear, disgust or discomfort.",
        RPQuestionStep.withAnswerFormat(
          "question2",
          "Before you start practicing going against OCD, prepare for the exercise by answering some questions.\n\nYou're going to do something difficult and that should be rewarded. How will you reward yourself after the exercise of fighting OCD?",
          choiceAnswerFormat2,
        ),

        RPQuestionStep.withAnswerFormat(
          "question3",
          "In the exercise, I will work on an obsession.\n\n(Obsessions are unwanted thoughts or images that keep popping into your head and that you can't stop thinking about, even though you want to be rid of them.)",
          choiceAnswerFormat3,
        ),

        // TODO: if previous question is no skip
        RPQuestionStep.withAnswerFormat(
          "question4",
          "The obsession I want to work on now is about:",
          choiceAnswerFormat4,
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question5",
          "You can describe the obsession you want to work on here, if you would like to describe it detail or if you could not find an obsession in the list.",
          RPTextAnswerFormat.withParams(" "),
          optional: true,
        ),

////////////////////////////////
        RPQuestionStep.withAnswerFormat(
          "question6",
          "I want to work with a compulsion.\n\n\n(Compulsions are things that OCD wants you to do. If you try to resist doing these things or try not to do what OCD tells you to, you may feel afraid, worried, frustrated, angry or upset.)",
          choiceAnswerFormat3,
        ),

        // TODO: if previous question is no skip
        RPQuestionStep.withAnswerFormat(
          "question7",
          "The compulsion I will work on is about:",
          choiceAnswerFormat5,
          optional: true,
        ),

        RPQuestionStep.withAnswerFormat(
          "question8",
          "You can describe the compulsion you want to work on here, if you would like to describe it detail or if you could not find a compulsion in the list.",
          RPTextAnswerFormat.withParams(" "),
          optional: true,
        ),

        RPQuestionStep.withAnswerFormat(
            "question9",
            "Describe how you will practice going against OCD. How do you want to work on the obsession and/or compulsion (for example touching the toilet seat or making your desk messy):",
            RPTextAnswerFormat.withParams(''),
            optional: true),

        RPInstructionStep(title: " ", imagePath: 'assets/images/timer_task.png')
          ..text =
              "On the next pages, you will be asked to note how much fear or discomfort you experience while you go against OCD.\n\nStart by noting how uncomfortable it is for you to think about doing the exercise you just described on a scale of 0 to 10. 0 means that you are completely calm or not at all afraid. 10 means that you are so scared or upset you can’t stand it.",

        // TODO: TIMER STEP IN BETWEEN ALL OF THE FOLLOWING QUESTIONS
        RPQuestionStep.withAnswerFormat(
          "question10",
          "How much discomfort do you feel after 1 minute?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question11",
          "How much discomfort do you feel after 3 minutes?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question12",
          "How much discomfort do you feel after 5 minutes?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question13",
          "How much discomfort do you feel after 7 minutes?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question14",
          "How much discomfort do you feel after 10 minutes?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
          "question15",
          "How much discomfort do you feel after 15 minutes?",
          RPSliderAnswerFormat.withParams(0, 10, divisions: 10),
          optional: true,
        ),
        RPQuestionStep.withAnswerFormat(
            "question16",
            "Well done! You stayed with some difficult feelings!\n\nWhat happened to those difficult feelings when you practiced doing the opposite of what OCD wants?",
            choiceAnswerFormat6),

        RPCompletionStep("completion")
          ..title = "You are done with the exercise!"
          ..text = "Remember to give yourself that reward",
      ]);
}

// class _ExposureSurvey implements Survey {
//   String get title => "Weekly exposure and response prevention";

//   String get description => 'Describe the obsession and/or the compulsion you are working on';

//   Duration get expire => const Duration(days: 7);

//   int get minutesToComplete => 10; // TODO: review time

//   RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
//     RPChoice.withParams("No", 0),
//     RPChoice.withParams("Yes", 1),
//   ]);
//   RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
//     RPChoice.withParams("Contamination (dirt, bacteria, sickness)", 0),
//     RPChoice.withParams("Hurting myself or others (physically or emotionally)", 1),
//     RPChoice.withParams("Sex, pregnancy or sexuality", 2),
//     RPChoice.withParams("Collecting things or fear of losing something", 3),
//     RPChoice.withParams("Magical thoughts or superstitions (un/lucky number)", 4),
//     RPChoice.withParams(
//         "My body (worry that I have a disease or that I or one of my body parts looks wrong)", 5),
//     RPChoice.withParams(
//         "Fear of offending a religous object (god or satan) or morality (right and wrong)", 6),
//     RPChoice.withParams(
//         "Ordering and arranging (things need to be arranged in a certain way or arranging things in a certain order.)",
//         7),
//     RPChoice.withParams("Other", 8),
//   ]);

//   RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
//     RPChoice.withParams("Washing or cleaning", 0),
//     RPChoice.withParams("Checking (like checking the doors are locked)", 1),
//     RPChoice.withParams("Repeating rituals (like turning on and off the lights repeatedly)", 2),
//     RPChoice.withParams("Counting", 3),
//     RPChoice.withParams("Arranging or putting this in order", 4),
//     RPChoice.withParams("Collecting or saving things", 5),
//     RPChoice.withParams(
//         "Superstitious behaviors (like avoiding stepping on cracks in the sidewalk to avoid something bad from happening)",
//         6),
//     RPChoice.withParams(
//         "Rituals involving others (like asking your mother or father the same question repeatedly or wash your clothes an excessive amount)",
//         7),
//     RPChoice.withParams("Other", 8)
//   ]);
//   RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat.withParams([
//     RPImageChoice.withParams(Image.asset('assets/icons/very-sad.png'), 0, "Unbearable"),
//     RPImageChoice.withParams(Image.asset('assets/icons/sad.png'), 0, "Very great discomfort"),
//     RPImageChoice.withParams(Image.asset('assets/icons/ok.png'), 0, "Quite a lot of discomfort"),
//     RPImageChoice.withParams(Image.asset('assets/icons/happy.png'), 0, "A certain discomfort"),
//     RPImageChoice.withParams(Image.asset('assets/icons/very-happy.png'), 0, "Calm"),
//   ]);
//   RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
//     RPChoice.withParams("Yes, I did a compulsion", 0),
//     RPChoice.withParams("Yes, I used another type of safety behavior", 1),
//     RPChoice.withParams("No, I completed the task without any safety behaviors", 2),
//   ]);

//   RPTask get survey => RPOrderedTask("Exposure_SUDS_v1_26_02_2021", [
//         RPInstructionStep(title: "Exposure and response prevention", imagePath: 'assets/icons/survey.png')
//           ..text =
//               "This survey is designed to help you practice fighting OCD.\n\nYour therapist may have taught you about exposure and response prevention. If your therapist has not taught you about exposure and response prevention, then you should not use this app.\n\nExposure means approaching things or situations that you are afraid of a little at a time.\n\nResponse prevention refers to not performing the OCD compulsions or rituals.",
//         RPQuestionStep.withAnswerFormat(
//           "question1",
//           "My therapist has asked to practice exposure at home.",
//           choiceAnswerFormat1,
//         ),
//         RPInstructionStep(title: "Obsession")
//           ..text =
//               "An obsession is a thought or picture that repeatedly pops up in your mind even though you do not want to think about it. The thought can be disturbing, scary, weird or embarrassing",
//         RPQuestionStep.withAnswerFormat(
//           "question2",
//           "I will work on an obsession",
//           choiceAnswerFormat1,
//         ),
//         // TODO: if question2 == 1
//         RPQuestionStep.withAnswerFormat(
//           "question3",
//           "The obsession I will work on is about:",
//           choiceAnswerFormat2,
//         ),

//         RPQuestionStep.withAnswerFormat(
//           "question4",
//           "Describe the obsession that you will work on",
//           RPTextAnswerFormat.withParams(''),
//           optional: true,
//         ),
//         RPInstructionStep(title: "Compulsion")
//           ..text =
//               "A compulsion is something you feel you have to do even though you may know it does not make sense. If you try to resist doing the compulsion, you may feel anxious, frustrated or angry.",
//         RPQuestionStep.withAnswerFormat(
//           "question5",
//           "I will work on a compulsion",
//           choiceAnswerFormat1,
//         ),
//         // TODO: if question5 == 1
//         RPQuestionStep.withAnswerFormat(
//           "question6",
//           "The compulsion I will work on is about:",
//           choiceAnswerFormat3,
//         ),

//         RPQuestionStep.withAnswerFormat(
//             "question7", "Describe the compusion you will work on", RPTextAnswerFormat.withParams(''),
//             optional: true),

//         RPQuestionStep.withAnswerFormat(
//             "question8",
//             "Describe the exposure exercise (how will you work on the obsession or compulsion you described above?):",
//             RPTextAnswerFormat.withParams(''),
//             optional: true),
//         // RPQuestionStep.withAnswerFormat(
//         //   "question9",
//         //   "Write the exposure exercise start time",
//         //   RPDateTimeAnswerFormat.withParams(DateTimeAnswerStyle.TimeOfDay),
//         // ),
//         // RPInstructionStep(title: "")
//         //   ..text =
//         //       "During the exercise, use the “feeling thermometer” below to record how scared or upset you feel. The feeling thermometer is a scale from 0 to 10, in which 0 means no fear or upset and 10 means as scared or upset as you can imagine. Use the feeling thermometer to record how you are feeling just before starting the exposure exercise, after 5, 10 and 15 minutes.\nYour parents or therapist can help you keep track of the time and record how you are feeling.",
//         // RPQuestionStep.withAnswerFormat(
//         //   "question10",
//         //   "Just before exposure",
//         //   _imageChoiceAnswerFormat,
//         // ),
//         // RPQuestionStep.withAnswerFormat(
//         //   "question11",
//         //   "After 5 minutes",
//         //   _imageChoiceAnswerFormat,
//         // ),
//         // RPQuestionStep.withAnswerFormat(
//         //   "question12",
//         //   "After 10 minutes",
//         //   _imageChoiceAnswerFormat,
//         // ),
//         // RPQuestionStep.withAnswerFormat(
//         //   "question13",
//         //   "After 15 minutes",
//         //   _imageChoiceAnswerFormat,
//         // ),
//         RPCompletionStep("completion")
//           ..title = "Well done!"
//           ..text = "Whenever you are ready, go to the task list and start the timed exposure exercise.",
//       ]);
// }

class _ExposureOldSurvey implements Survey {
  String get title => 'Tvangstanker & -handlinger';

  String get description => 'Skriv tvangstanken og/eller tvangshandlingen som du arbejder på';

  Duration get expire => const Duration(days: 2);

  int get minutesToComplete => 10;

  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat = RPImageChoiceAnswerFormat.withParams([
    RPImageChoice.withParams(Image.asset('assets/icons/very-sad.png'), 0, 'Uudholdelig'),
    RPImageChoice.withParams(Image.asset('assets/icons/sad.png'), 0, 'Meget stor ubehag'),
    RPImageChoice.withParams(Image.asset('assets/icons/ok.png'), 0, 'Ret stor ubehag'),
    RPImageChoice.withParams(Image.asset('assets/icons/happy.png'), 0, 'En vis ubehag'),
    RPImageChoice.withParams(Image.asset('assets/icons/very-happy.png'), 0, 'Rolig'),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Nej", 0),
    RPChoice.withParams("Ja", 1),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat2 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("Denne eksponeringsopgave handler ikke om en tvangstanke",
        0), // TODO: if 0 is selected, no other option is available
    RPChoice.withParams("Forurening/kontaminering (snavs, bakterier, sygdomme)", 1),
    RPChoice.withParams("At skade dig selv eller andre (fysisk eller følelsesmæssigt)", 2),
    RPChoice.withParams("At gøre noget du ikke vil (fx stjæle noget)", 3),
    RPChoice.withParams("Voldsomme eller uhyggelige billeder", 4),
    RPChoice.withParams("Sex, graviditet, eller seksualitet", 5),
    RPChoice.withParams("At samle ting eller miste noget", 6),
    RPChoice.withParams(
        "Magiske/overtroiske tanker eller handlinger (fx ykketal/uheldstal, at blive forvandlet)", 7),
    RPChoice.withParams(
        "Bekymring for at have en sygdom eller at en kropsdel eller udseende er mærkeligt eller grimt ud", 8),
    RPChoice.withParams(
        "Frygt for at fornærme religiøse objekter eller optaget af, hvad der er rigtigt/forkert og moral", 9),
    RPChoice.withParams("Symmetri og orden", 10),
    RPChoice.withParams("Behov for at vide eller huske", 11),
    RPChoice.withParams("Frygt for at sige visse ord", 12),
    RPChoice.withParams("Frygt for ikke præcist at sige det rigtige", 13),
    RPChoice.withParams("Påtrængende billeder, forestillinger, lyde, ord, musik eller tal", 14),
    RPChoice.withParams(
        "Ubehagelig fornemmelse af, at det ikke føles rigtigt, føles ufuldstændigt eller tomhedsfornemmelse, når ritualer ikke udføres på en bestemt måde",
        15),
    RPChoice.withParams("Andet", 16), // TODO: textbox to describe
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("Denne eksponeringsopgave handler ikke om en tvangstanke",
        0), // TODO: if 0 is selected, no other option is available
    RPChoice.withParams("Renlighed eller rengøring", 1),
    RPChoice.withParams("Kontrollere eller tjekke", 2),
    RPChoice.withParams("Gentage", 3),
    RPChoice.withParams("Tælle ting", 4),
    RPChoice.withParams("Ordne ting eller søge at få ting ens", 5),
    RPChoice.withParams("Samle ting eller svært ved at smide ting væk", 6),
    RPChoice.withParams("Magisk/overtroisk adfærd", 7),
    RPChoice.withParams(
        "Behov for at involvere andre i et ritual, beroligende forsikringer eller få dine forældrene til at medvirke i eller udføre dine kontroltvang",
        8),
    RPChoice.withParams(
        "Mentale ritualer (fremsige fraser eller remser eller gennemgå noget, som man har gjort, sagt eller tænkt igen og igen i tankerne)",
        9),
    RPChoice.withParams("Berette, spørge, bekende", 10),
    RPChoice.withParams("Ritualiseret spisemønster", 11),
    RPChoice.withParams("Skrive lister", 12),
    RPChoice.withParams("Føle, banke, gnide", 13),
    RPChoice.withParams("Gøre ting, indtil det føles rigtigt", 14),
    RPChoice.withParams("Ritualer, der involverer blinken eller stirren", 15),
    RPChoice.withParams("Trække hår ud", 16),
    RPChoice.withParams("Anden selvskadende eller selvdestruktiv adfærd", 17),
    RPChoice.withParams("Andet", 18), // TODO: textbox to describe
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Ja, jeg udført en tvangshandling", 0),
    RPChoice.withParams("Ja, udført en anden slags sikkerhedsadfærd", 1),
    RPChoice.withParams("Nej", 2),
  ]);

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPQuestionStep.withAnswerFormat(
          "questionStep1ID",
          "Min behandler har givet mig eksponering og respons præventions øvelser for til hjemmearbejde.",
          choiceAnswerFormat1,
        ),
        RPQuestionStep.withAnswerFormat(
          "questionStep2ID",
          "Tvangstanken jeg vil arbejde med nu, handler om:",
          choiceAnswerFormat2,
        ),
        RPQuestionStep.withAnswerFormat(
          "questionStep3ID",
          "Tvangshandlingen jeg vil arbejde med nu, handler om:",
          choiceAnswerFormat3,
        ),
        RPQuestionStep.withAnswerFormat(
          "questionStep4ID",
          "Beskriv eksponeringsøvelsen (hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen):",
          RPTextAnswerFormat.withParams(''),
        ),
        RPQuestionStep.withAnswerFormat(
          "questionStep5ID",
          "Skriv tiden når du starter med eksponeringsøvelsen:",
          RPDateTimeAnswerFormat.withParams(DateTimeAnswerStyle.TimeOfDay),
        ),
        RPInstructionStep(title: "Tvangstanker og -handlinger")
          ..text =
              "Skriv hvor meget ubehag eller angst du oplever lige inden øvelsen og efter 5, 10, og 15 minutter ved hjælp af en skala fra 0–10 på (0 = rolig, ingen angst, 10 = Maksimal angst/ uro). Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned.",
        RPQuestionStep.withAnswerFormat(
          "exposure_1",
          "Hvor megen ubehag eller angst oplever du lige nu?",
          _imageChoiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "exposure_2",
          "Hvor megen ubehag eller angst oplever du efter 5 minutter?",
          _imageChoiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "exposure_3",
          "Hvor megen ubehag eller angst oplever du efter 10 minutter?",
          _imageChoiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "exposure_4",
          "Hvor megen ubehag eller angst oplever du efter 15 minutter?",
          _imageChoiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "questionStep6ID",
          "Jeg har brugt sikkerhedsadfærd under øvelsen:",
          choiceAnswerFormat6,
        ),
        RPCompletionStep("completion")
          ..title = "Godt gået!"
          ..text = "Du har arbejdet på at forstyrre på OCD’en.",

        /* RPInstructionStep(title: "Tvangstanker og -handlinger")
          ..text = "I denne øvelse skal du først notere en tvangstanke eller -handling som du arbejder på. "
              "Derefter skal du beskrive hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen.\n\n"
              "Når du så starter med at arbejde med øvelsen, så skal du notere hvor meget "
              "ubehag eller angst du oplever undervejs.\n\n"
              "Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned.",
        RPQuestionStep.withAnswerFormat(
            "thought",
            "Skriv tvangstanken og/eller tvangshandlingen som du arbejder på",
            RPIntegerAnswerFormat.withParams(0, 200)),
        RPQuestionStep.withAnswerFormat(
            "exercise",
            "Beskriv eksponeringsøvelsen, dvs. hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen",
            RPIntegerAnswerFormat.withParams(0, 200)),
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
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("Alone", 1),
    RPChoice.withParams("With my other children who are not part of the study", 2),
    RPChoice.withParams("With my child who is part of the study", 3),
    RPChoice.withParams("With the child's other parent", 3),
    RPChoice.withParams("With my friends", 4),
    RPChoice.withParams("With others", 5),
  ]);

  final RPChoiceAnswerFormat _parnasAnswerFormat =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Much", 5),
    RPChoice.withParams("Pretty much", 4),
    RPChoice.withParams("Moderate", 3),
    RPChoice.withParams("A little", 2),
    RPChoice.withParams("Not at all", 1),
  ]);

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPInstructionStep(title: "Where are you?")
          ..text = "In the following question, please indicate where you are, and who you are with.",
        RPQuestionStep.withAnswerFormat(
          "location",
          "Right now I am...",
          _locationChoices,
        ),
        RPInstructionStep(title: "International Positive and Negative Affect Schedule")
          ..text = "In the following questions, please indicate how "
              "much each of the stated emotions is affecting you at the moment.",
        RPQuestionStep.withAnswerFormat(
          "parnas_1",
          "Upset",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_2",
          "Hostile",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_3",
          "Alert",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_4",
          "Ashamed",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_5",
          "Inspired",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_6",
          "Nervous",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_7",
          "Determined",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_8",
          "Attentive",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_9",
          "Afraid",
          _parnasAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "parnas_10",
          "Active",
          _parnasAnswerFormat,
        ),
      ]);
}

class _WHO5Survey implements Survey {
  String get title => "WHO5 Well-Being";
  String get description => "A short 5-item survey on your well-being.";
  int get minutesToComplete => 1;
  Duration get expire => const Duration(days: 5);

  static List<RPChoice> _choices = [
    RPChoice.withParams("All of the time", 5),
    RPChoice.withParams("Most of the time", 4),
    RPChoice.withParams("More than half of the time", 3),
    RPChoice.withParams("Less than half of the time", 2),
    RPChoice.withParams("Some of the time", 1),
    RPChoice.withParams("At no time", 0),
  ];

  final RPChoiceAnswerFormat _choiceAnswerFormat =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, _choices);

  RPTask get survey => RPOrderedTask("who5_survey", [
        RPInstructionStep(title: "WHO Well-Being Index")
          ..text =
              "Please indicate for each of the following five statements which is closest to how you have been feeling over the last two weeks. "
                  "Notice that higher numbers mean better well-being.\n\n"
                  "Example: If you have felt cheerful and in good spirits more than half of the time during the last two weeks, "
                  "select the box with the label 'More than half of the time'.",
        RPQuestionStep.withAnswerFormat(
          "who5_1",
          "I have felt cheerful and in good spirits",
          _choiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "who5_2",
          "I have felt calm and relaxed",
          _choiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "who5_3",
          "I have felt active and vigorous",
          _choiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "who5_4",
          "I woke up feeling fresh and rested",
          _choiceAnswerFormat,
        ),
        RPQuestionStep.withAnswerFormat(
          "who5_5",
          "My daily life has been filled with things that interest me",
          _choiceAnswerFormat,
        ),
        RPCompletionStep("who5_ompletion")
          ..title = "Finished"
          ..text = "Thank you for filling out the survey!",
      ]);
}

class _DemographicSurvey implements Survey {
  String get title => "Demographics";
  String get description => "A short 4-item survey on your background.";
  int get minutesToComplete => 2;
  Duration get expire => const Duration(days: 4);

  final RPChoiceAnswerFormat _sexChoices = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Femal", 1),
    RPChoice.withParams("Male", 2),
    RPChoice.withParams("Other", 3),
    RPChoice.withParams("Prefer not to say", 4),
  ]);

  final RPChoiceAnswerFormat _ageChoices = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Under 20", 1),
    RPChoice.withParams("20-29", 2),
    RPChoice.withParams("30-39", 3),
    RPChoice.withParams("40-49", 4),
    RPChoice.withParams("50-59", 5),
    RPChoice.withParams("60-69", 6),
    RPChoice.withParams("70-79", 7),
    RPChoice.withParams("80-89", 8),
    RPChoice.withParams("90 and above", 9),
    RPChoice.withParams("Prefer not to say", 10),
  ]);

  final RPChoiceAnswerFormat _medicalChoices =
      RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("None", 1),
    RPChoice.withParams("Asthma", 2),
    RPChoice.withParams("Cystic fibrosis", 3),
    RPChoice.withParams("COPD/Emphysema", 4),
    RPChoice.withParams("Pulmonary fibrosis", 5),
    RPChoice.withParams("Other lung disease  ", 6),
    RPChoice.withParams("High Blood Pressure", 7),
    RPChoice.withParams("Angina", 8),
    RPChoice.withParams("Previous stroke or Transient ischaemic attack  ", 9),
    RPChoice.withParams("Valvular heart disease", 10),
    RPChoice.withParams("Previous heart attack", 11),
    RPChoice.withParams("Other heart disease", 12),
    RPChoice.withParams("Diabetes", 13),
    RPChoice.withParams("Cancer", 14),
    RPChoice.withParams("Previous organ transplant  ", 15),
    RPChoice.withParams("HIV or impaired immune system  ", 16),
    RPChoice.withParams("Other long-term condition  ", 17),
    RPChoice.withParams("Prefer not to say", 18),
  ]);

  final RPChoiceAnswerFormat _smokeChoices = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, [
    RPChoice.withParams("Never smoked", 1),
    RPChoice.withParams("Ex-smoker", 2),
    RPChoice.withParams("Current smoker (less than once a day", 3),
    RPChoice.withParams("Current smoker (1-10 cigarettes pr day", 4),
    RPChoice.withParams("Current smoker (11-20 cigarettes pr day", 5),
    RPChoice.withParams("Current smoker (21+ cigarettes pr day", 6),
    RPChoice.withParams("Prefer not to say", 7),
  ]);

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPQuestionStep.withAnswerFormat(
          "demo_1",
          "Which is your biological sex?",
          _sexChoices,
        ),
        RPQuestionStep.withAnswerFormat(
          "demo_2",
          "How old are you?",
          _ageChoices,
        ),
        RPQuestionStep.withAnswerFormat(
          "demo_3",
          "Do you have any of these medical conditions?",
          _medicalChoices,
        ),
        RPQuestionStep.withAnswerFormat(
          "demo_4",
          "Do you, or have you, ever smoked (including e-cigarettes)?",
          _smokeChoices,
        ),
      ]);
}

class _SymptomsSurvey implements Survey {
  String get title => "Daily Symptoms";
  String get description => "A short 1-item survey on your daily symptoms.";
  int get minutesToComplete => 1;
  Duration get expire => const Duration(days: 1);

  RPChoiceAnswerFormat _symptomsChoices = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, [
    RPChoice.withParams("None", 1),
    RPChoice.withParams("Fever (warmer than usual)", 2),
    RPChoice.withParams("Dry cough", 3),
    RPChoice.withParams("Wet cough", 4),
    RPChoice.withParams("Sore throat, runny or blocked nose", 5),
    RPChoice.withParams("Loss of taste and smell", 6),
    RPChoice.withParams("Difficulty breathing or feeling short of breath", 7),
    RPChoice.withParams("Tightness in your chest", 8),
    RPChoice.withParams("Dizziness, confusion or vertigo", 9),
    RPChoice.withParams("Headache", 10),
    RPChoice.withParams("Muscle aches", 11),
    RPChoice.withParams("Chills", 12),
    RPChoice.withParams("Prefer not to say", 13),
  ]);

  RPTask get survey => RPOrderedTask("symptoms_survey", [
        RPQuestionStep.withAnswerFormat(
          "sym_1",
          "Do you have any of the following symptoms today?",
          _symptomsChoices,
        ),
      ]);
}
