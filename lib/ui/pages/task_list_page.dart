part of carp_study_app;

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(children: <Widget>[
        StreamBuilder<UserTask>(
            stream: TaskListPageModel().userTaskEvents,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .08),
                        CarpAppBar(),
                        scoreBoard(TaskListPageModel().daysInStudy, TaskListPageModel().taskCompleted),
                        SizedBox(height: 15),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('MY TASKS', style: sectionTitleStyle),
                            )),
                        SingleChildScrollView(
                            child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // -1 because these are "Previous Chapters, so we don't want to show the latest one
                                //itemCount: snapshot.data.chapters.length - 1,
                                itemBuilder: (context, index) {
                                  return task(snapshot.data.task.title, 1, DateTime.now());
                                })),
                      ]));
            })
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
      margin: EdgeInsets.all(10),
      elevation: 5,
    );
  }

  Widget scoreBoard(int daysInStudy, int taskCompleted) {
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
            children: [
              Column(
                children: [
                  Text(daysInStudy.toString(), style: scoreNumberStyle),
                  Text('Days in study', style: scoreTextStyle),
                ],
              ),
              Container(
                  height: 66,
                  child: VerticalDivider(
                    color: Color(0xff77A8C8),
                    width: 80,
                  )),
              Column(
                children: [
                  Text(taskCompleted.toString(), style: scoreNumberStyle),
                  Text('Task completed', style: scoreTextStyle),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
