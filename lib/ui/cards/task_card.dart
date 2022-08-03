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
        domainFn: (TaskCount taskCount, _) => locale.translate(taskCount.title),
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
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          child: charts.PieChart<String>(
            _createChartList(context, widget.model, CACHET.COLOR_LIST),
            animate: true,
            behaviors: [
              charts.DatumLegend(
                position: charts.BehaviorPosition.end,
                desiredMaxRows: 6,
                cellPadding: EdgeInsets.only(right: 1.0, bottom: 2.0),
                showMeasures: true,
                legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                measureFormatter: (num? value) {
                  return value == null ? '-' : '$value';
                },
              ),
            ],
            defaultRenderer: charts.ArcRendererConfig(
              arcWidth: 20,
            ),
          ),
        ),
      );
    } else
      return SizedBox.shrink();
  }
}
