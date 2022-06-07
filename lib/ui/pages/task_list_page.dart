part of carp_study_app;

class TaskListPage extends StatefulWidget {
  final TaskListPageViewModel model;
  const TaskListPage(this.model);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarpAppBar(),
          // _scoreBoard(),
          // SizedBox(height: 15),

          Expanded(
            flex: 4,
            child: StreamBuilder<UserTask>(
              stream: widget.model.userTaskEvents,
              builder: (context, snapshot) {
                if (widget.model.tasks.isEmpty) {
                  return _noTasks(context);
                } else {
                  return CustomScrollView(
                    slivers: [
                      //CarpBanner(),
                      SliverToBoxAdapter(
                          child: ScoreboardCardWidget(widget.model)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              locale.translate('pages.task_list.title'),
                              style: sectionTitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      // SliverToBoxAdapter(
                      //   child: SizedBox(height: 15),
                      // ),
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
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          if (widget.model.tasks[index].state ==
                              UserTaskState.expired)
                            return _buildExpiredTaskCard(
                                context, widget.model.tasks[index]);
                          else
                            return SizedBox.shrink();
                        }, childCount: widget.model.tasks.length),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).hoverColor,
            child: _taskTypeIcon(userTask),
          ),
          title: Text(locale.translate(userTask.title),
              style: aboutCardTitleStyle.copyWith(
                  color: Theme.of(context).primaryColor)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(_subtitle(userTask),
                  style: aboutCardSubtitleStyle.copyWith(
                      color: Theme.of(context).primaryColor)),
              SizedBox(height: 5),
              Text(locale.translate(userTask.description)),
            ],
          ),
          onTap: () {
            userTask.onStart(context);
          },
        ),
      ),
    );
  }

  /// Get an icon for the [userTask] based on its type. If there is no icon for
  /// the type, use the 1st measure in the task as an icon. If there is no
  /// icon for the measure, use a default icon.
  Icon _taskTypeIcon(UserTask userTask) =>
      (taskTypeIcons[userTask.type] != null)
          ? taskTypeIcons[userTask.type] as Icon
          : (measureTypeIcons[userTask.task.measures[0].type] != null)
              ? measureTypeIcons[userTask.task.measures[0].type] as Icon
              : Icon(
                  Icons.description_outlined,
                  color: CACHET.ORANGE,
                );

  String _subtitle(UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    String str = (userTask.task.minutesToComplete != null)
        ? '${userTask.task.minutesToComplete} ' +
            locale.translate('pages.task_list.task.time_to_complete')
        : locale.translate('pages.task_list.task.auto_complete');

    str += (userTask.expiresIn != null)
        ? ' - ${userTask.expiresIn!.inDays + 1} ' +
            locale.translate('pages.task_list.task.days_remaining')
        : '';

    str = (str.isEmpty) ? locale.translate(userTask.description) : str;

    return str;
  }

  Widget _buildDoneTaskCard(BuildContext context, UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Center(
      child: Opacity(
        opacity: 0.6,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: CACHET.LIGHT_GREEN_1,
              child: Icon(Icons.check_circle_outlined, color: CACHET.GREEN_1),
            ),
            title: Text(locale.translate(userTask.title),
                style: aboutCardTitleStyle.copyWith(
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  Widget _buildExpiredTaskCard(BuildContext context, UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Center(
      child: Opacity(
        opacity: 0.6,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: CACHET.LIGHT_GREY_1,
              child: Icon(Icons.unpublished_outlined, color: CACHET.GREY_1),
            ),
            title: Text(locale.translate(userTask.title),
                style: aboutCardTitleStyle.copyWith(
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }

  Widget _noTasks(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Ink(
          width: 60,
          height: 60,
          decoration: const ShapeDecoration(
            color: CACHET.GREY_1,
            shape: CircleBorder(),
          ),
          child: Icon(
            Icons.playlist_add_check,
            color: Colors.white,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              locale.translate("pages.task_list.no_tasks"),
              style: aboutCardSubtitleStyle,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  static Map<String, Icon> taskTypeIcons = {
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
    AudioUserTask.AUDIO_TYPE: Icon(
      Icons.record_voice_over,
      color: CACHET.GREEN,
    ),
    VideoUserTask.VIDEO_TYPE: Icon(
      Icons.camera_alt,
      color: CACHET.BLUE_1,
    ),
    BackgroundSensingUserTask.SENSING_TYPE: Icon(
      Icons.settings_input_antenna,
      color: CACHET.CACHET_BLUE,
    ),
    BackgroundSensingUserTask.ONE_TIME_SENSING_TYPE: Icon(
      Icons.settings_input_component,
      color: CACHET.PURPLE,
    ),
  };

  static Map<String, Icon> measureTypeIcons = {
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
    MediaSamplingPackage.AUDIO: Icon(
      Icons.mic,
      color: CACHET.ORANGE,
    ),
    MediaSamplingPackage.NOISE: Icon(
      Icons.hearing,
      color: CACHET.YELLOW,
    ),
    MediaSamplingPackage.VIDEO: Icon(
      Icons.camera_alt,
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
      Icons.air,
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
