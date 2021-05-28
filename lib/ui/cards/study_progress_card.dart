part of carp_study_app;

class StudyProgressCardWidget extends StatefulWidget {
  final StudyProgressCardDataModel model;

  final List<Color> colors;
  StudyProgressCardWidget(this.model, {this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]});

  @override
  _StudyProgressCardWidgetState createState() => _StudyProgressCardWidgetState();
}

class _StudyProgressCardWidgetState extends State<StudyProgressCardWidget> {
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  static List<charts.Series<StudyProgress, String>> _createChartList(
          BuildContext context, StudyProgressCardDataModel model, List<Color> colors) =>
      [
        charts.Series<StudyProgress, String>(
            colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index]),
            //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
            id: 'completed',
            data: model.progress,
            domainFn: (StudyProgress datum, _) => datum.state,
            measureFn: (StudyProgress datum, _) => datum.value,
            labelAccessorFn: (StudyProgress datum, _) => '${datum.value}'),
        // charts.Series<StudyProgress, String>(
        //   colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index]),
        //   //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
        //   id: 'expired',
        //   data: model.progress,
        //   domainFn: (StudyProgress datum, _) => datum.state,
        //   measureFn: (StudyProgress datum, _) => datum.value,
        // ),
        // charts.Series<StudyProgress, String>(
        //   colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index]),
        //   //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
        //   id: 'pending',
        //   data: model.progress,
        //   domainFn: (StudyProgress datum, _) => datum.state,
        //   measureFn: (StudyProgress datum, _) => datum.value,
        // )
      ];

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);
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
                                  Text(locale.translate('TASKS PROGRESS'),
                                      //textAlign: TextAlign.center,
                                      style: dataCardTitleStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        child: charts.BarChart(
                          _createChartList(context, widget.model, CACHET.COLOR_LIST),
                          barGroupingType: charts.BarGroupingType.groupedStacked,
                          animate: true,
                          vertical: false,
                          barRendererDecorator: charts.BarLabelDecorator<String>(),
                          //domainAxis: charts.OrdinalAxisSpec(renderSpec: renderSpecString),
                          //primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: renderSpecNum),
                          //userManagedState: _myState,
                          defaultInteractions: true,
                          behaviors: [
                            charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
                            charts.DomainHighlighter(),
                          ],
                        ),
                      ),
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
