part of '../../main.dart';

class StudyCard extends StatelessWidget {
  final StudyPageViewModel studyPageModel = StudyPageViewModel();

  StudyCard({super.key});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    String studyDescription() =>
        '${locale.translate(studyPageModel.description)}\n\n'
        '${locale.translate('widgets.study_card.title')}: "${locale.translate(studyPageModel.title)}".\n'
        '${locale.translate('widgets.study_card.purpose')}: "${locale.translate(studyPageModel.purpose)}".\n\n'
        '${locale.translate('widgets.study_card.responsibles')}:\n'
        '${locale.translate(studyPageModel.piName)}, ${locale.translate(studyPageModel.piTitle)}\n\n'
        '${locale.translate(studyPageModel.piAffiliation)}\n'
        '${locale.translate(studyPageModel.piAddress)}\n'
        '${locale.translate(studyPageModel.piEmail)}\n';

    return StudiesCard(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row(children: [
          //   Expanded(
          //       child: Container(
          //     height: MediaQuery.of(context).size.height * 0.1,
          //     color: Color(0xFFF1F9FF),
          //     child: Image.asset('assets/images/books.png', fit: BoxFit.fitHeight),
          //   ))
          // ]),
          ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 40),
                const SizedBox(width: 40),
                Text(locale.translate(studyPageModel.title),
                    style: aboutCardTitleStyle.copyWith(
                        color: Theme.of(context).primaryColor)),
                const SizedBox(width: 40),
                const SizedBox(width: 40),
              ],
            ),
            subtitle: Text("Tap to learn more", style: aboutCardInfoStyle),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(children: [
                        Text(locale.translate(studyPageModel.piAffiliation),
                            style: aboutCardSubtitleStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          studyDescription(),
                          style: aboutCardContentStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    try {
                      await launchUrl(Uri.parse(locale
                          .translate(studyPageModel.studyDescriptionUrl)));
                    } finally {}
                  },
                  child: Text(locale.translate('pages.about.study.website'),
                      style: aboutCardInfoStyle.copyWith(
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.start)),
              InkWell(
                onTap: () async {
                  try {
                    await launchUrl(Uri.parse(
                        locale.translate(studyPageModel.privacyPolicyUrl)));
                  } finally {}
                },
                child: Text(locale.translate('pages.about.study.privacy'),
                    style: aboutCardInfoStyle.copyWith(
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
