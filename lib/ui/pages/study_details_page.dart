part of carp_study_app;

class StudyDetailsPage extends StatelessWidget {
  static const String route = '/study_details';
  final StudyPageViewModel model;
  StudyDetailsPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    String studyDescription() => '${locale.translate(model.description)}\n\n'
        '${locale.translate('widgets.study_card.title')}: "${locale.translate(model.title)}".\n'
        '${locale.translate('widgets.study_card.purpose')}: "${locale.translate(model.purpose)}".\n\n'
        '${locale.translate('widgets.study_card.responsibles')}:\n'
        '${locale.translate(model.piName)}, ${locale.translate(model.piTitle)}\n\n'
        '${locale.translate(model.piAffiliation)}\n'
        '${locale.translate(model.piAddress)}\n'
        '${locale.translate(model.piEmail)}\n';

    return Scaffold(
        body: Container(
            //height: MediaQuery.of(context).size.height * 0.3,
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () => context.canPop()
                            ? context.pop()
                            : context.replace('/'),
                        icon: const Icon(Icons.close))
                  ]),
                  Flexible(
                      child: ListView(children: [
                    DetailsBanner(model.title, './assets/images/kids.png'),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: [
                          Text(locale.translate(model.piAffiliation),
                              style: aboutCardSubtitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          Text(
                            studyDescription(),
                            style: aboutCardContentStyle,
                            textAlign: TextAlign.justify,
                          )
                        ]))
                  ])),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () async {
                                  String url =
                                      locale.translate(model.privacyPolicyUrl);
                                  try {
                                    await launchUrl(Uri.parse(url));
                                  } catch (error) {
                                    warning(
                                        "Could not launch privacy policy URL - '$url'");
                                  }
                                },
                                child: Row(children: [
                                  Icon(Icons.policy_outlined,
                                      color: Theme.of(context).primaryColor),
                                  Text(
                                      locale.translate(
                                          'pages.about.study.privacy'),
                                      style: aboutCardSubtitleStyle.copyWith(
                                          color:
                                              Theme.of(context).primaryColor))
                                ])),
                            const SizedBox(width: 15),
                            InkWell(
                                onTap: () async {
                                  String url = locale
                                      .translate(model.studyDescriptionUrl);
                                  try {
                                    await launchUrl(Uri.parse(url));
                                  } catch (error) {
                                    warning(
                                        "Could not launch study description URL - '$url'");
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.public_outlined,
                                        color: Theme.of(context).primaryColor),
                                    Text(
                                        locale.translate(
                                            'pages.about.study.website'),
                                        style: aboutCardSubtitleStyle.copyWith(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ],
                                ))
                          ]))
                ]))));
  }
}
