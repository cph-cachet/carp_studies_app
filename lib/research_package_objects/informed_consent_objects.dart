part of carp_study_app;

RPConsentSection overviewSection = RPConsentSection.withParams(RPConsentSectionType.Overview)
  ..title = bloc.study.name
  ..summary =
      "Welcome to the WristAngel study app.\n\nHere you will have access to the tasks and exercises of the WristAngel study.\n\nBefore we begin, we want to tell you about the app and your participation.\n\nIf you are under 18, please go through this with your parent. "
  ..content =
      "Welcome to the WristAngel study app.\n\nHere you will have access to the tasks and exercises of the WristAngel study.\n\nBefore we begin, we want to tell you about the app and your participation.\n\nIf you are under 18, please go through this with your parent. ";
// "You are being asked to take part in a research study. "
//     "Before you decide to participate in this study, it is important that you understand why the research is being done and what it will involve. "
//     "Please read the following information carefully. "
//     "Please ask if there is anything that is not clear or if you need more information.\n\n"
//     "The title of the study is: \"${bloc.study.title}\".\n\n"
//     "The purpose of this study is: \"${bloc.study.purpose}\".\n\n"
//     "You will be asked to use the CARP smartphone app for up to two months. "
//     "During this period, the system will collect different kinds of data related to your movements, activities, and health. "
//     "You will also be asked to fill in different questionnaires.\n\n\n"
//     "The Principle Investigator (PI) is:\n\n"
//     "${bloc.study.pi.name}, ${bloc.study.pi.title}\n"
//     "${bloc.study.pi.affiliation}\n"
//     "${bloc.study.pi.address}\n"
//     "${bloc.study.pi.email}\n\n"
//     "You can contact the principal investigator if you have any questions.";

RPConsentSection whoAreWeSection = RPConsentSection.withParams(RPConsentSectionType.AboutUs)
  ..title = "Who are we?"
  ..summary =
      "This study app was built by researchers and clinicians from Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Technical University of Denmark.\n\nThe main contact person is Clinical psychologist Nicole Lønfeldt.\n\nFunding for this study comes from the Novo Nordisk Foundation."
  ..content =
      "This study app was built by researchers and clinicians from Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Technical University of Denmark.\n\nThe main contact person is Clinical psychologist Nicole Lønfeldt.\n\nFunding for this study comes from the Novo Nordisk Foundation." +
          "Project Team\n\nThis work is done in close collaboration with the Child and Adolescent Mental Health Center, Research Unit, Capital Region of Denmark and the Copenhagen Center for Health Technology (CACHET) at the Technical University of Denmark (DTU).\n\nThe investigators directly working with this study app include:\n\n- Professor Anne Katrine Pagsberg and Senior Research Scientist Nicole Lønfeldt from the research unit of the Child and Adolescent Mental Health Center\n- Professor Line Clemmensen and Postdoc Sneha Das from the DTU-Compute\n- Professor Jakob E. Bardram and PhD student Giovanna Nunes Vilaza from DTU-Health Tech\n\n\n Project funding\n\nThis study is funded by the Novo Nordisk Foundation’s Exploratory Interdisciplinary Synergy Program. The grant reference number is NNF19OC0056795. The investigators have no financial connection to funders.";

RPConsentSection ourGoalSection = RPConsentSection.withParams(RPConsentSectionType.Goals)
  ..title = "What is this app for?"
  ..summary =
      "For the next 8 weeks, there will be tasks and questions for you or your child to complete every day as part of the study.\n\nThis data is collected to help us to understand how the therapeutic process is evolving with time. \n\nThe results of the study will then improve the assessment and treatment of future patients."
  ..content =
      "For the next 8 weeks, there will be tasks and questions for you or your child to complete every day as part of the study.\n\nThis data is collected to help us to understand how the therapeutic process is evolving with time. \n\nThe results of the study will then improve the assessment and treatment of future patients." +
          "Project and study goals\n\nWe aim to improve assessment and psychotherapy for obsessive-compulsive disorder (OCD) in children and adolescents through digital tools for patients, parents and therapists.\n\nThus, we aim to give an innovative push to public sector hospitals and research by integrating wearable sensors and machine learning techniques. This project's results will also advance research in computational science and psychiatry by testing biomarkers of clinical relevance.\n\nIn this study, we will test the feasibility of implementing digitally enhanced psychotherapy and research in a community child and adolescent mental health centre, including mobile and wearable devices' acceptability to patients, parents, and therapists.\n\n\nStudy tasks\n\n- Daily surveys to register emotional states (Positive and Negative Affect Schedule) and distress levels before and after exposure practice.\n- Weekly surveys to measure symptoms, acceptability, trust [1] and user experience [2] with the Wristband and the Study App.\n\n\nReferences\n\n1. Gulati, S., Sousa, S., & Lamas, D. (2019). Design, development and evaluation of a human-computer trust scale. Behaviour & Information Technology, 38(10), 1004-1015.\n\2. Laugwitz, B., Held, T., & Schrepp, M. (2008, November). Construction and evaluation of a user experience questionnaire. In Symposium of the Austrian HCI and usability engineering group (pp. 63-76). Springer, Berlin, Heidelberg.";

RPConsentSection dataHandlingSection = RPConsentSection.withParams(RPConsentSectionType.DataHandling)
  ..title = "How is your data handled?"
  ..summary =
      "Personal data we collect include your e-mail address and answers to the surveys.\n\nThe access to personal data is restricted to the project's researchers, and data will not be shared with third parties. This data is expected to be stored until the end of the project (end of 2022).\n\nThe legal entity responsible for processing the data from this app is the Technical University of Denmark."
  ..content =
      "Personal data we collect include your e-mail address and answers to the surveys.\n\nThe access to personal data is restricted to the project's researchers, and data will not be shared with third parties. This data is expected to be stored until the end of the project (end of 2022).\n\nThe legal entity responsible for processing the data from this app is the Technical University of Denmark." +
          "Data handling\n\nYour personal data is processed in compliance with the European General Data Protection Regulation (GDPR). The Technical University of Denmark, CVR no. 30060946, is the data controller and processor responsible for processing personal data in this study. Identifiable data can only be accessed by the researchers affiliated with this project. Information will not be shared with your child’s case worker, but you and your child are welcome to share study information with your case worker.\n\n\nData storage\n\nNo data is stored on your smartphone, only processed using a pseudonym so that your information is not linked to your identity. All communication between your smartphone and our server is encrypted. All server-side services, including web applications, can only be accessed by authenticated and authorized users. The data is encrypted and hosted on a server in Denmark.\n\n\nDuration of storage\n\nWe expect the research project to be completed by the end of 2022. All personally identifiable data will be destroyed at the end of the study. The data will not be used in a new research project.";

RPConsentSection rightsSection = RPConsentSection.withParams(RPConsentSectionType.YourRights)
  ..title = "What are your rights?"
  ..summary =
      "Participation should be voluntary and harmless. You and your child are free to stop using the app at any time. If you have any negative experiences, please inform us. \n\nYou also have the right to have your individual data records deleted after the study (according to GDPR).\n\nIf you are interested in receiving the research results, you can request them from the project team. You will receive a copy of this consent form through the app."
  ..content =
      "Participation should be voluntary and harmless. You and your child are free to stop using the app at any time. If you have any negative experiences, please inform us. \n\nYou also have the right to have your individual data records deleted after the study (according to GDPR).\n\nIf you are interested in receiving the research results, you can request them from the project team. You will receive a copy of this consent form through the app." +
          "Participants'rights\n\nWe are not aware of any major risk or safety issues associated with participation in this study. If you or your child are a patient, and suffers injuries due to the research project, you can apply for compensation under the Patient Insurance Act. The ethics committee of the Captial Region of Denmark approved the WristAngel project on January 15, 2021 (journal number: H-18010607).\n\nYour participation is voluntary, and you are free to withdraw your consent at any time, without the need to provide a reason. Doing so will have no adverse effect on your legal rights. We will contact you to ask for your consent if we ever need to use your anonymised survey app data for a similar study.\n\nYou can choose if you want to have your data deleted or not after the study or if you withdraw. You can also receive the results of the surveys once the research is complete if you contact us by e-mail. The compensation you receive for using this app is what you receive for the study overall.\n\n\nContact\n\nThe main contact person is Clinical psychologist Nicole Nadine Lønfeldt, CAMHS Bispebjerg: rhp-tecto@regionh.dk";

RPConsentSection summarySection = RPConsentSection.withParams(RPConsentSectionType.StudyTasks)
  ..title = "Summary before consent"
  ..summary =
      "You are above 18 years old. If you are not, please go through this with your parent. \n\nYou have read and understood the provided information and have had the opportunity to ask questions.\n\nYou understand your rights: your participation is voluntary, and you are free to withdraw at any time.\n\nYou understand and agree with how your data is collected, stored and used."
  ..content =
      "You are above 18 years old. If you are not, please go through this with your parent. \n\nYou have read and understood the provided information and have had the opportunity to ask questions.\n\nYou understand your rights: your participation is voluntary, and you are free to withdraw at any time.\n\nYou understand and agree with how your data is collected, stored and used.";
RPConsentSignature signature = RPConsentSignature.withIdentifier("signatureID");

RPConsentDocument consentDocument = RPConsentDocument.withParams('WristAngel study', [
  overviewSection,
  whoAreWeSection,
  ourGoalSection,
  dataHandlingSection,
  rightsSection,
  summarySection,
])
  ..addSignature(signature);

RPConsentReviewStep consentReviewStep = RPConsentReviewStep("consentreviewstepID", consentDocument)
  ..reasonForConsent = "Have you read, understood and agreed with using this app for the study as explained?"
  ..text = "Provide your consent"
  ..title = "Provide your consent";

RPVisualConsentStep consentVisualStep = RPVisualConsentStep("visualStep", consentDocument);

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
