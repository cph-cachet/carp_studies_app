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
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: 400,
            height: 3 * height / 4 + 10,
            color: Color(0xFFF1F9FF),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Text(studyPageModel.description,
                        style: aboutCardContentStyle, textAlign: TextAlign.justify)),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Read less', style: readMoreStudyStyle),
                        Icon(Icons.keyboard_arrow_up_outlined, color: Color(0xff77A8C8))
                      ],
                    )),
                SizedBox(height: height * .05)
              ],
            ),
          )
        ])));
  }
}
