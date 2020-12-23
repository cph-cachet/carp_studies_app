part of carp_study_app;

class TaskList extends StatefulWidget {
  final TaskListPageModel model;
  const TaskList(this.model);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .08),
                    CarpAppBar(),
                    Flexible(
                      child: StreamBuilder<UserTask>(
                        stream: widget.model.userTaskEvents,
                        builder: (context, snapshot) {
                          return _scoreBoard(
                            widget.model.daysInStudy,
                            widget.model.taskCompleted,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('MY TASKS', style: sectionTitleStyle),
                        )),
                    SizedBox(height: 15),
                    Flexible(
                      fit: FlexFit.loose,
                      child: StreamBuilder<UserTask>(
                          stream: widget.model.userTaskEvents,
                          builder: (context, snapshot) {
                            // TODO: refresh list when done
                            return CustomScrollView(
                              slivers: <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                    if (widget.model.tasks[index].state != UserTaskState.done)
                                      return _buildTaskCard(context, widget.model.tasks[index]);
                                    else
                                      return SizedBox.shrink();
                                  }, childCount: widget.model.tasks.length),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                    if (widget.model.tasks[index].state == UserTaskState.done)
                                      return _buildDoneTaskCard(context, widget.model.tasks[index]);
                                    else
                                      return SizedBox.shrink();
                                  }, childCount: widget.model.tasks.length),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          });
    });
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
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(Icons.mood_outlined, color: Theme.of(context).primaryColor),
                ),
                title: Text(userTask.title,
                    style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                subtitle: Text(_subtitle(userTask)),
                onTap: () {
                  userTask.onStart(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _subtitle(UserTask userTask) {
    String str = (userTask?.task?.minutesToComplete != null)
        ? '${userTask.task.minutesToComplete} min to complete'
        : '';

    str += (userTask.expiresIn != null) ? ' - ${userTask.expiresIn.inDays + 1} days remaining' : '';

    return str;
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
                  title: Text(userTask.title,
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreBoard(int daysInStudy, int taskCompleted) {
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
              Column(
                children: [
                  Text(daysInStudy.toString(),
                      style: scoreNumberStyle.copyWith(color: Theme.of(context).primaryColor)),
                  Text('Days in study',
                      style: scoreTextStyle.copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
              Container(
                  height: 66,
                  child: VerticalDivider(
                    color: Theme.of(context).primaryColor,
                    width: 80,
                  )),
              Column(
                children: [
                  Text(taskCompleted.toString(),
                      style: scoreNumberStyle.copyWith(color: Theme.of(context).primaryColor)),
                  Text('Task completed',
                      style: scoreTextStyle.copyWith(color: Theme.of(context).primaryColor)),
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
