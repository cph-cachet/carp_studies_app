part of carp_study_app;

class StudyProgressCardWidget extends StatefulWidget {
  final StudyProgressCardDataModel model;

  final List<Color> colors;
  StudyProgressCardWidget(this.model, {this.colors = const [CACHET.BLUE_1, CACHET.RED_1, CACHET.BLUE_3]});

  @override
  _StudyProgressCardWidgetState createState() => _StudyProgressCardWidgetState();
}

class _StudyProgressCardWidgetState extends State<StudyProgressCardWidget> {
  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;
    widget.model.updateProgress();
    widget.model.toString();

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: widget.model.userTaskEvents,
                builder: (context, AsyncSnapshot<UserTask> snapshot) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text(locale.translate('cards.study_progress.title'),
                                      style: dataCardTitleStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 160,
                          child: HorizontalBar(
                              names: this.widget.model.progress.map((progress) => progress.state).toList(),
                              values: this.widget.model.progress.map((progress) => progress.value).toList(),
                              colors: widget.colors)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
