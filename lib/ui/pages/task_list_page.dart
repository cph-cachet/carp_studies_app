part of carp_study_app;

class TaskListPage extends StatefulWidget {
  final TaskListPageModel model;
  const TaskListPage(this.model);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarpAppBar(),
          _scoreBoard(),
          SizedBox(height: 15),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  locale.translate('MY TASKS'),
                  style: sectionTitleStyle.copyWith(
                      color: Theme.of(context).primaryColor),
                ),
              )),
          SizedBox(height: 15),
          Expanded(
            flex: 4,
            child: StreamBuilder<UserTask>(
              stream: widget.model.userTaskEvents,
              builder: (context, snapshot) {
                // TODO: refresh list when done
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if (widget.model.tasks[index].state !=
                            UserTaskState.done)
                          return _buildTaskCard(
                              context, widget.model.tasks[index]);
                        else
                          return SizedBox.shrink();
                      }, childCount: widget.model.tasks.length),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if (widget.model.tasks[index].state ==
                            UserTaskState.done)
                          return _buildDoneTaskCard(
                              context, widget.model.tasks[index]);
                        else
                          return SizedBox.shrink();
                      }, childCount: widget.model.tasks.length),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, UserTask userTask) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            // child: taskTypeIcon[userTask.type],  // use a type icon
            child: measureTypeIcon[userTask
                .task.measures[0].type.name], // use the 1st measure as an icon
          ),
          title: Text(userTask.title,
              style: aboutCardTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor)),
          subtitle: Text(_subtitle(userTask)),
          onTap: () {
            userTask.onStart(context);
          },
        ),
      ),
    );
  }

  String _subtitle(UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context);
    String str = (userTask?.task?.minutesToComplete != null)
        ? '${userTask.task.minutesToComplete} ' +
            locale.translate('min to complete')
        : '';

    str += (userTask.expiresIn != null)
        ? ' - ${userTask.expiresIn.inDays + 1} ' +
            locale.translate('days remaining')
        : '';

    str = (str.isEmpty) ? userTask.description : str;

    return str;
  }

  Widget _buildDoneTaskCard(BuildContext context, UserTask userTask) {
    return Center(
      child: Opacity(
        opacity: 0.6,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            leading: Icon(Icons.check_circle_outlined, color: CACHET.GREEN_1),
            title: Text(userTask.title,
                style: aboutCardTitleStyle.copyWith(
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  Widget _scoreBoard() {
    RPLocalizations locale = RPLocalizations.of(context);
    return StreamBuilder<UserTask>(
      stream: widget.model.userTaskEvents,
      builder: (context, snapshot) {
        return Expanded(
          child: Container(
            height: 110,
            color: Theme.of(context).accentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(widget.model.daysInStudy.toString(),
                            style: scoreNumberStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(locale.translate('Days in study'),
                            style: scoreTextStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                    Container(
                        height: 66,
                        child: VerticalDivider(
                          color: Theme.of(context).primaryColor,
                          width: 15,
                        )),
                    Column(
                      children: [
                        Text(widget.model.taskCompleted.toString(),
                            style: scoreNumberStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(locale.translate('Tasks completed'),
                            style: scoreTextStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, Icon> get taskTypeIcon => {
        SurveyUserTask.WHO5_SURVEY_TYPE: Icon(
          Icons.design_services,
          color: CACHET.ORANGE,
        ),
        SurveyUserTask.DEMOGRAPHIC_SURVEY_TYPE: Icon(
          Icons.person,
          color: CACHET.ORANGE,
        ),
        SurveyUserTask.SURVEY_TYPE: Icon(
          Icons.description,
          color: CACHET.ORANGE,
        ),
        'audio': Icon(
          Icons.record_voice_over,
          color: CACHET.GREEN,
        ),
        SensingUserTask.SENSING_TYPE: Icon(
          Icons.settings_input_antenna,
          color: CACHET.CACHET_BLUE,
        ),
        SensingUserTask.ONE_TIME_SENSING_TYPE: Icon(
          Icons.settings_input_component,
          color: CACHET.CACHET_BLUE,
        ),
      };

  static Map<String, Icon> get measureTypeIcon => {
        DataType.UNKNOWN: Icon(
          Icons.error,
          color: CACHET.GREY_4,
        ),
        DataType.NONE: Icon(
          Icons.report_problem,
          color: CACHET.GREY_4,
        ),
        DeviceSamplingPackage.MEMORY: Icon(
          Icons.memory,
          color: CACHET.GREY_4,
        ),
        DeviceSamplingPackage.DEVICE: Icon(
          Icons.phone_android,
          color: CACHET.GREY_4,
        ),
        DeviceSamplingPackage.BATTERY: Icon(
          Icons.battery_charging_full,
          color: CACHET.GREEN,
        ),
        SensorSamplingPackage.PEDOMETER: Icon(
          Icons.directions_walk,
          color: CACHET.LIGHT_PURPLE,
        ),
        SensorSamplingPackage.ACCELEROMETER: Icon(
          Icons.adb,
          color: CACHET.GREY_4,
        ),
        SensorSamplingPackage.GYROSCOPE: Icon(
          Icons.adb,
          color: CACHET.GREY_4,
        ),
        SensorSamplingPackage.LIGHT: Icon(
          Icons.highlight,
          color: CACHET.YELLOW,
        ),
        // ConnectivitySamplingPackage.BLUETOOTH:
        //     Icon(Icons.bluetooth_searching, size: 50, color: CACHET.DARK_BLUE),
        // ConnectivitySamplingPackage.WIFI:
        //     Icon(Icons.wifi, size: 50, color: CACHET.LIGHT_PURPLE),
        // ConnectivitySamplingPackage.CONNECTIVITY:
        //     Icon(Icons.cast_connected, size: 50, color: CACHET.GREEN),
        AudioSamplingPackage.AUDIO: Icon(
          Icons.mic,
          color: CACHET.ORANGE,
        ),
        AudioSamplingPackage.NOISE: Icon(
          Icons.hearing,
          color: CACHET.YELLOW,
        ),
        // AppsSamplingPackage.APPS: Icon(Icons.apps, size: 50, color: CACHET.LIGHT_GREEN),
        //AppsSamplingPackage.APP_USAGE: Icon(Icons.get_app, size: 50, color: CACHET.LIGHT_GREEN),
        // CommunicationSamplingPackage.TEXT_MESSAGE: Icon(Icons.text_fields, size: 50, color: CACHET.LIGHT_PURPLE),
        // CommunicationSamplingPackage.TEXT_MESSAGE_LOG: Icon(Icons.textsms, size: 50, color: CACHET.LIGHT_PURPLE),
        // CommunicationSamplingPackage.PHONE_LOG: Icon(Icons.phone_in_talk, size: 50, color: CACHET.ORANGE),
        // CommunicationSamplingPackage.CALENDAR: Icon(Icons.event, size: 50, color: CACHET.CYAN),
        DeviceSamplingPackage.SCREEN: Icon(
          Icons.screen_lock_portrait,
          color: CACHET.LIGHT_PURPLE,
        ),
        ContextSamplingPackage.LOCATION: Icon(
          Icons.location_searching,
          color: CACHET.CYAN,
        ),
        ContextSamplingPackage.GEOLOCATION: Icon(
          Icons.my_location,
          color: CACHET.YELLOW,
        ),
        ContextSamplingPackage.ACTIVITY: Icon(
          Icons.directions_bike,
          color: CACHET.ORANGE,
        ),
        ContextSamplingPackage.WEATHER: Icon(
          Icons.cloud,
          color: CACHET.LIGHT_BLUE_2,
        ),
        ContextSamplingPackage.AIR_QUALITY: Icon(
          Icons.warning,
          color: CACHET.GREY_3,
        ),
        ContextSamplingPackage.GEOFENCE: Icon(
          Icons.location_on,
          color: CACHET.CYAN,
        ),
        ContextSamplingPackage.MOBILITY: Icon(
          Icons.location_on,
          color: CACHET.ORANGE,
        ),
        SurveySamplingPackage.SURVEY: Icon(
          Icons.description,
          color: CACHET.ORANGE,
        ),
      };

  static Map<UserTaskState, Icon> get taskStateIcon => {
        UserTaskState.initialized: Icon(Icons.stream, color: CACHET.YELLOW),
        UserTaskState.enqueued: Icon(Icons.notifications, color: CACHET.YELLOW),
        UserTaskState.dequeued: Icon(Icons.stop, color: CACHET.YELLOW),
        UserTaskState.started: Icon(Icons.play_arrow, color: CACHET.GREY_4),
        UserTaskState.canceled: Icon(Icons.pause, color: CACHET.GREY_4),
        UserTaskState.done: Icon(Icons.check, color: CACHET.GREEN),
      };
}
