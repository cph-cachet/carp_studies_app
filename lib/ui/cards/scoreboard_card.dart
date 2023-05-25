part of carp_study_app;

class ScoreboardCardWidget extends StatefulWidget {
  final TaskListPageViewModel model;
  const ScoreboardCardWidget(this.model, {super.key});
  @override
  ScoreboardCardWidgetState createState() => ScoreboardCardWidgetState();
}

class ScoreboardCardWidgetState extends State<ScoreboardCardWidget> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      height: 110,
      child: StreamBuilder<UserTask>(
        stream: widget.model.userTaskEvents,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(widget.model.daysInStudy.toString(),
                          style: scoreNumberStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                      Text(locale.translate('cards.scoreboard.days'),
                          style: scoreTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  SizedBox(
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
                      Text(locale.translate('cards.scoreboard.tasks'),
                          style: scoreTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
