part of carp_study_app;

class TaskCardWidget extends StatefulWidget {
  final TaskCardViewModel model;
  final List<Color> colors;
  final String chartType;
  TaskCardWidget(this.model, {this.colors = CACHET.COLOR_LIST, this.chartType = "horizontalBar"});
  _TaskCardWidgetState createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  static List<charts.Series<TaskCount, String>> _createChartList(
      BuildContext context, TaskCardViewModel model, List<Color> colors) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return [
      charts.Series<TaskCount, String>(
        colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index!]),
        // charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
        id: 'TotalTasks',
        data: model.taskCount.sublist(0, min(6, model.tasksTable.length)),
        domainFn: (TaskCount taskCount, _) => locale.translate(taskCount.title).truncateTo(12),
        measureFn: (TaskCount taskCount, _) => taskCount.size,
      )
    ];
  }

  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                              '${widget.model.tasksDone} ' +
                                  locale.translate('cards.${widget.model.taskType}.title'),
                              //textAlign: TextAlign.center,
                              style: dataCardTitleStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              chart(context, locale),
            ],
          ),
        ),
      ),
    );
  }

  Widget chart(BuildContext context, RPLocalizations locale) {
    if (this.widget.chartType == "horizontalBar") {
      return Container(
        height: 160,
        child: HorizontalBar(
          names: this.widget.model.taskCount.map((task) => locale.translate(task.title)).toList(),
          values: this.widget.model.taskCount.map((task) => task.size).toList(),
          colors: CACHET.COLOR_LIST,
        ),
      );
    } else if (this.widget.chartType == "pie") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: charts.PieChart<String>(
                _createChartList(context, widget.model, CACHET.COLOR_LIST),
                animate: true,
                behaviors: [
                  charts.ChartTitle(
                    "",
                    behaviorPosition: charts.BehaviorPosition.start,
                    maxWidthStrategy: charts.MaxWidthStrategy.ellipsize,
                    layoutPreferredSize: 10,
                  ),
                  charts.DatumLegend(
                    position: charts.BehaviorPosition.start,
                    desiredMaxRows: 6,
                    horizontalFirst: false,
                    cellPadding: EdgeInsets.only(bottom: 2.0, left: 10),
                    outsideJustification: charts.OutsideJustification.startDrawArea,
                    showMeasures: true,
                    legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                    measureFormatter: (num? value) {
                      return value == null ? '-' : '$value';
                    },
                  ),
                ],
                defaultRenderer: charts.ArcRendererConfig(
                  arcRatio: 0.4,
                  layoutPaintOrder: charts.LayoutViewPaintOrder.arc,
                ),
              ),
            ),
          ),
        ],
      );
    } else
      return SizedBox.shrink();
  }
}
