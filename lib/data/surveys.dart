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

class _ExposureSurvey implements Survey {
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
          RPIntegerAnswerFormat.withParams(0, 200), // TODO: textbox
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
