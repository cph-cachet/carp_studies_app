part of carp_study_app;

class ScoreboardCardWidget extends StatefulWidget {
  final DataVisualizationPageModel model;
  ScoreboardCardWidget(this.model);
  _ScoreboardCardWidgetState createState() => _ScoreboardCardWidgetState();
}

class _ScoreboardCardWidgetState extends State<ScoreboardCardWidget> {
  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 110,
            child: StreamBuilder<UserTask>(
              stream: widget.model.userTaskEvents,
              builder: (context, snapshot) {
                return Column(
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
                            Text(locale.translate('cards.scoreboard.days'),
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
                            Text(locale.translate('cards.scoreboard.tasks'),
                                style: scoreTextStyle.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
