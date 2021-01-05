part of carp_study_app;

class StudyBanner extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Theme.of(context).accentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(studyPageModel.name,
                  style: studyTitleStyle.copyWith(color: Theme.of(context).primaryColor))
            ],
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
                  Text('Read more about the study',
                      style: readMoreStudyStyle.copyWith(color: Theme.of(context).primaryColor)),
                  Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).primaryColor)
                ],
              ))
        ],
      ),
    );
  }
}
