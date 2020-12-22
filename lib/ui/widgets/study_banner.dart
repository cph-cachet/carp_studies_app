part of carp_study_app;

class StudyBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 110,
      color: Color(0xFFF1F9FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(bloc._study.name, style: studyTitleStyle)],
          ),
          SizedBox(height: 15),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false, pageBuilder: (BuildContext context, _, __) => StudyOverviewPage()));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Read more about the study', style: readMoreStudyStyle),
                  Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff77A8C8))
                ],
              ))
        ],
      ),
    );
  }
}
