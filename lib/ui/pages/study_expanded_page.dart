part of carp_study_app;

class StudyExpandedPage extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    String studyDescription() => '${locale.translate(studyPageModel.description)}\n\n'
        '${locale.translate('widgets.study_card.title')}: \"${locale.translate(studyPageModel.title)}\".\n'
        '${locale.translate('widgets.study_card.purpose')}: \"${locale.translate(studyPageModel.purpose)}\".\n\n'
        '${locale.translate('widgets.study_card.responsibles')}:\n'
        '${locale.translate(studyPageModel.piName)}, ${locale.translate(studyPageModel.piTitle)}\n\n'
        '${locale.translate(studyPageModel.piAffiliation)}\n'
        '${locale.translate(studyPageModel.piAddress)}\n'
        '${locale.translate(studyPageModel.piEmail)}\n';

    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            //height: MediaQuery.of(context).size.height * 0.3,
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ]),
                  Image.asset(
                    './assets/images/kids.png',
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(height: 20),
                  Text(locale.translate(studyPageModel.title),
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),

                  //height: MediaQuery.of(context).size.height * 0.3,
                  SizedBox(height: 10),
                  Text(locale.translate(studyPageModel.piAffiliation),
                      style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(height: 5),
                  Text(
                    studyDescription(),
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (await canLaunch(locale.translate(studyPageModel.privacyPolicyUrl))) {
                                await launch(locale.translate(studyPageModel.privacyPolicyUrl));
                              } else {
                                throw 'Could not launch privacy policy URL';
                              }
                            },
                            icon: Icon(Icons.policy_outlined, color: Theme.of(context).primaryColor),
                          ),
                          Text(locale.translate('pages.about.study.privacy'),
                              style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor))
                        ],
                      ),
                      SizedBox(width: 25),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (await canLaunch(locale.translate(studyPageModel.studyDescriptionUrl))) {
                                await launch(locale.translate(studyPageModel.studyDescriptionUrl));
                              } else {
                                throw 'Could not launch project URL';
                              }
                            },
                            icon: Icon(Icons.public_outlined, color: Theme.of(context).primaryColor),
                          ),
                          Text(locale.translate('pages.about.study.website'),
                              style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
