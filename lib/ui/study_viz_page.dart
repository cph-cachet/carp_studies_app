part of carp_study_app;

class StudyPage extends StatelessWidget {
  final StudyPageModel model;

  StudyPage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study'),
      ),
      body: Center(
        child: Icon(
          Icons.school,
          size: 100,
          color: CACHET.DARK_BLUE,
        ),
        //child: CircularProgressIndicator(),
      ),
    );
  }
}
