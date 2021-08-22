part of carp_study_app;

class StudyCard extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;

    String studyDescription() =>
        '${locale.translate(studyPageModel.description)}\n\n'
        '${locale.translate('widgets.study_card.title')}: \"${locale.translate(studyPageModel.title)}\".\n'
        '${locale.translate('widgets.study_card.purpose')}: \"${locale.translate(studyPageModel.purpose)}\".\n\n'
        '${locale.translate('widgets.study_card.responsibles')}:\n'
        '${locale.translate(studyPageModel.piName)}, ${locale.translate(studyPageModel.piTitle)}\n\n'
        '${locale.translate(studyPageModel.piAffiliation)}\n'
        '${locale.translate(studyPageModel.piAddress)}\n'
        '${locale.translate(studyPageModel.piEmail)}\n';

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Expanded(
                child: Container(
              height: 120.0,
              color: Color(0xFFF1F9FF),
              child: Image.asset('assets/images/park.png',
                  fit: BoxFit.fitHeight), //TODO get image from studyPageModel
            ))
          ]),
          ExpansionTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  Text(locale.translate(studyPageModel.title),
                      style: aboutCardTitleStyle.copyWith(
                          color: Theme.of(context).primaryColor)),
                  SizedBox(width: 15),
                  Text(locale.translate(studyPageModel.piAffiliation),
                      style: aboutCardSubtitleStyle.copyWith(
                          color: Theme.of(context).primaryColor)),
                ],
              ),
              children: [
                Row(children: [
                  SizedBox(width: 15),
                  Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        studyDescription(),
                        style: aboutCardContentStyle,
                        textAlign: TextAlign.justify,
                      )),
                  SizedBox(width: 15),
                ]),
              ]),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(5),
    );
  }
}
