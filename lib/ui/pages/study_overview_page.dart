part of carp_study_app;

class StudyOverviewPage extends StatefulWidget {
  @override
  _StudyOverviewPageState createState() => _StudyOverviewPageState();
}

class _StudyOverviewPageState extends State<StudyOverviewPage> {
  final StudyPageModel studyPageModel = StudyPageModel();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: height - 240,
                color: Theme.of(context).accentColor,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Text(studyPageModel.description,
                            style: studyDescriptionStyle.copyWith(
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.justify)),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Read less', style: readMoreStudyStyle),
                            Icon(Icons.keyboard_arrow_up_outlined,
                                color: Theme.of(context).primaryColor)
                          ],
                        )),
                    SizedBox(height: height * .05)
                  ],
                ),
              )
            ])));
  }
}
