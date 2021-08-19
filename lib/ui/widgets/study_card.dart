part of carp_study_app;

class StudyCard extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;

    String description() =>
        '${bloc.deployment?.protocolDescription?.description ?? locale.translate('widgets.study_card.no_description')}\n\n'
        '${locale.translate('widgets.study_card.title')}: \"${bloc.deployment?.protocolDescription?.title}\".\n'
        '${locale.translate('widgets.study_card.purpose')}: \"${bloc.deployment?.protocolDescription?.purpose}\".\n\n'
        '${locale.translate('widgets.study_card.responsibles')}:\n'
        '${bloc.deployment?.responsible!.name}, ${bloc.deployment?.responsible?.title}\n\n'
        //'${bloc.study.pi.affiliation}\n'
        '${bloc.deployment?.responsible?.address}\n'
        '${bloc.deployment?.responsible?.email}\n';

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
                  Text(studyPageModel.name,
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(width: 15),
                  Text(studyPageModel.affiliation,
                      style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
              children: [
                Row(children: [
                  SizedBox(width: 15),
                  Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        "HI",
                        //description(),
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
