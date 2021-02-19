part of carp_study_app;

RPConsentSection overviewSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = bloc.study.name
  ..summary = bloc.study.description
  ..content = "You are being asked to take part in a research study. "
      "Before you decide to participate in this study, it is important that you understand why the research is being done and what it will involve. "
      "Please read the following information carefully. "
      "Please ask if there is anything that is not clear or if you need more information.\n\n"
      "The title of the study is: \"${bloc.study.title}\"\n\n"
      "The purpose of this study is: \"${bloc.study.title}\"\n\n"
      "You will be asked to use the CARP smartphone app for up to two months. "
      "During this period, the system will collect different kinds of data related to your movements, activities, health. "
      "You will also be asked to fill in different questionnaires.\n\n\n"
      "The Principle Investigator (PI) is:\n\n"
      "${bloc.study.pi.name}, ${bloc.study.pi.title}\n\n"
      "${bloc.study.pi.affiliation}\n\n"
      "${bloc.study.pi.address}\n\n"
      "${bloc.study.pi.email}\n\n"
      "You can contact the principal investigator if you have any questions.";

RPConsentSection dataGatheringSection = RPConsentSection.withParams(
    RPConsentSectionType.DataGathering)
  ..summary =
      "To get a full picture of your diabetes health, we will collect data on blood glucose, which diabetes-related challenges you want to address, and information about you behavior (such as movement and sleep patterns)."
  ..content =
      "The DiaFocus system collects and stores the following type of personal data:\n\n•Personal information:\tthis includes your full name, email address, and phone number.\n\n•Demographic information:\tthis includes your age, health status (like smok-ing and drinking habits), gender, height, weight.\n\n•Diabetes information:\tthis includes blood glucose levels.\n\n•Behavioral information:\tthis includes activity, location and weather information.\n\n•Survey:\thealth-related surveys on your life style, emotional distress, well-being, food habits, sleep patterns, depression and anxiety, and medication habits.";

RPConsentSection dataUseSection = RPConsentSection.withParams(
    RPConsentSectionType.DataUse)
  ..summary = "Data will be used for scientific purposes only. "
      "Data will be shared with medical researchers at the Copenhagen Center for Health Technology (CACHET) and published in an anonymized format."
  ..content = "The study is hosted at the Copenhagen Center for Health Technology (CACHET), which involves researchers from the Technical University of Denmark (DTU), the University of Copenhagen (UCHP), and the hospitals in the Capital Region of Denmark (Danish: Region Hovedstaden). "
      "Data collected from this study will be analyzed and shared by researchers in CACHET.\n\n"
      "Results from this study will be published in an anonymized format in scientific journals and other scientific places, and may be presented at scientific conferences. "
      "This dissemination of the research results will be completely anonymous and will NOT contain any person-identifiable information. "
      "We strive for open-access publication, which means that access to the research results is available for all for free.";

RPConsentSection privacySection = RPConsentSection.withParams(
    RPConsentSectionType.Privacy)
  ..summary =
      "The Technical University of Denmark (DTU) is the data responsible of this study and all data will be collected and stored on secure servers, protecting your privacy."
  ..content = "The Technical University of Denmark (DTU) is the data responsible of this study. "
      "Data is collected and stored on secure servers operated by DTU.\n\n"
      "The Data Protection Officer (DPO) at DTU is:\n\n"
      "Ane Sandager\n\n"
      "anesa@dtu.dk\n\n"
      "+45 9351 1439\n\n"
      "You can contact the DPO for any questions you may have regarding the data processing of this study.\n"
      "You can get a digital copy of the data being collected by you in this study by contacting the principle investigator.";

RPConsentSection studyTaskAndTimeCommitmentSection = RPConsentSection
    .withParams(RPConsentSectionType.Custom)
  ..title = "Study Tasks and Time Commitment"
  ..summary =
      "To get a good picture of your health we will ask you to use the CARP Study App on a daily basis for two months."
  ..content = "This study consists of three main activities.\n\n"
      "First, you will join for a start up meeting. "
      "Here you will be introduced to the system, the study, and then spend some time on becoming familiar with the smartphone app. "
      "The start-up meeting will last approx. two hours and will take place at either DTU or virtually.\n\n"
      "Second, you should use the app on a daily basis for two months. "
      "Daily use means that you should complete the different 'Tasks' which are listed in the app's 'Task List' page. "
      "The daily time commitment to these tasks is about 10-15 minutes.\n\n"
      "Third, you should complete a digital questionnaire during a closing meeting. "
      "Then there will be a small interview asking for you experience from using the CARP smartphone app. "
      "This closing meeting will take approx. one hour and will take place either at DTU or virtually.";

RPConsentSection clinicalInformationSection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = "Clinical Information"
  ..summary =
      "This is NOT a clinical study and you will NOT receive any clinical feedback on the recordings done as part of this study. "
          "If you in any way feel uncomfortable or ill during the study, you should contact your regular healthcare professional."
  ..content = "This study is NOT a clinical study. "
      "The purpose of this study is to investigate the technical feasibility of the CACHET Research Platform, including its usefulness for continuous monitoring and its usability in everyday use. "
      "You will NOT receive any clinical feed-back on the recordings being done, and there is NO doctor looking at these recordings.\n\n"
      "IF YOU IN ANY WAY FEEL UNCOMFORTABLE OR ILL DURING THE STUDY, YOU SHOULD CONTACT YOUR REGULAR HEALTHCARE PROFESSIONAL.\n\n"
      "After the study, data will be analyzed in cooperation with our collaborating medical researchers in the Copenhagen Center for Health Technolocy (CACHET). "
      "If the medical researchers finds complications in the collected data they may contact you.";

RPConsentSection voluntarySection = RPConsentSection.withParams(
    RPConsentSectionType.Custom)
  ..title = "Voluntary Participation"
  ..summary =
      "Your participation in this study is voluntary and you can withdraw at any time and without giving a reason."
  ..content = "Your participation in this study is voluntary.\n\n"
      "It is up to you to decide whether or not to take part in this study. "
      "If you decide to take part in this study, you will now be asked to sign a consent form. "
      "But, after you sign the consent form, you are still free to withdraw at any time and without giving a reason. "
      "Withdrawing from this study will not affect the relationship you have, if any, with the researchers or medical doctors conducting the study.";

RPConsentSignature signature = RPConsentSignature.withIdentifier("signatureID");

RPConsentDocument consentDocument =
    RPConsentDocument.withParams('CACHET Research Platfom', [
  overviewSection,
  dataGatheringSection,
  dataUseSection,
  privacySection,
  studyTaskAndTimeCommitmentSection,
  clinicalInformationSection,
  voluntarySection,
])
      ..addSignature(signature);

RPConsentReviewStep consentReviewStep = RPConsentReviewStep(
    "consentreviewstepID", consentDocument)
  ..reasonForConsent =
      "I have read and I understand the provided information and have had the opportunity to ask questions. "
          "I understand that my participation is voluntary and that I am free to withdraw at any time, without giving a reason and without cost. "
          "I understand that I will be given a copy of this consent form. "
          "I voluntarily agree to take part in this study."
  ..text = "Agree?"
  ..title = "Consent";

RPVisualConsentStep consentVisualStep =
    RPVisualConsentStep("visualStep", consentDocument);

RPCompletionStep completionStep = RPCompletionStep("completionID")
  ..title = "Thank you!"
  ..text = "We have saved your consent document.";

RPOrderedTask informedConsentTask = RPOrderedTask(
  "consentTaskID",
  [
    consentVisualStep,
    consentReviewStep,
    completionStep,
  ],
  closeAfterFinished: false,
);
