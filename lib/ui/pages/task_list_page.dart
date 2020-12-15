part of carp_study_app;

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(height: height * .08),
                  CarpAppBar(),
                  ScoreBoard(),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('MY TASKS', style: sectionTitleStyle, textAlign: TextAlign.left),
                  ),
                  task('My mood yesterday', 1, DateTime.now()),
                ])))
      ]
          //child: CircularProgressIndicator(),
          ),
    ));
  }

  Widget task(String title, int timeToComplete, DateTime date) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFF1F9FF),
          child: Icon(Icons.mood_outlined, color: Color.fromRGBO(32, 111, 162, 1)),
        ),
        title: Text(title, style: aboutCardTitleStyle),
        subtitle: Text(timeToComplete.toString() + 'min to complete -' + date.day.toString()),
      ),
    );
  }
}
