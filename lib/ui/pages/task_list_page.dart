part of carp_study_app;

class TaskListPage extends StatefulWidget {
  static const String route = '/tasks';
  final TaskListPageViewModel model;
  const TaskListPage({super.key, required this.model});

  @override
  TaskListPageState createState() => TaskListPageState();
}

/// Custom SliverAppBarDelegate class
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).extension<CarpColors>()!.tabBarBackground,
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TaskListPageState extends State<TaskListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            Theme.of(context).extension<CarpColors>()!.backgroundGray,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const CarpAppBar(hasProfileIcon: true),
              ),
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
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  locale.translate('pages.task_list.title'),
                                  style: dataCardTitleStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          // Scoreboard showing days in study and tasks completed
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 6, left: 40, right: 40),
                            sliver: ScoreboardCard(widget.model),
                          ),
                          // Tab holder
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 24, left: 64, right: 64),
                            sliver: SliverPersistentHeader(
                              delegate: _SliverAppBarDelegate(
                                TabBar(
                                  controller: _tabController,
                                  labelPadding: const EdgeInsets.only(
                                      top: 4, bottom: 4, left: 4, right: 4),
                                  dividerColor: Colors.transparent,
                                  indicator: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  tabs: [
                                    Container(
                                      width: double.infinity,
                                      child: Tab(
                                        text: locale.translate(
                                            'pages.task_list.pending'),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Tab(
                                        text: locale.translate(
                                            'pages.task_list.completed'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pinned: true,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                UserTask userTask = widget.model.tasks[index];
                                if (_tabController.index == 0) {
                                  if (userTask.availableForUser) {
                                    return _buildAvailableTaskCard(
                                        context, userTask);
                                  }
                                } else if (_tabController.index == 1) {
                                  if (userTask.state == UserTaskState.done) {
                                    return _buildDoneTaskCard(
                                        context, userTask);
                                  } else if (userTask.state ==
                                      UserTaskState.expired) {
                                    return _buildExpiredTaskCard(
                                        context, userTask);
                                  }
                                }
                                return const SizedBox.shrink();
                              },
                              childCount: widget.model.tasks.length,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableTaskCard(BuildContext context, UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Center(
      child: GestureDetector(
        child: StudiesMaterial(
          hasBorder: true,
          borderColor: taskTypeColors[userTask.type]!,
          backgroundColor:
              userTask.expiresIn != null && userTask.expiresIn!.inHours < 24
                  ? CACHET.TASK_TO_EXPIRE_BACKGROUND
                  : Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(width: 12.0), // Space between line and content
                  Expanded(
                    // Allows the content to take remaining space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _taskTypeIcon(userTask),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                userTask.type,
                                style: TextStyle(
                                  color: taskTypeColors[userTask.type],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (_timeRemainingSubtitle(userTask).isNotEmpty)
                              Icon(
                                Icons.alarm,
                                color: userTask.expiresIn != null &&
                                        userTask.expiresIn!.inHours < 24
                                    ? Theme.of(context)
                                        .extension<CarpColors>()!
                                        .warningColor
                                    : Colors.grey,
                              ),
                            const SizedBox(width: 4.0),
                            Text(
                              _timeRemainingSubtitle(userTask),
                              style: TextStyle(
                                color: userTask.expiresIn != null &&
                                        userTask.expiresIn!.inHours < 24
                                    ? Theme.of(context)
                                        .extension<CarpColors>()!
                                        .warningColor
                                    : Colors.grey,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.translate(userTask.title),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                locale.translate(userTask.description),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _estimatedTimeSubtitle(userTask),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          // only start if not already started, done, or expired
          if (userTask.state == UserTaskState.enqueued ||
              userTask.state == UserTaskState.canceled) {
            userTask.onStart();
            if (userTask.hasWidget) context.push('/task/${userTask.id}');
          }
        },
      ),
    );
  }

  /// Get an icon for the [userTask] based on its type. If there is no icon for
  /// the type, use the 1st measure in the task as an icon. If there is no
  /// icon for the measure, use a default icon.
  Icon _taskTypeIcon(UserTask userTask) =>
      (taskTypeIcons[userTask.type] != null)
          ? taskTypeIcons[userTask.type] as Icon
          : (userTask.task.measures!.isNotEmpty &&
                  measureTypeIcons[userTask.task.measures![0].type] != null)
              ? measureTypeIcons[userTask.task.measures![0].type] as Icon
              : const Icon(
                  Icons.description_outlined,
                  color: CACHET.ORANGE,
                );

  String _estimatedTimeSubtitle(UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    String subtitle = (userTask.task.minutesToComplete != null)
        ? '${locale.translate('pages.task_list.task.estimated_time')} ${userTask.task.minutesToComplete} min'
        : locale.translate('pages.task_list.task.auto_complete');

    if (userTask.expiresIn != null) {
      if (userTask.expiresIn!.isNegative) {
        userTask.onExpired();
      }
    }

    return subtitle.isEmpty ? locale.translate(userTask.description) : subtitle;
  }

  String _timeRemainingSubtitle(UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    String humanizedTimeRemaining = "";
    if (userTask.expiresIn != null) {
      if (userTask.expiresIn!.isNegative) {
        userTask.onExpired();
      }

      humanizedTimeRemaining = userTask.expiresIn!.humanize(locale);
    }

    return humanizedTimeRemaining.isNotEmpty ? humanizedTimeRemaining : "";
  }

  Widget _buildDoneTaskCard(BuildContext context, UserTask userTask) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Center(
      child: Opacity(
        opacity: 0.6,
        child: StudiesMaterial(
          hasBorder: true,
          child: ListTile(
            leading: const CircleAvatar(
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
        child: StudiesMaterial(
          hasBorder: true,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: CACHET.LIGHT_GREY,
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
          child: const Icon(
            Icons.playlist_add_check,
            color: Colors.white,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              locale.translate("pages.task_list.no_tasks"),
              style: aboutCardSubtitleStyle,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  static Map<String, Icon> taskTypeIcons = {
    SurveyUserTask.SURVEY_TYPE: const Icon(
      Icons.workspaces,
      color: CACHET.TASK_BLUE,
    ),
    SurveyUserTask.COGNITIVE_ASSESSMENT_TYPE: const Icon(
      Icons.psychology,
      color: CACHET.LIGHT_PURPLE,
    ),
    SurveyUserTask.AUDIO_TYPE: const Icon(
      Icons.hearing,
      color: CACHET.GREEN,
    ),
    SurveyUserTask.VIDEO_TYPE: const Icon(
      Icons.videocam,
      color: CACHET.LIGHT_BLUE,
    ),
    SurveyUserTask.IMAGE_TYPE: const Icon(
      Icons.image,
      color: CACHET.YELLOW,
    ),
    SurveyUserTask.HEALTH_ASSESSMENT_TYPE: const Icon(
      Icons.favorite,
      color: CACHET.RED_1,
    ),
    BackgroundSensingUserTask.SENSING_TYPE: const Icon(
      Icons.sensors,
      color: CACHET.LIGHT_BROWN,
    ),
    BackgroundSensingUserTask.ONE_TIME_SENSING_TYPE: const Icon(
      Icons.settings_input_component,
      color: CACHET.PURPLE,
    ),
  };

  static Map<String, Color> taskTypeColors = {
    SurveyUserTask.SURVEY_TYPE: CACHET.TASK_BLUE,
    SurveyUserTask.COGNITIVE_ASSESSMENT_TYPE: CACHET.LIGHT_PURPLE,
    SurveyUserTask.AUDIO_TYPE: CACHET.GREEN,
    SurveyUserTask.VIDEO_TYPE: CACHET.LIGHT_BLUE,
    SurveyUserTask.IMAGE_TYPE: CACHET.YELLOW,
    SurveyUserTask.HEALTH_ASSESSMENT_TYPE: CACHET.RED_1,
    BackgroundSensingUserTask.SENSING_TYPE: CACHET.LIGHT_BROWN,
    BackgroundSensingUserTask.ONE_TIME_SENSING_TYPE: CACHET.PURPLE,
  };

  static Map<String, Icon> measureTypeIcons = {
    DeviceSamplingPackage.FREE_MEMORY: const Icon(
      Icons.memory,
      color: CACHET.GREY_4,
    ),
    DeviceSamplingPackage.DEVICE_INFORMATION: const Icon(
      Icons.phone_android,
      color: CACHET.GREY_4,
    ),
    DeviceSamplingPackage.BATTERY_STATE: const Icon(
      Icons.battery_charging_full,
      color: CACHET.GREEN,
    ),
    SensorSamplingPackage.STEP_COUNT: const Icon(
      Icons.directions_walk,
      color: CACHET.LIGHT_PURPLE,
    ),
    SensorSamplingPackage.ACCELERATION: const Icon(
      Icons.adb,
      color: CACHET.GREY_4,
    ),
    SensorSamplingPackage.ROTATION: const Icon(
      Icons.adb,
      color: CACHET.GREY_4,
    ),
    SensorSamplingPackage.AMBIENT_LIGHT: const Icon(
      Icons.highlight,
      color: CACHET.YELLOW,
    ),
    // ConnectivitySamplingPackage.BLUETOOTH:
    //     Icon(Icons.bluetooth_searching, size: 50, color: CACHET.DARK_BLUE),
    // ConnectivitySamplingPackage.WIFI:
    //     Icon(Icons.wifi, size: 50, color: CACHET.LIGHT_PURPLE),
    // ConnectivitySamplingPackage.CONNECTIVITY:
    //     Icon(Icons.cast_connected, size: 50, color: CACHET.GREEN),
    MediaSamplingPackage.AUDIO: const Icon(
      Icons.mic,
      color: CACHET.GREEN,
    ),
    MediaSamplingPackage.NOISE: const Icon(
      Icons.hearing,
      color: CACHET.YELLOW,
    ),
    MediaSamplingPackage.VIDEO: const Icon(
      Icons.videocam,
      color: CACHET.LIGHT_BLUE,
    ),
    MediaSamplingPackage.IMAGE: const Icon(
      Icons.image,
      color: CACHET.YELLOW,
    ),
    // AppsSamplingPackage.APPS: Icon(Icons.apps, size: 50, color: CACHET.LIGHT_GREEN),
    //AppsSamplingPackage.APP_USAGE: Icon(Icons.get_app, size: 50, color: CACHET.LIGHT_GREEN),
    // CommunicationSamplingPackage.TEXT_MESSAGE: Icon(Icons.text_fields, size: 50, color: CACHET.LIGHT_PURPLE),
    // CommunicationSamplingPackage.TEXT_MESSAGE_LOG: Icon(Icons.textsms, size: 50, color: CACHET.LIGHT_PURPLE),
    // CommunicationSamplingPackage.PHONE_LOG: Icon(Icons.phone_in_talk, size: 50, color: CACHET.ORANGE),
    // CommunicationSamplingPackage.CALENDAR: Icon(Icons.event, size: 50, color: CACHET.CYAN),
    DeviceSamplingPackage.SCREEN_EVENT: const Icon(
      Icons.screen_lock_portrait,
      color: CACHET.LIGHT_PURPLE,
    ),
    ContextSamplingPackage.LOCATION: const Icon(
      Icons.location_searching,
      color: CACHET.CYAN,
    ),
    // ContextSamplingPackage.LOCATION: const Icon(
    //   Icons.my_location,
    //   color: CACHET.YELLOW,
    // ),
    ContextSamplingPackage.ACTIVITY: const Icon(
      Icons.local_fire_department,
      color: CACHET.ORANGE,
    ),
    ContextSamplingPackage.WEATHER: const Icon(
      Icons.cloud,
      color: CACHET.LIGHT_BLUE,
    ),
    ContextSamplingPackage.AIR_QUALITY: const Icon(
      Icons.air,
      color: CACHET.GREY_3,
    ),
    ContextSamplingPackage.GEOFENCE: const Icon(
      Icons.location_on,
      color: CACHET.CYAN,
    ),
    ContextSamplingPackage.MOBILITY: const Icon(
      Icons.location_on,
      color: CACHET.ORANGE,
    ),
    SurveySamplingPackage.SURVEY: const Icon(
      Icons.workspaces,
      color: CACHET.ORANGE,
    ),
  };

  static Map<UserTaskState, Icon> get taskStateIcon => {
        UserTaskState.initialized:
            const Icon(Icons.stream, color: CACHET.YELLOW),
        UserTaskState.enqueued:
            const Icon(Icons.notifications, color: CACHET.YELLOW),
        UserTaskState.dequeued: const Icon(Icons.stop, color: CACHET.YELLOW),
        UserTaskState.started:
            const Icon(Icons.play_arrow, color: CACHET.GREY_4),
        UserTaskState.canceled: const Icon(Icons.pause, color: CACHET.GREY_4),
        UserTaskState.done: const Icon(Icons.check, color: CACHET.GREEN),
      };
}
