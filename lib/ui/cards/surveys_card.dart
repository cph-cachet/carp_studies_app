part of carp_study_app;

class SurveysCardWidget extends StatefulWidget {
  final SurveysCardDataModel model;
  SurveysCardWidget(this.model);
  _SurveysCardWidgetState createState() => _SurveysCardWidgetState();
}

class _SurveysCardWidgetState extends State<SurveysCardWidget> {
  static List<charts.Series<Surveys, String>> _createChartList(
    BuildContext context,
    SurveysCardDataModel model,
  ) =>
      [
        charts.Series<Surveys, String>(
          colorFn: (_, index) =>
              charts.MaterialPalette.blue.makeShades(min(7, model.samplingTable.length))[index],
          id: 'TotalSurveys',
          data: model.measures.sublist(0, min(7, model.samplingTable.length)),
          domainFn: (Surveys datum, _) => datum.surveyName,
          measureFn: (Surveys datum, _) => datum.size,
        )
      ];

  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);

    // Get the measures with more events to prioritize which ones to show
    widget.model.updateMeasures();
    widget.model.orderedMeasures();
    //print(widget.model.samplingTable);
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
                stream: widget.model.measureEvents,
                builder: (context, AsyncSnapshot<Datum> snapshot) {
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
                                  Text('${widget.model.samplingSize} ' + locale.translate('SURVEYS'),
                                      //textAlign: TextAlign.center,
                                      style: dataCardTitleStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 250,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            charts.PieChart(
                              _createChartList(context, widget.model),
                              animate: true,
                              behaviors: [
                                charts.DatumLegend(
                                  position: charts.BehaviorPosition.bottom,
                                  //desiredMaxRows: 7,
                                  desiredMaxColumns: 1,
                                  entryTextStyle: charts.TextStyleSpec(fontSize: 12),
                                  cellPadding: EdgeInsets.only(right: 3.0, bottom: 2.0),
                                  showMeasures: true,
                                  legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
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
