part of '../../main.dart';

class StudyProgressCardWidget extends StatefulWidget {
  final StudyProgressCardViewModel model;

  final List<Color> colors;
  const StudyProgressCardWidget(this.model,
      {super.key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_3, CACHET.RED_1]});

  @override
  StudyProgressCardWidgetState createState() => StudyProgressCardWidgetState();
}

class StudyProgressCardWidgetState extends State<StudyProgressCardWidget> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    widget.model.updateProgress();
    return StudiesCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: widget.model.userTaskEvents,
          builder: (context, AsyncSnapshot<UserTask> snapshot) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(locale.translate('cards.study_progress.title'),
                          style: dataCardTitleStyle),
                    ],
                  ),
                ),
                SizedBox(
                    height: 160,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return HorizontalBar(
                        parentWidth: constraints.maxWidth,
                        names: widget.model.progress
                            .map((progress) => locale.translate(progress.state))
                            .toList(),
                        values: widget.model.progress
                            .map((progress) => progress.value)
                            .toList(),
                        colors: widget.colors,
                        order: OrderType.none,
                        labelOrientation: LabelOrientation.horizontal,
                      );
                    })),
              ],
            );
          },
        ),
      ),
    );
  }
}
