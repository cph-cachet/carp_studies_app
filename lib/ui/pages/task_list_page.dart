part of carp_study_app;

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<UserTask> tasks = bloc.tasks.reversed.toList();

    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .08),
                  CarpAppBar(),
                  Flexible(
                      child: StreamBuilder<UserTask>(
                          stream: AppTaskController().userTaskEvents,
                          builder: (context, snapshot) {
                            // TODO: use model here
                            return _scoreBoard(2, 4);
                          })),
                  SizedBox(height: 15),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('MY TASKS', style: sectionTitleStyle),
                      )),
                  SizedBox(height: 15),
                  Flexible(
                      child: StreamBuilder<UserTask>(
                          stream: AppTaskController().userTaskEvents,
                          builder: (context, snapshot) {
                            return Scrollbar(
                              child: ListView.builder(
                                  itemCount: tasks.length,
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  itemBuilder: (context, index) {
                                    // TODO: show the undone tasks first
                                    if (tasks[index].state == UserTaskState.done)
                                      return _buildDoneTaskCard(context, tasks[index]);
                                    else
                                      return _buildTaskCard(context, tasks[index]);
                                  }),
                            );
                          }))
                ])));
  }

  Widget _buildTaskCard(BuildContext context, UserTask userTask) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5,
        child: StreamBuilder<UserTaskState>(
          stream: userTask.stateEvents,
          initialData: UserTaskState.initialized,
          builder: (context, AsyncSnapshot<UserTaskState> snapshot) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFF1F9FF),
                  //TODO: change icon to task type
                  child: Icon(Icons.mood_outlined, color: Color.fromRGBO(32, 111, 162, 1)),
                ),
                title: Text(userTask.title, style: aboutCardTitleStyle),
                subtitle: Text(
                    userTask.task.minutesToComplete.toString() + ' min to complete - ' + '?' + ' remaining'),
                //TODO: use the remaining time from model
                onTap: () => userTask.onStart(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoneTaskCard(BuildContext context, UserTask userTask) {
    return Center(
        child: Opacity(
      opacity: 0.6,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 3,
        child: StreamBuilder<UserTaskState>(
          stream: userTask.stateEvents,
          initialData: UserTaskState.initialized,
          builder: (context, AsyncSnapshot<UserTaskState> snapshot) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_circle_outlined, color: Color(0xFF90D88F)),
                title: Text(userTask.title, style: aboutCardTitleStyle),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _scoreBoard(int daysInStudy, int taskCompleted) {
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
