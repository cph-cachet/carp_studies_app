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

class _TrustScaleSurvey implements Survey {
  String get title => 'Trust in the Mobile App';

  String get description =>
      'We would like to know what it was like for you to use the mobile app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Strongly disagree", value: 0),
        RPChoice(text: "Slightly disagree", value: 1),
        RPChoice(text: "Agree", value: 2),
        RPChoice(text: "Strongly agree", value: 3),
      ]);

  RPTask get survey => RPOrderedTask("User Experience with App", [
        RPInstructionStep("ux_app_1",
            title: "", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "We would like to know what it was like for you to use the mobile app.\n\nPlease read each statement and chose the number (0, 1, 2, or 3) that best describes how you feel.",
        RPQuestionStep(
          "question1",
          title:
              "I believe that there could be negative consequences when using this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question2",
          title: "I feel I must be cautious when using this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question3",
          title: "It is risky to interact with this mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question4",
          title:
              "I think that this mobile app is competent and effective in supporting the research study",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question5",
          title:
              "I think that this mobile app performs its role as a tool for research very well",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question6",
          title:
              "I believe that this mobile app has all the functionalities I would expect from a research study app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question7",
          title:
              "When I use this mobile app, I feel I can count on it completely",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question8",
          title:
              "I can always rely on the mobile app for guidance and assistance",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question9",
          title:
              "I can trust the information presented to me by the mobile app",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question10",
          title: "I believe that the mobile app provides me with benefits",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question11",
          title:
              "I believe that the mobile app will show me how to get support if I need help",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question12",
          title:
              "I believe that the mobile app attends to my needs and preferences",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question13",
          title:
              "Is there anything else you would like to tell us about your experience?",
          answerFormat: RPTextAnswerFormat(hintText: ''),
          optional: true,
        ),
        RPCompletionStep("completion")
          ..title =
              "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _InformedConsentSurvey implements Survey {
  String get title => 'Evaluation of the mobile app consent';

  String get description =>
      'We would like to know your experience with the informed consent'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 4;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely not understandable.", value: 0),
        RPChoice(text: "Mostly not understandable.", value: 1),
        RPChoice(text: "Mostly understandable.", value: 2),
        RPChoice(text: "Extremely understandable.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely easy to navigate.", value: 0),
        RPChoice(text: "Mostly easy to navigate.", value: 1),
        RPChoice(text: "Mostly difficult to navigate.", value: 2),
        RPChoice(text: "Extremely difficult to navigate.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely valuable.", value: 0),
        RPChoice(text: "Mostly valuable.", value: 1),
        RPChoice(text: "Mostly inferior.", value: 2),
        RPChoice(text: "Extremely inferior.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely boring.", value: 0),
        RPChoice(text: "Mostly boring.", value: 1),
        RPChoice(text: "Mostly exciting.", value: 2),
        RPChoice(text: "Extremely exciting.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely not interesting.", value: 0),
        RPChoice(text: "Mostly not interesting.", value: 1),
        RPChoice(text: "Mostly interesting.", value: 2),
        RPChoice(text: "Extremely interesting.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely fast.", value: 0),
        RPChoice(text: "Mostly fast.", value: 1),
        RPChoice(text: "Mostly slow.", value: 2),
        RPChoice(text: "Extremely slow.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely complicated.", value: 0),
        RPChoice(text: "Mostly complicated.", value: 1),
        RPChoice(text: "Mostly  easy to understand.", value: 2),
        RPChoice(text: "Extremely  easy to understand.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely motivating.", value: 0),
        RPChoice(text: "Mostly motivating.", value: 1),
        RPChoice(text: "Mostly demotivating.", value: 2),
        RPChoice(text: "Extremely demotivating.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat9 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely inefficient.", value: 0),
        RPChoice(text: "Mostly inefficient.", value: 1),
        RPChoice(text: "Mostly efficient.", value: 2),
        RPChoice(text: "Extremely efficient.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat10 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely clear.", value: 0),
        RPChoice(text: "Mostly clear.", value: 1),
        RPChoice(text: "Mostly confusing.", value: 2),
        RPChoice(text: "Extremely confusing.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat11 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely impractical.", value: 0),
        RPChoice(text: "Mostly impractical.", value: 1),
        RPChoice(text: "Mostly practical.", value: 2),
        RPChoice(text: "Extremely practical.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat12 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely organized.", value: 0),
        RPChoice(text: "Mostly organized.", value: 1),
        RPChoice(text: "Mostly cluttered.", value: 2),
        RPChoice(text: "Extremely cluttered.", value: 3),
      ]);
  RPTask get survey => RPOrderedTask("Informed consent", [
        RPInstructionStep("ux_ic_1",
            title: "", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "Please make your evaluation of the app informed consent now.\n\nThe questionnaire consists of attributes that may apply to the app informed consent. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!",
        RPQuestionStep(
          "question1",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question2",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          "question3",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          "question4",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          "question5",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          "question6",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          "question7",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          "question8",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat8,
        ),
        RPQuestionStep(
          "question9",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat9,
        ),
        RPQuestionStep(
          "question10",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat10,
        ),
        RPQuestionStep(
          "question11",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat11,
        ),
        RPQuestionStep(
          "question11",
          title: "The app informed consent was:",
          answerFormat: choiceAnswerFormat12,
        ),
        RPCompletionStep("completion")
          ..title =
              "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _AppUXSurvey implements Survey {
  String get title => 'User Experience with the Mobile App';

  String get description =>
      'We would like to know your experience with the app'; // TODO

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 2;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely obstructive.", value: 0),
        RPChoice(text: "Mostly obstructive.", value: 1),
        RPChoice(text: "Mostly supportive.", value: 2),
        RPChoice(text: "Extremely supportive.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely complicated.", value: 0),
        RPChoice(text: "Mostly complicated.", value: 1),
        RPChoice(text: "Mostly easy.", value: 2),
        RPChoice(text: "Extremely easy.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely inefficient.", value: 0),
        RPChoice(text: "Mostly inefficient.", value: 1),
        RPChoice(text: "Mostly efficient.", value: 2),
        RPChoice(text: "Extremely efficient.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely confusing.", value: 0),
        RPChoice(text: "Mostly confusing.", value: 1),
        RPChoice(text: "Mostly clear.", value: 2),
        RPChoice(text: "Extremely clear.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat5 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely boring.", value: 0),
        RPChoice(text: "Mostly boring.", value: 1),
        RPChoice(text: "Mostly exciting.", value: 2),
        RPChoice(text: "Extremely exciting.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely not interesting.", value: 0),
        RPChoice(text: "Mostly not interesting.", value: 1),
        RPChoice(text: "Mostly interesting.", value: 2),
        RPChoice(text: "Extremely interesting.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat7 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely conventional.", value: 0),
        RPChoice(text: "Mostly conventional.", value: 1),
        RPChoice(text: "Mostly inventive.", value: 2),
        RPChoice(text: "Extremely inventive.", value: 3),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat8 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Extremely usual.", value: 0),
        RPChoice(text: "Mostly usual.", value: 1),
        RPChoice(text: "Mostly leading edge.", value: 2),
        RPChoice(text: "Extremely leading edge.", value: 3),
      ]);

  RPTask get survey => RPOrderedTask("User Experience with App", [
        RPInstructionStep("ux_app_2",
            title: "", imagePath: 'assets/icons/smartphone.png')
          ..text =
              "Please make your evaluation of this mobile app now.\n\nThe questionnaire consists of attributes that may apply to the app. You can express your agreement with the attributes by ticking the option that most closely reflects your impression.\n\nIt is your personal opinion that counts. Please remember: there is no wrong or right answer!",
        RPQuestionStep(
          "question1",
          title: "The app is:",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "question2",
          title: "The app is:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          "question3",
          title: "The app is:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          "question4",
          title: "The app is:",
          answerFormat: choiceAnswerFormat4,
        ),
        RPQuestionStep(
          "question5",
          title: "The app is:",
          answerFormat: choiceAnswerFormat5,
        ),
        RPQuestionStep(
          "question6",
          title: "The app is:",
          answerFormat: choiceAnswerFormat6,
        ),
        RPQuestionStep(
          "question7",
          title: "The app is:",
          answerFormat: choiceAnswerFormat7,
        ),
        RPQuestionStep(
          "question8",
          title: "The app is:",
          answerFormat: choiceAnswerFormat8,
        ),
        RPCompletionStep("completion")
          ..title =
              "Thank you for completing the product evaluation questionnaire!"
          ..text = " "
      ]);
}

class _EcologicalParentsSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "No", value: 0),
        RPChoice(text: "Yes", value: 1),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Very slightly or not at all", value: 1),
        RPChoice(text: "A little", value: 2),
        RPChoice(text: "Moderately", value: 3),
        RPChoice(text: "Quite a bit", value: 4),
        RPChoice(text: "Extremely", value: 5),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "I am alone", value: 0),
        RPChoice(
            text: "I am with my child who is participating in the study",
            value: 1),
        RPChoice(
            text:
                "I am with my child(ren) who is/are not participating in the study",
            value: 2),
        RPChoice(
            text: "I am with my participating child’s other parent)", value: 3),
        RPChoice(text: "I am with my friends", value: 4),
        RPChoice(text: "I am with others we have not mentioned", value: 5)
      ]);

  RPTask get survey => RPOrderedTask(
        "Ecological Momentary Assessment Child",
        [
          RPQuestionStep(
            "question1",
            title: "Are you alone?",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep("ema_instrux", title: "")
            ..text =
                "Indicate the extent you have felt this way over the past week.",
          RPQuestionStep(
            "question7",
            title: "Upset",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question8",
            title: "Hostile",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question9",
            title: "Alert",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question10",
            title: "Ashamed",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question11",
            title: "Inspired",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question12",
            title: "Nervous",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question13",
            title: "Determined",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question14",
            title: "Attentive",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question15",
            title: "Afraid",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "questio16",
            title: "Active",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _EcologicalSurvey implements Survey {
  String get title => 'How are you feeling right now?';

  String get description => 'We would like to know your current mood'; // TODO

  Duration get expire => const Duration(days: 1);

  int get minutesToComplete => 10;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "No", value: 0),
        RPChoice(text: "Yes", value: 1),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Very slightly or not at all", value: 1),
        RPChoice(text: "A little", value: 2),
        RPChoice(text: "Moderately", value: 3),
        RPChoice(text: "Quite a bit", value: 4),
        RPChoice(text: "Extremely", value: 5),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "I am alone", value: 0),
        RPChoice(
            text:
                "I am with my mother/father who is also participating in the study",
            value: 1),
        RPChoice(
            text:
                "I am  with my other parent who is not participating in the study",
            value: 2),
        RPChoice(text: "I am with my sister(s) and/ or brother(s)", value: 3),
        RPChoice(text: "I am with my friends", value: 4),
        RPChoice(text: "I am with others we have not mentioned", value: 5)
      ]);

  RPTask get survey => RPOrderedTask(
        "Ecological Momentary Assessment Child",
        [
          RPQuestionStep(
            "question1",
            title: "Are you alone?",
            answerFormat: choiceAnswerFormat3,
          ),
          RPInstructionStep("ema_child_instrux",
              title: "We would like to know your current mood",
              imagePath: 'assets/icons/survey.png')
            ..text =
                "Below are a list of different feelings and emotions.\n\nPlease read each feeling and choose the option that best matches how much you feel each feeling right now.",
          RPQuestionStep(
            "question7",
            title: "Miserable",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question8",
            title: "Mad",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question9",
            title: "Lively",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question10",
            title: "Sad",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question11",
            title: "Joyful",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question12",
            title: "Scared",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question13",
            title: "Cheerful",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question14",
            title: "Happy",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question15",
            title: "Afraid",
            answerFormat: choiceAnswerFormat2,
          ),
          RPQuestionStep(
            "question16",
            title: "Proud",
            answerFormat: choiceAnswerFormat2,
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _PatientParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description =>
      "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Strongly disagree", value: 0),
        RPChoice(text: "Slightly disagree", value: 1),
        RPChoice(text: "Agree", value: 2),
        RPChoice(text: "Strongly agree", value: 3),
      ]);

  RPTask get survey => RPOrderedTask(
        "PATIENT_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        [
          RPInstructionStep("pp_instrux",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep(
            "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question13",
            title:
                "I remembered to push the button on the wristband each time my child’s OCD bothered me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _PatientSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description =>
      "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Strongly disagree", value: 0),
        RPChoice(text: "Slightly disagree", value: 1),
        RPChoice(text: "Agree", value: 2),
        RPChoice(text: "Strongly agree", value: 3),
      ]);

  RPTask get survey => RPOrderedTask(
        "PATIENT_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        [
          RPInstructionStep("bio_sensor_child",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep(
            "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question13",
            title:
                "I remembered to push the button on the wristband every time OCD was bothering me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _ControlParentsSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description =>
      "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Strongly disagree", value: 0),
        RPChoice(text: "Slightly disagree", value: 1),
        RPChoice(text: "Agree", value: 2),
        RPChoice(text: "Strongly agree", value: 3),
      ]);

  RPTask get survey => RPOrderedTask(
        "KONTROL_Brugerundersøgelse_biosensor_forældre_v1_29-10-2020",
        [
          RPInstructionStep("control_instrux",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep(
            "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question13",
            title:
                "I remembered to push the button on the wristband each time my child’s OCD bothered me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _ControlSurvey implements Survey {
  String get title => "Wristband with biosensor";

  String get description =>
      "We would like to know what it was like for you to wear the wristband.";
  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 5;

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Strongly disagree", value: 0),
        RPChoice(text: "Slightly disagree", value: 1),
        RPChoice(text: "Agree", value: 2),
        RPChoice(text: "Strongly agree", value: 3),
      ]);

  RPTask get survey => RPOrderedTask(
        "KONTROL_Brugerundersøgelse_biosensor_barn_v1_29-10-2020",
        [
          RPInstructionStep("contro_bio_instrux",
              title: "Wristband with biosensor",
              imagePath: 'assets/icons/wristwatch.png')
            ..text =
                "We would like to know what it was like for you to wear the wristband.\n\nPlease read each statement and chose the option that best describes how you feel.",
          RPQuestionStep(
            "question1",
            title: "I like how the wristband looks.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question2",
            title: "The wristband looks too big.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question3",
            title: "I was embarrassed to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question4",
            title: "The wristband looks cool.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question5",
            title: "The wristband attracted too much attention.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question6",
            title: "The wristband was comfortable.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question7",
            title: "The wristband fit well around my wrist.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question8",
            title: "The wristband was easy to use.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question9",
            title: "The wristband was easy to charge.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question10",
            title: "I often forgot to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question11",
            title: "I wanted to wear the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question12",
            title: "It was irritating to push the button on the wristband.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question13",
            title:
                "I remembered to push the button on the wristband every time OCD was bothering me.",
            answerFormat: choiceAnswerFormat1,
          ),
          RPQuestionStep(
            "question14",
            title:
                "Is there anything else you would like to tell us about your experience wearing the wristband?",
            answerFormat: RPTextAnswerFormat(),
            optional: true,
          ),
          RPCompletionStep("completion")
            ..title = "Well done!"
            ..text = " ",
        ],
      );
}

class _ExposureSurvey implements Survey {
  String get title => "Weekly exposure and response prevention";

  String get description =>
      'Describe the obsession and/or the compulsion you are working on';

  Duration get expire => const Duration(days: 7);

  int get minutesToComplete => 10; // TODO: review time

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "No", value: 0),
        RPChoice(text: "Yes", value: 1),
      ]);
  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Contamination (dirt, bacteria, sickness)", value: 0),
        RPChoice(
            text: "Hurting myself or others (physically or emotionally)",
            value: 1),
        RPChoice(text: "Sex, pregnancy or sexuality", value: 2),
        RPChoice(
            text: "Collecting things or fear of losing something", value: 3),
        RPChoice(
            text: "Magical thoughts or superstitions (un/lucky number)",
            value: 4),
        RPChoice(
            text:
                "My body (worry that I have a disease or that I or one of my body parts looks wrong)",
            value: 5),
        RPChoice(
            text:
                "Fear of offending a religous object (god or satan) or morality (right and wrong)",
            value: 6),
        RPChoice(
            text:
                "Ordering and arranging (things need to be arranged in a certain way or arranging things in a certain order.)",
            value: 7),
        RPChoice(text: "Other", value: 8),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Washing or cleaning", value: 0),
        RPChoice(
            text: "Checking (like checking the doors are locked)", value: 1),
        RPChoice(
            text:
                "Repeating rituals (like turning on and off the lights repeatedly)",
            value: 2),
        RPChoice(text: "Counting", value: 3),
        RPChoice(text: "Arranging or putting this in order", value: 4),
        RPChoice(text: "Collecting or saving things", value: 5),
        RPChoice(
            text:
                "Superstitious behaviors (like avoiding stepping on cracks in the sidewalk to avoid something bad from happening)",
            value: 6),
        RPChoice(
            text:
                "Rituals involving others (like asking your mother or father the same question repeatedly or wash your clothes an excessive amount)",
            value: 7),
        RPChoice(text: "Other", value: 8)
      ]);
  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat =
      RPImageChoiceAnswerFormat(choices: [
    RPImageChoice(
        image: Image.asset('assets/icons/very-sad.png'),
        value: 0,
        description: "Unbearable"),
    RPImageChoice(
        image: Image.asset('assets/icons/sad.png'),
        value: 0,
        description: "Very great discomfort"),
    RPImageChoice(
        image: Image.asset('assets/icons/ok.png'),
        value: 0,
        description: "Quite a lot of discomfort"),
    RPImageChoice(
        image: Image.asset('assets/icons/happy.png'),
        value: 0,
        description: "A certain discomfort"),
    RPImageChoice(
        image: Image.asset('assets/icons/very-happy.png'),
        value: 0,
        description: "Calm"),
  ]);
  RPChoiceAnswerFormat choiceAnswerFormat4 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Yes, I did a compulsion", value: 0),
        RPChoice(text: "Yes, I used another type of safety behavior", value: 1),
        RPChoice(
            text: "No, I completed the task without any safety behaviors",
            value: 2),
      ]);

  RPTask get survey => RPOrderedTask("Exposure_SUDS_v1_26_02_2021", [
        RPInstructionStep("",
            title: "Exposure and response prevention",
            imagePath: 'assets/icons/survey.png')
          ..text =
              "This survey is designed to help you practice fighting OCD.\n\nYour therapist may have taught you about exposure and response prevention. If your therapist has not taught you about exposure and response prevention, then you should not use this app.\n\nExposure means approaching things or situations that you are afraid of a little at a time.\n\nResponse prevention refers to not performing the OCD compulsions or rituals.",
        RPQuestionStep(
          "question1",
          title: "My therapist has asked to practice exposure at home.",
          answerFormat: choiceAnswerFormat1,
        ),
        RPInstructionStep("", title: "Obsession")
          ..text =
              "An obsession is a thought or picture that repeatedly pops up in your mind even though you do not want to think about it. The thought can be disturbing, scary, weird or embarrassing",
        RPQuestionStep(
          "question2",
          title: "I will work on an obsession",
          answerFormat: choiceAnswerFormat1,
        ),
        // TODO: if question2 == 1
        RPQuestionStep(
          "question3",
          title: "The obsession I will work on is about:",
          answerFormat: choiceAnswerFormat2,
        ),

        RPQuestionStep(
          "question4",
          title: "Describe the obsession that you will work on",
          answerFormat: RPTextAnswerFormat(),
        ),
        RPInstructionStep("", title: "Compulsion")
          ..text =
              "A compulsion is something you feel you have to do even though you may know it does not make sense. If you try to resist doing the compulsion, you may feel anxious, frustrated or angry.",
        RPQuestionStep(
          "question5",
          title: "I will work on a compulsion",
          answerFormat: choiceAnswerFormat1,
        ),
        // TODO: if question5 == 1
        RPQuestionStep(
          "question6",
          title: "The compulsion I will work on is about:",
          answerFormat: choiceAnswerFormat3,
        ),

        RPQuestionStep("question7",
            title: "Describe the compusion you will work on",
            answerFormat: RPTextAnswerFormat(),
            optional: true),

        RPQuestionStep("question8",
            title:
                "Describe the exposure exercise (how will you work on the obsession or compulsion you described above?):",
            answerFormat: RPTextAnswerFormat(),
            optional: true),
        // RPQuestionStep(
        //   "question9",
        //   "Write the exposure exercise start time",
        //   RPDateTimeAnswerFormat(text: DateTimeAnswerStyle.TimeOfDay),
        // ),
        // RPInstructionStep(title: "")
        //   ..text =
        //       "During the exercise, use the “feeling thermometer” below to record how scared or upset you feel. The feeling thermometer is a scale from 0 to 10, in which 0 means no fear or upset and 10 means as scared or upset as you can imagine. Use the feeling thermometer to record how you are feeling just before starting the exposure exercise, after 5, 10 and 15 minutes.\nYour parents or therapist can help you keep track of the time and record how you are feeling.",
        // RPQuestionStep(
        //   "question10",
        //   "Just before exposure",
        //   _imageChoiceAnswerFormat,
        // ),
        // RPQuestionStep(
        //   "question11",
        //   "After 5 minutes",
        //   _imageChoiceAnswerFormat,
        // ),
        // RPQuestionStep(
        //   "question12",
        //   "After 10 minutes",
        //   _imageChoiceAnswerFormat,
        // ),
        // RPQuestionStep(
        //   "question13",
        //   "After 15 minutes",
        //   _imageChoiceAnswerFormat,
        // ),
        RPCompletionStep("completion")
          ..title = "Well done!"
          ..text =
              "Whenever you are ready, go to the task list and start the timed exposure exercise.",
      ]);
}

class _ExposureOldSurvey implements Survey {
  String get title => 'Tvangstanker & -handlinger';

  String get description =>
      'Skriv tvangstanken og/eller tvangshandlingen som du arbejder på';

  Duration get expire => const Duration(days: 2);

  int get minutesToComplete => 10;

  RPImageChoiceAnswerFormat _imageChoiceAnswerFormat =
      RPImageChoiceAnswerFormat(choices: [
    RPImageChoice(
        image: Image.asset('assets/icons/very-sad.png'),
        value: 0,
        description: 'Uudholdelig'),
    RPImageChoice(
        image: Image.asset('assets/icons/sad.png'),
        value: 0,
        description: 'Meget stor ubehag'),
    RPImageChoice(
        image: Image.asset('assets/icons/ok.png'),
        value: 0,
        description: 'Ret stor ubehag'),
    RPImageChoice(
        image: Image.asset('assets/icons/happy.png'),
        value: 0,
        description: 'En vis ubehag'),
    RPImageChoice(
        image: Image.asset('assets/icons/very-happy.png'),
        value: 0,
        description: 'Rolig'),
  ]);

  RPChoiceAnswerFormat choiceAnswerFormat1 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Nej", value: 0),
        RPChoice(text: "Ja", value: 1),
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat2 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(
            text: "Denne eksponeringsopgave handler ikke om en tvangstanke",
            value: 0), // TODO: if 0 is selected, no other option is available
        RPChoice(
            text: "Forurening/kontaminering (snavs, bakterier, sygdomme)",
            value: 1),
        RPChoice(
            text:
                "At skade dig selv eller andre (fysisk eller følelsesmæssigt)",
            value: 2),
        RPChoice(text: "At gøre noget du ikke vil (fx stjæle noget)", value: 3),
        RPChoice(text: "Voldsomme eller uhyggelige billeder", value: 4),
        RPChoice(text: "Sex, graviditet, eller seksualitet", value: 5),
        RPChoice(text: "At samle ting eller miste noget", value: 6),
        RPChoice(
            text:
                "Magiske/overtroiske tanker eller handlinger (fx lykketal/uheldstal, at blive forvandlet)",
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
        RPChoice(
            text:
                "Påtrængende billeder, forestillinger, lyde, ord, musik eller tal",
            value: 14),
        RPChoice(
            text:
                "Ubehagelig fornemmelse af, at det ikke føles rigtigt, føles ufuldstændigt eller tomhedsfornemmelse, når ritualer ikke udføres på en bestemt måde",
            value: 15),
        RPChoice(text: "Andet", value: 16), // TODO: textbox to describe
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat3 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(
            text: "Denne eksponeringsopgave handler ikke om en tvangstanke",
            value: 0), // TODO: if 0 is selected, no other option is available
        RPChoice(text: "Renlighed eller rengøring", value: 1),
        RPChoice(text: "Kontrollere eller tjekke", value: 2),
        RPChoice(text: "Gentage", value: 3),
        RPChoice(text: "Tælle ting", value: 4),
        RPChoice(text: "Ordne ting eller søge at få ting ens", value: 5),
        RPChoice(
            text: "Samle ting eller svært ved at smide ting væk", value: 6),
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
        RPChoice(
            text: "Ritualer, der involverer blinken eller stirren", value: 15),
        RPChoice(text: "Trække hår ud", value: 16),
        RPChoice(
            text: "Anden selvskadende eller selvdestruktiv adfærd", value: 17),
        RPChoice(text: "Andet", value: 18), // TODO: textbox to describe
      ]);

  RPChoiceAnswerFormat choiceAnswerFormat6 = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Ja, jeg udført en tvangshandling", value: 0),
        RPChoice(text: "Ja, udført en anden slags sikkerhedsadfærd", value: 1),
        RPChoice(text: "Nej", value: 2),
      ]);

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPQuestionStep(
          "questionStep1ID",
          title:
              "Min behandler har givet mig eksponering og respons præventions øvelser for til hjemmearbejde.",
          answerFormat: choiceAnswerFormat1,
        ),
        RPQuestionStep(
          "questionStep2ID",
          title: "Tvangstanken jeg vil arbejde med nu, handler om:",
          answerFormat: choiceAnswerFormat2,
        ),
        RPQuestionStep(
          "questionStep3ID",
          title: "Tvangshandlingen jeg vil arbejde med nu, handler om:",
          answerFormat: choiceAnswerFormat3,
        ),
        RPQuestionStep(
          "questionStep4ID",
          title:
              "Beskriv eksponeringsøvelsen (hvordan du vil arbejde på tvangstanken og/eller tvangshandlingen):",
          answerFormat: RPTextAnswerFormat(),
        ),
        RPQuestionStep(
          "questionStep5ID",
          title: "Skriv tiden når du starter med eksponeringsøvelsen:",
          answerFormat: RPDateTimeAnswerFormat(
              dateTimeAnswerStyle: RPDateTimeAnswerStyle.TimeOfDay),
        ),
        RPInstructionStep("", title: "Tvangstanker og -handlinger")
          ..text =
              "Skriv hvor meget ubehag eller angst du oplever lige inden øvelsen og efter 5, 10, og 15 minutter ved hjælp af en skala fra 0–10 på (0 = rolig, ingen angst, 10 = Maksimal angst/ uro). Dine forældre eller terapeut kan hjælp dig med at hold styr på tiden og med at skrive ned.",
        RPQuestionStep(
          "exposure_1",
          title: "Hvor megen ubehag eller angst oplever du lige nu?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          "exposure_2",
          title: "Hvor megen ubehag eller angst oplever du efter 5 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          "exposure_3",
          title: "Hvor megen ubehag eller angst oplever du efter 10 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          "exposure_4",
          title: "Hvor megen ubehag eller angst oplever du efter 15 minutter?",
          answerFormat: _imageChoiceAnswerFormat,
        ),
        RPQuestionStep(
          "questionStep6ID",
          title: "Jeg har brugt sikkerhedsadfærd under øvelsen:",
          answerFormat: choiceAnswerFormat6,
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

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPInstructionStep("parnas_instrux", title: "Where are you?")
          ..text =
              "In the following question, please indicate where you are, and who you are with.",
        RPQuestionStep(
          "location",
          title: "Right now I am...",
          answerFormat: _locationChoices,
        ),
        RPInstructionStep("parnas_instrux_2",
            title: "International Positive and Negative Affect Schedule")
          ..text = "In the following questions, please indicate how "
              "much each of the stated emotions is affecting you at the moment.",
        RPQuestionStep(
          "parnas_1",
          title: "Upset",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_2",
          title: "Hostile",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_3",
          title: "Alert",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_4",
          title: "Ashamed",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_5",
          title: "Inspired",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_6",
          title: "Nervous",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_7",
          title: "Determined",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_8",
          title: "Attentive",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_9",
          title: "Afraid",
          answerFormat: _parnasAnswerFormat,
        ),
        RPQuestionStep(
          "parnas_10",
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

  final RPChoiceAnswerFormat _choiceAnswerFormat = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice, choices: _choices);

  RPTask get survey => RPOrderedTask("who5_survey", [
        RPInstructionStep("who_5_instrux", title: "WHO Well-Being Index")
          ..text =
              "Please indicate for each of the following five statements which is closest to how you have been feeling over the last two weeks. "
                  "Notice that higher numbers mean better well-being.\n\n"
                  "Example: If you have felt cheerful and in good spirits more than half of the time during the last two weeks, "
                  "select the box with the label 'More than half of the time'.",
        RPQuestionStep(
          "who5_1",
          title: "I have felt cheerful and in good spirits",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          "who5_2",
          title: "I have felt calm and relaxed",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          "who5_3",
          title: "I have felt active and vigorous",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          "who5_4",
          title: "I woke up feeling fresh and rested",
          answerFormat: _choiceAnswerFormat,
        ),
        RPQuestionStep(
          "who5_5",
          title: "My daily life has been filled with things that interest me",
          answerFormat: _choiceAnswerFormat,
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

  RPTask get survey => RPOrderedTask("demo_survey", [
        RPQuestionStep(
          "demo_1",
          title: "Which is your biological sex?",
          answerFormat: _sexChoices,
        ),
        RPQuestionStep(
          "demo_2",
          title: "How old are you?",
          answerFormat: _ageChoices,
        ),
        RPQuestionStep(
          "demo_3",
          title: "Do you have any of these medical conditions?",
          answerFormat: _medicalChoices,
        ),
        RPQuestionStep(
          "demo_4",
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

  RPChoiceAnswerFormat _symptomsChoices = RPChoiceAnswerFormat(
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

  RPTask get survey => RPOrderedTask("symptoms_survey", [
        RPQuestionStep(
          "sym_1",
          title: "Do you have any of the following symptoms today?",
          answerFormat: _symptomsChoices,
        ),
      ]);
}
