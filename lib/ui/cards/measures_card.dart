part of carp_study_app;

class MeasuresCardWidget extends StatefulWidget {
  final MeasuresCardViewModel model;
  final List<Color> colors;
  MeasuresCardWidget(this.model, {this.colors = CACHET.COLOR_LIST});
  _MeasuresCardWidgetState createState() => _MeasuresCardWidgetState();
}

class _MeasuresCardWidgetState extends State<MeasuresCardWidget> {
  static List<charts.Series<MeasureCount, String>> _createChartList(
          BuildContext context, MeasuresCardViewModel model, List<Color> colors) =>
      [
        charts.Series<MeasureCount, String>(
          colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index!]),
          //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
          id: 'TotalMeasures',
          data: model.measures.sublist(0, min(7, model.samplingTable.length)),
          domainFn: (MeasureCount measures, _) => measures.measure,
          measureFn: (MeasureCount measures, _) => measures.size,
        )
      ];

  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Get the measures with more events to prioritize which ones to show

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: widget.model.quietMeasureEvents,
                builder: (context, AsyncSnapshot<DataPoint> snapshot) {
                  widget.model.orderedMeasures();
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
                                  Text(
                                      '${widget.model.samplingSize} ' +
                                          locale.translate('cards.measures.title'),
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            charts.PieChart<String>(
                              _createChartList(context, widget.model, CACHET.COLOR_LIST),
                              animate: true,
                              behaviors: [
                                charts.DatumLegend(
                                  position: charts.BehaviorPosition.end,
                                  desiredMaxRows: 7,
                                  //entryTextStyle: charts.TextStyleSpec(fontSize: 10),
                                  cellPadding: EdgeInsets.only(right: 3.0, bottom: 2.0),
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
