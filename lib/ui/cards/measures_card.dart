part of carp_study_app;

class MeasuresCardWidget extends StatefulWidget {
  final MeasuresCardDataModel model;
  MeasuresCardWidget(this.model);
  _MeasuresCardWidgetState createState() => _MeasuresCardWidgetState();
}

class _MeasuresCardWidgetState extends State<MeasuresCardWidget> {
  static List<charts.Series<Measures, String>> _createChartList(
      BuildContext context, MeasuresCardDataModel model) {
    List<Measures> _measures =
        model._samplingTable.entries.map((entry) => Measures(entry.key, entry.value)).toList();
    return [
      charts.Series<Measures, String>(
        //colorFn: (d, i) => charts.MaterialPalette.blue.makeShades(model.samplingSize)[i],
        id: 'DailyStepsList',
        data: _measures,
        domainFn: (Measures datum, _) => datum.measure,
        measureFn: (Measures datum, _) => datum.size,
      )
    ];
  }

  Widget build(BuildContext context) {
    print(widget.model._samplingTable);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      CardHeader(
                          title: 'Measures',
                          iconAssetName: Icon(Icons.emoji_objects, color: Theme.of(context).primaryColor),
                          heroTag: 'measures-card',
                          value: '${widget.model.samplingSize} measures'),
                      Container(
                        height: 160,
                        child: charts.PieChart(
                          _createChartList(context, widget.model),
                          animate: true,
                          behaviors: [
                            charts.DatumLegend(
                              position: charts.BehaviorPosition.end,
                              desiredMaxRows: 8,
                              entryTextStyle: charts.TextStyleSpec(fontSize: 10),
                              cellPadding: new EdgeInsets.only(right: 3.0, bottom: 2.0),
                            ),
                          ],
                          defaultRenderer: charts.ArcRendererConfig(
                            arcWidth: 20,
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
