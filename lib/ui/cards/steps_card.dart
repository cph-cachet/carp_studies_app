part of carp_study_app;

class StepsCardWidget extends StatefulWidget {
  final StepsCardDataModel model;
  StepsCardWidget(this.model);

  _StepsCardWidgetState createState() => _StepsCardWidgetState();
}

class _StepsCardWidgetState extends State<StepsCardWidget> {
  static List<charts.Series<Steps, String>> _createChartList(BuildContext context, StepsCardDataModel model) {
    List<Steps> _steps = model._weeklySteps.entries.map((entry) => Steps(entry.key, entry.value)).toList();
    return [
      charts.Series<Steps, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: 'DailyStepsList',
        data: _steps,
        domainFn: (Steps datum, _) => datum.toString(),
        measureFn: (Steps datum, _) => datum.steps,
      )
    ];
  }

  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  @override
  Widget build(BuildContext context) {
    print(widget.model.toString());
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
                stream: widget.model._controller.events,
                builder: (context, AsyncSnapshot<Datum> snapshot) {
                  return Column(
                    children: [
                      CardHeader(
                          title: 'Steps',
                          iconAssetName: Icon(Icons.directions_walk, color: Theme.of(context).primaryColor),
                          heroTag: 'steps-card',
                          value: '${widget.model._lastStep} steps'),
                      Container(
                          height: 160,
                          child: charts.BarChart(
                            _createChartList(context, widget.model),
                            animate: true,
                            defaultRenderer: charts.BarRendererConfig<String>(
                              cornerStrategy: const charts.ConstCornerStrategy(10),
                            ),
                            domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: renderSpecString,
                            ),
                            primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: renderSpecNum),
                          )),
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
