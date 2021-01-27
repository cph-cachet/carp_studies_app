part of carp_study_app;

class StudyCard extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
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
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(width: 15),
                  Text('Cachet, DTU and Monsenso', //TODO get the name of researchers from studyPageModel
                      style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
              children: [
                Row(children: [
                  SizedBox(width: 15),
                  Expanded(
                      child: Text(
                    studyPageModel.description,
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  )),
                  SizedBox(width: 15),
                ]),
                SizedBox(height: 10),
              ]),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
