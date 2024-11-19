part of carp_study_app;

class StudyPage extends StatefulWidget {
  static const String route = '/study';
  final StudyPageViewModel model;
  const StudyPage({super.key, required this.model});

  @override
  StudyPageState createState() => StudyPageState();
}

class StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).extension<CarpColors>()!.backgroundGray,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: const CarpAppBar(hasProfileIcon: true),
            ),
            Flexible(
              child: StreamBuilder<int>(
                stream: widget.model.messageStream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.wait([
                        bloc.refreshMessages(),
                        bloc.deploymentService.getStudyDeploymentStatus(
                            widget.model.studyDeploymentId),
                      ]);
                    },
                    child: ListView.builder(
                      // This is +2 bc the first two cards are the study card and the study status card
                      itemCount: bloc.messages.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _studyCard(
                            context,
                            widget.model.studyDescriptionMessage,
                            onTap: () {
                              context.push(StudyDetailsPage.route);
                            },
                          );
                        }
                        if (index == 1) {
                          return _studyStatusCard();
                        }
                        // This is -2 bc the first two cards are the study card and the study status card and we don't want to show them in the list
                        return _announcementCard(
                            context, bloc.messages[index - 2]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _studyCard(
    BuildContext context,
    Message message, {
    Function? onTap,
  }) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Initialization the language of the tiemago package
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());

    return StudiesMaterial(
      backgroundColor: Theme.of(context).extension<CarpColors>()!.grey50!,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            context.push('${MessageDetailsPage.route}/${message.id}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (message.image != null && message.image != '')
                Center(
                  child: Container(
                    height: 150.0,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary, //Color(0xFFF1F9FF),
                    child: widget.model.getMessageImage(message.image),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(locale.translate(message.title!),
                    style: aboutStudyCardTitleStyle.copyWith(
                        color: Theme.of(context)
                            .extension<CarpColors>()!
                            .primary)),
              ),
              if (message.subTitle != null && message.subTitle!.isNotEmpty)
                Row(children: [
                  Expanded(
                    child: Text(
                      locale.translate(message.subTitle!),
                      style: aboutCardContentStyle.copyWith(
                        color:
                            Theme.of(context).extension<CarpColors>()!.grey700,
                      ),
                    ),
                  ),
                ]),
              if (message.message != null && message.message!.isNotEmpty)
                Row(children: [
                  Expanded(
                      child: Text(
                    "${locale.translate(message.message!).substring(0, (message.message!.length > 150) ? 150 : null)}...",
                    style: aboutCardContentStyle.copyWith(
                        color:
                            Theme.of(context).extension<CarpColors>()!.grey900),
                    textAlign: TextAlign.start,
                  )),
                ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _studyStatusCard() {
    return FutureBuilder<StudyDeploymentStatus?>(
      future: bloc.deploymentService
          .getStudyDeploymentStatus(widget.model.studyDeploymentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Spacer();
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if the future fails
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text(
              'No deployment status available'); // Handle the case where data is null
        }

        final deploymentStatus = snapshot.data!.status;

        return Card(
          margin: const EdgeInsets.all(16.0),
          color: Theme.of(context).extension<CarpColors>()!.grey50,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).extension<CarpColors>()!.grey600!,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16.0)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 22.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 4),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    studyStatusColors[deploymentStatus],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Text(
                                deploymentStatus.toString().split('.').last,
                                style: aboutCardSubtitleStyle.copyWith(
                                    color: studyStatusColors[deploymentStatus]),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('This is random text.',
                                style: aboutCardSubtitleStyle.copyWith(
                                    color: Theme.of(context)
                                        .extension<CarpColors>()!
                                        .grey900)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Map<StudyDeploymentStatusTypes, Color> studyStatusColors = {
    StudyDeploymentStatusTypes.Invited: CACHET.DEPLOYMENT_INVITED,
    StudyDeploymentStatusTypes.DeployingDevices: CACHET.DEPLOYMENT_DEPLOYING,
    StudyDeploymentStatusTypes.DeploymentReady: CACHET.DEPLOYMENT_RUNNING,
    StudyDeploymentStatusTypes.Stopped: CACHET.DEPLOYMENT_STOPPED,
  };

  Widget _announcementCard(
    BuildContext context,
    Message message, {
    Function? onTap,
  }) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Initialization the language of the tiemago package
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());

    return Container(
      child: StudiesMaterial(
        backgroundColor: Theme.of(context).extension<CarpColors>()!.grey50!,
        hasBox: true,
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap();
            } else {
              context.push('${MessageDetailsPage.route}/${message.id}');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(locale.translate(message.title!),
                          style: aboutCardTitleStyle.copyWith(
                              color: Theme.of(context)
                                  .extension<CarpColors>()!
                                  .grey900)),
                    ),
                    Spacer(),
                    Material(
                      color: CACHET.DEPLOYMENT_DEPLOYING,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            locale.translate(message.type
                                .toString()
                                .split('.')
                                .last
                                .toLowerCase()),
                            style: aboutCardSubtitleStyle.copyWith(
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      if (message.subTitle != null &&
                          message.subTitle!.isNotEmpty)
                        Expanded(
                          child: Text(
                            locale.translate(message.subTitle!),
                            style: aboutCardContentStyle.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      Spacer(),
                      Text(
                        timeago.format(message.timestamp.toLocal()),
                        style: aboutCardTimeAgoStyle.copyWith(
                          color: Theme.of(context)
                              .extension<CarpColors>()!
                              .grey600,
                        ),
                      )
                    ],
                  ),
                ),
                if (message.message != null && message.message!.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        locale.translate(message.message!).length > 150
                            ? '${locale.translate(message.message!).substring(0, 150)}...'
                            : locale.translate(message.message!),
                        style: aboutCardContentStyle,
                        textAlign: TextAlign.start,
                      )),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension CopyWithAdditional on DateTime {
  DateTime copyWithAdditional({
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    return DateTime(
      year + years,
      month + months,
      day + days,
      hour + hours,
      minute + minutes,
      second + seconds,
      millisecond + milliseconds,
      microsecond + microseconds,
    );
  }
}
