part of carp_study_app;

/// A local resource manager handling:
///  * informed consent
///  * localization
class LocalResourceManager implements ResourceManager {
  RPOrderedTask _informedConsent;

  static final LocalResourceManager _instance = LocalResourceManager._();
  factory LocalResourceManager() => _instance;

  LocalResourceManager._() {
    RPOrderedTask('', []); // to initialize json serialization for RP classes
  }

  @override
  Future initialize() async {}

  @override
  Future<RPOrderedTask> getInformedConsent() async {
    if (_informedConsent == null) {
      // get the local protocol - studyId is ignored
      CAMSStudyProtocol protocol = await LocalStudyProtocolManager().getStudyProtocol('');

      RPConsentSection overviewSection = RPConsentSection(RPConsentSectionType.Custom)
        ..title = protocol.name
        ..summary = protocol.protocolDescription.description
        ..content =
            "Welcome to the WristAngel study app.\n\nHere you will have access to the tasks and exercises of the WristAngel study.\n\nBefore we begin, we want to tell you about the app and your participation.\n\nIf you are under 18, please go through this with your parent. ";

      // ..content = "You are being asked to take part in a research study. "
      //     "Before you decide to participate in this study, it is important that you understand why the research is being done and what it will involve. "
      //     "Please read the following information carefully. "
      //     "Please ask if there is anything that is not clear or if you need more information.\n\n"
      //     "The title of the study is: \"${protocol.protocolDescription.title}\".\n\n"
      //     "The purpose of this study is: \"${protocol.protocolDescription.purpose}\".\n\n"
      //     "You will be asked to use the CARP smartphone app for up to two months. "
      //     "During this period, the system will collect different kinds of data related to your movements, activities, and health. "
      //     "You will also be asked to fill in different questionnaires.\n\n\n"
      //     "The Principle Investigator (PI) is:\n\n"
      //     "${protocol.responsible.name}, ${protocol.responsible.title}\n"
      //     "${protocol.responsible.affiliation}\n"
      //     "${protocol.responsible.address}\n"
      //     "${protocol.responsible.email}\n\n"
      //     "You can contact the principal investigator if you have any questions.";

      // RPConsentSection dataGatheringSection = RPConsentSection(RPConsentSectionType.DataGathering)
      //   ..summary =
      //       "To get a full picture of your diabetes health, we will collect data on blood glucose, which diabetes-related challenges you want to address, and information about you behavior (such as movement and sleep patterns)."
      //   ..content =
      //       "The DiaFocus system collects and stores the following type of personal data:\n\n•Personal information:\tthis includes your full name, email address, and phone number.\n\n•Demographic information:\tthis includes your age, health status (like smok-ing and drinking habits), gender, height, weight.\n\n•Diabetes information:\tthis includes blood glucose levels.\n\n•Behavioral information:\tthis includes activity, location and weather information.\n\n•Survey:\thealth-related surveys on your life style, emotional distress, well-being, food habits, sleep patterns, depression and anxiety, and medication habits.";

      // RPConsentSection dataUseSection = RPConsentSection(RPConsentSectionType.DataUse)
      //   ..summary = "Data will be used for scientific purposes only. "
      //       "Data will be shared with medical researchers at the Copenhagen Center for Health Technology (CACHET) and published in an anonymized format."
      //   ..content = "The study is hosted at the Copenhagen Center for Health Technology (CACHET), which involves researchers from the Technical University of Denmark (DTU), the University of Copenhagen (UCHP), and the hospitals in the Capital Region of Denmark (Danish: Region Hovedstaden). "
      //       "Data collected from this study will be analyzed and shared by researchers in CACHET.\n\n"
      //       "Results from this study will be published in an anonymized format in scientific journals and other scientific places, and may be presented at scientific conferences. "
      //       "This dissemination of the research results will be completely anonymous and will NOT contain any person-identifiable information. "
      //       "We strive for open-access publication, which means that access to the research results is available for all for free.";

      // RPConsentSection privacySection = RPConsentSection(RPConsentSectionType.Privacy)
      //   ..summary =
      //       "The Technical University of Denmark (DTU) is the data responsible of this study and all data will be collected and stored on secure servers, protecting your privacy."
      //   ..content = "The Technical University of Denmark (DTU) is the data responsible of this study. "
      //       "Data is collected and stored on secure servers operated by DTU.\n\n"
      //       "The Data Protection Officer (DPO) at DTU is:\n\n"
      //       "Ane Sandager\n\n"
      //       "anesa@dtu.dk\n\n"
      //       "+45 9351 1439\n\n"
      //       "You can contact the DPO for any questions you may have regarding the data processing of this study.\n"
      //       "You can get a digital copy of the data being collected by you in this study by contacting the principle investigator.";

      // RPConsentSection studyTaskAndTimeCommitmentSection = RPConsentSection(RPConsentSectionType.Custom)
      //   ..title = "Study Tasks and Time Commitment"
      //   ..summary =
      //       "To get a good picture of your health we will ask you to use the CARP Study App on a daily basis for two months."
      //   ..content = "This study consists of three main activities.\n\n"
      //       "First, you will join for a start up meeting. "
      //       "Here you will be introduced to the system, the study, and then spend some time on becoming familiar with the smartphone app. "
      //       "The start-up meeting will last approx. two hours and will take place at either DTU or virtually.\n\n"
      //       "Second, you should use the app on a daily basis for two months. "
      //       "Daily use means that you should complete the different 'Tasks' which are listed in the app's 'Task List' page. "
      //       "The daily time commitment to these tasks is about 10-15 minutes.\n\n"
      //       "Third, you should complete a digital questionnaire during a closing meeting. "
      //       "Then there will be a small interview asking for you experience from using the CARP smartphone app. "
      //       "This closing meeting will take approx. one hour and will take place either at DTU or virtually.";

      // RPConsentSection clinicalInformationSection = RPConsentSection(RPConsentSectionType.Custom)
      //   ..title = "Clinical Information"
      //   ..summary =
      //       "This is NOT a clinical study and you will NOT receive any clinical feedback on the recordings done as part of this study. "
      //           "If you in any way feel uncomfortable or ill during the study, you should contact your regular healthcare professional."
      //   ..content = "This study is NOT a clinical study. "
      //       "The purpose of this study is \"${protocol.protocolDescription.purpose}\". "
      //       "You will NOT receive any clinical feedback on the recordings being done, and there is NO doctor looking at these recordings.\n\n"
      //       "IF YOU IN ANY WAY FEEL UNCOMFORTABLE OR ILL DURING THE STUDY, YOU SHOULD CONTACT YOUR REGULAR HEALTHCARE PROFESSIONAL.\n\n"
      //       "After the study, data may be analyzed by the medical researchers in the Copenhagen Center for Health Technolocy (CACHET). "
      //       "If the medical researchers finds complications in the collected data they may contact you.";

      // RPConsentSection voluntarySection = RPConsentSection(RPConsentSectionType.Custom)
      //   ..title = "Voluntary Participation"
      //   ..summary =
      //       "Your participation in this study is voluntary and you can withdraw at any time and without giving a reason."
      //   ..content = "Your participation in this study is voluntary.\n\n"
      //       "It is up to you to decide whether or not to take part in this study. "
      //       "If you decide to take part in this study, you will now be asked to sign a consent form. "
      //       "But, after you sign the consent form, you are still free to withdraw at any time and without giving a reason. "
      //       "Withdrawing from this study will not affect the relationship you have, if any, with the researchers or medical doctors conducting the study.";

      RPConsentSection whoAreWeSection = RPConsentSection(RPConsentSectionType.AboutUs)
        ..title = "Who are we?"
        ..summary =
            "This study app was built by researchers and clinicians from Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Technical University of Denmark.\n\nThe main contact person is Clinical psychologist Nicole Lønfeldt.\n\nFunding for this study comes from the Novo Nordisk Foundation."
        ..content =
            "This study app was built by researchers and clinicians from Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Technical University of Denmark.\n\nThe main contact person is Clinical psychologist Nicole Lønfeldt.\n\nFunding for this study comes from the Novo Nordisk Foundation." +
                "Project Team\n\nThis work is done in close collaboration with the Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Copenhagen Center for Health Technology (CACHET) at the Technical University of Denmark (DTU).\n\nThe investigators directly working with this study app include:\n\n- Professor Anne Katrine Pagsberg and Senior Research Scientist Nicole Lønfeldt from the research unit of the Child and Adolescent Mental Health Center\n- Professor Line Clemmensen and Postdoc Sneha Das from the DTU-Compute\n- Professor Jakob E. Bardram and PhD student Giovanna Nunes Vilaza from DTU-Health Tech\n\n\n Project funding\n\nThis study is funded by the Novo Nordisk Foundation’s Exploratory Interdisciplinary Synergy Program. The grant reference number is NNF19OC0056795. The investigators have no financial connection to funders.";

      RPConsentSection ourGoalSection = RPConsentSection(RPConsentSectionType.Goals)
        ..title = "What is this app for?"
        ..summary =
            "For the next 8 weeks, there will be tasks and questions for you or your child to complete every day as part of the study.\n\nThis data is collected to help us to understand how the therapeutic process is evolving with time. \n\nThe results of the study will then improve the assessment and treatment of future patients."
        ..content =
            "For the next 8 weeks, there will be tasks and questions for you or your child to complete every day as part of the study.\n\nThis data is collected to help us to understand how the therapeutic process is evolving with time. \n\nThe results of the study will then improve the assessment and treatment of future patients." +
                "Project and study goals\n\nWe aim to improve assessment and psychotherapy for obsessive-compulsive disorder (OCD) in children and adolescents through digital tools for patients, parents and therapists.\n\nThus, we aim to give an innovative push to public sector hospitals and research by integrating wearable sensors and machine learning techniques. This project's results will also advance research in computational science and psychiatry by testing biomarkers of clinical relevance.\n\nIn this study, we will test the feasibility of implementing digitally enhanced psychotherapy and research in a community child and adolescent mental health centre, including mobile and wearable devices' acceptability to patients, parents, and therapists.\n\n\nStudy tasks\n\n- Daily surveys to register emotional states (Positive and Negative Affect Schedule) and distress levels before and after exposure practice.\n- Weekly surveys to measure symptoms, acceptability, trust [1] and user experience [2] with the Wristband and the Study App.\n\n\nReferences\n\n1. Gulati, S., Sousa, S., & Lamas, D. (2019). Design, development and evaluation of a human-computer trust scale. Behaviour & Information Technology, 38(10), 1004-1015.\n\2. Laugwitz, B., Held, T., & Schrepp, M. (2008, November). Construction and evaluation of a user experience questionnaire. In Symposium of the Austrian HCI and usability engineering group (pp. 63-76). Springer, Berlin, Heidelberg.";

      RPConsentSection dataHandlingSection = RPConsentSection(RPConsentSectionType.DataHandling)
        ..title = "How is your data handled?"
        ..summary =
            "Personal data we collect include your e-mail address and answers to the surveys.\n\nThe access to personal data is restricted to the project's researchers, and data will not be shared with third parties. This data is expected to be stored until the end of the project (end of 2022).\n\nThe legal entity responsible for processing the data from this app is the Technical University of Denmark."
        ..content =
            "Personal data we collect include your e-mail address and answers to the surveys.\n\nThe access to personal data is restricted to the project's researchers, and data will not be shared with third parties. This data is expected to be stored until the end of the project (end of 2022).\n\nThe legal entity responsible for processing the data from this app is the Technical University of Denmark." +
                "Data handling\n\nYour personal data is processed in compliance with the European General Data Protection Regulation (GDPR). The Technical University of Denmark, CVR no. 30060946, is the data controller and processor responsible for processing personal data in this study. Identifiable data can only be accessed by the researchers affiliated with this project. Information will not be shared with your child’s case worker, but you and your child are welcome to share study information with your case worker.\n\n\nData storage\n\nNo data is stored on your smartphone, only processed using a pseudonym so that your information is not linked to your identity. All communication between your smartphone and our server is encrypted. All server-side services, including web applications, can only be accessed by authenticated and authorized users. The data is encrypted and hosted on a server in Denmark.\n\n\nDuration of storage\n\nWe expect the research project to be completed by the end of 2022. All personally identifiable data will be destroyed at the end of the study. The data will not be used in a new research project.";

      RPConsentSection rightsSection = RPConsentSection(RPConsentSectionType.YourRights)
        ..title = "What are your rights?"
        ..summary =
            "Participation should be voluntary and harmless. You and your child are free to stop using the app at any time. If you have any negative experiences, please inform us. \n\nYou also have the right to have your individual data records deleted after the study (according to GDPR).\n\nIf you are interested in receiving the research results, you can request them from the project team. You will receive a copy of this consent form through the app."
        ..content =
            "Participation should be voluntary and harmless. You and your child are free to stop using the app at any time. If you have any negative experiences, please inform us. \n\nYou also have the right to have your individual data records deleted after the study (according to GDPR).\n\nIf you are interested in receiving the research results, you can request them from the project team. You will receive a copy of this consent form through the app." +
                "Participants'rights\n\nWe are not aware of any major risk or safety issues associated with participation in this study. If you or your child are a patient, and suffers injuries due to the research project, you can apply for compensation under the Patient Insurance Act. The ethics committee of the Captial Region of Denmark approved the WristAngel project on January 15, 2021 (journal number: H-18010607).\n\nYour participation is voluntary, and you are free to withdraw your consent at any time, without the need to provide a reason. Doing so will have no adverse effect on your legal rights. We will contact you to ask for your consent if we ever need to use your anonymised survey app data for a similar study.\n\nYou can choose if you want to have your data deleted or not after the study or if you withdraw. You can also receive the results of the surveys once the research is complete if you contact us by e-mail. The compensation you receive for using this app is what you receive for the study overall.\n\n\nContact\n\nThe main contact person is Clinical psychologist Nicole Nadine Lønfeldt, CAMHS Bispebjerg: rhp-tecto@regionh.dk";

      RPConsentSection summarySection = RPConsentSection(RPConsentSectionType.StudyTasks)
        ..title = "Summary before consent"
        ..summary =
            "You are above 18 years old. If you are not, please go through this with your parent. \n\nYou have read and understood the provided information and have had the opportunity to ask questions.\n\nYou understand your rights: your participation is voluntary, and you are free to withdraw at any time.\n\nYou understand and agree with how your data is collected, stored and used."
        ..content =
            "You are above 18 years old. If you are not, please go through this with your parent. \n\nYou have read and understood the provided information and have had the opportunity to ask questions.\n\nYou understand your rights: your participation is voluntary, and you are free to withdraw at any time.\n\nYou understand and agree with how your data is collected, stored and used.";

      RPConsentSignature signature = RPConsentSignature("signatureID");

      RPConsentDocument consentDocument = RPConsentDocument('CACHET Research Platfom', [
        overviewSection,
        whoAreWeSection,
        ourGoalSection,
        dataHandlingSection,
        rightsSection,
        summarySection,

        // overviewSection,
        // dataGatheringSection,
        // dataUseSection,
        // privacySection,
        // studyTaskAndTimeCommitmentSection,
        // clinicalInformationSection,
        // voluntarySection,
      ])
        ..addSignature(signature);

      RPConsentReviewStep consentReviewStep = RPConsentReviewStep("consentreviewstepID", consentDocument)
        ..reasonForConsent =
            "Have you read, understood and agreed with using this app for the study as explained?"
        ..text = "Provide your consent"
        ..title = "Provide your consent";

      // ..reasonForConsent =
      //     "I have read and I understand the provided information and have had the opportunity to ask questions. "
      //         "I understand that my participation is voluntary and that I am free to withdraw at any time, without giving a reason and without cost. "
      //         "I understand that I will be given a copy of this consent form. "
      //         "I voluntarily agree to take part in this study."
      // ..text = "Agree?"
      // ..title = "Consent";

      RPVisualConsentStep consentVisualStep = RPVisualConsentStep("visualStep", consentDocument);

      RPCompletionStep completionStep = RPCompletionStep("completionID")
        ..title = "Thank you!"
        ..text = "We have saved your consent document.";

      _informedConsent = RPOrderedTask(
        "consentTaskID",
        [
          consentVisualStep,
          consentReviewStep,
          completionStep,
        ],
        closeAfterFinished: false,
      );
    }
    return _informedConsent;
  }

  @override
  Future<bool> deleteInformedConsent() {
    // TODO: implement deleteInformedConsent
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLocalizations(Locale locale) {
    // TODO: implement deleteLocalizations
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> getLocalizations(Locale locale) {
    // TODO: implement getLocalizations
    throw UnimplementedError();
  }

  @override
  // TODO: implement informedConsent
  RPOrderedTask get informedConsent => throw UnimplementedError();

  @override
  Future<bool> setInformedConsent(RPOrderedTask informedConsent) {
    // TODO: implement setInformedConsent
    throw UnimplementedError();
  }

  @override
  Future<bool> setLocalizations(Locale locale, Map<String, dynamic> localizations) {
    // TODO: implement setLocalizations
    throw UnimplementedError();
  }
}
