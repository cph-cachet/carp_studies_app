part of carp_study_app;

class StudyCard extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);

    String description() =>
        '${studyPageModel.description ?? locale.translate('No description available.')}\n\n'
        '${locale.translate('The title of the study is')}: \"${bloc.deployment.protocolDescription.title}\".\n'
        '${locale.translate('The purpose of this study is')}: \"${bloc.deployment.protocolDescription.purpose}\".\n\n'
        '${locale.translate('The Principle Investigator (PI) is')}:\n'
        '${bloc.deployment.owner.name}, ${bloc.deployment.owner.title}\n\n'
        //'${bloc.study.pi.affiliation}\n'
        '${bloc.deployment.owner.address}\n'
        '${bloc.deployment.owner.email}\n';

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
              child: Image.asset('assets/images/study.png',
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
                      style: aboutCardTitleStyle.copyWith(
                          color: Theme.of(context).primaryColor)),
                  SizedBox(width: 15),
                  Text(studyPageModel.affiliation,
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
                        description(),
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
