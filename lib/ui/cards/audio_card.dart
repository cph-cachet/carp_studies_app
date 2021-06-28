part of carp_study_app;

class AudioCardWidget extends StatefulWidget {
  // final AudioCardDataModel model;
  final TaskCardDataModel model;
  final List<Color> colors;
  AudioCardWidget(this.model, {this.colors = CACHET.COLOR_LIST});
  _AudioCardWidgetState createState() => _AudioCardWidgetState();
}

class _AudioCardWidgetState extends State<AudioCardWidget> {
  static List<charts.Series<TaskCount, String>> _createChartList(
          BuildContext context, TaskCardDataModel model, List<Color> colors) =>
      [
        charts.Series<TaskCount, String>(
          colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index]),
          //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
          id: 'TotalAudio',
          data: model.taskCount.sublist(0, min(7, model.tasksTable.length)),
          domainFn: (TaskCount taskCount, _) => taskCount.title,
          measureFn: (TaskCount taskCount, _) => taskCount.size,
        )
      ];

  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
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
                              Text(
                                  '${widget.model.tasksDone} ' +
                                      locale.translate('cards.audio.title'),
                                  //textAlign: TextAlign.center,
                                  style: dataCardTitleStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        charts.PieChart(
                          _createChartList(
                              context, widget.model, CACHET.COLOR_LIST),
                          animate: true,
                          behaviors: [
                            charts.DatumLegend(
                              position: charts.BehaviorPosition.bottom,
                              //desiredMaxRows: 7,
                              desiredMaxColumns: 1,
                              entryTextStyle:
                                  charts.TextStyleSpec(fontSize: 12),
                              cellPadding:
                                  EdgeInsets.only(right: 3.0, bottom: 2.0),
                              showMeasures: true,
                              legendDefaultMeasure:
                                  charts.LegendDefaultMeasure.firstValue,
                              measureFormatter: (num value) {
                                return value == null ? '-' : '$value';
                              },
                            ),
                          ],
                          defaultRenderer: charts.ArcRendererConfig(
                            arcWidth: 20,
                          ),
                        ),
                        /* Positioned(
                              left: 92,
                              child: Text(
                                '${widget.model.samplingSize} \nmeasures',
                                textAlign: TextAlign.center,
                                style: measuresStyle.copyWith(color: Theme.of(context).primaryColor),
                              ),
                            ), */
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
