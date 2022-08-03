part of carp_study_app;

class MeasuresCardWidget extends StatefulWidget {
  final MeasuresCardViewModel model;
  final List<Color> colors;
  MeasuresCardWidget(this.model, {this.colors = CACHET.COLOR_LIST});
  _MeasuresCardWidgetState createState() => _MeasuresCardWidgetState();
}

extension StringExtension on String {
  String truncateTo(int maxLength) =>
      (this.length <= maxLength) ? this : '${this.substring(0, maxLength)}...';
}

class _MeasuresCardWidgetState extends State<MeasuresCardWidget> {
  static List<charts.Series<MeasureCount, String>> _createChartList(
      BuildContext context, MeasuresCardViewModel model, List<Color> colors) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return [
      charts.Series<MeasureCount, String>(
        colorFn: (_, index) => charts.ColorUtil.fromDartColor(colors[index!]),
        //charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
        id: 'TotalMeasures',
        data: model.measures.sublist(0, min(6, model.samplingTable.length)),
        domainFn: (MeasureCount measures, _) => locale.translate(measures.title), //.truncateTo(12),
        measureFn: (MeasureCount measures, _) => measures.size,
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
              StreamBuilder(
                stream: widget.model.quietMeasureEvents,
                builder: (context, AsyncSnapshot<DataPoint> snapshot) {
                  return Column(
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
                      SingleChildScrollView(
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
