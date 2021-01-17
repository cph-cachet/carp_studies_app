part of carp_study_app;

class StepsCard extends StatefulWidget {
  @override
  _StepsCardState createState() => _StepsCardState();
}

class Steps {
  final DateTime date;
  final int steps;
  Steps(this.date, this.steps);
}

class _StepsCardState extends State<StepsCard> {
  static List<charts.Series<Steps, DateTime>> _createChartList(BuildContext context) {
    final randomStepsData = [
      new Steps(DateTime.now().add(Duration(days: 1)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 2)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 3)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 4)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 5)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 6)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 7)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 8)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 9)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 10)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 11)), Random().nextInt(10000)),
      new Steps(DateTime.now().add(Duration(days: 12)), Random().nextInt(10000)),
    ];

    return [
      charts.Series<Steps, DateTime>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: 'DailyStepsList',
        data: randomStepsData,
        domainFn: (Steps datum, _) => datum.date,
        measureFn: (Steps datum, _) => datum.steps,
      )
    ];
  }

  charts.RenderSpec<num> renderSpecPrimary = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecDomain = AxisTheme.axisThemeDateTime();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CardHeader(
                  title: 'Steps',
                  iconAssetName: Icon(Icons.directions_walk, color: Theme.of(context).primaryColor),
                  heroTag: 'steps-card',
                  value: '9805 steps'),
              Container(
                height: 160,
                child: charts.TimeSeriesChart(
                  _createChartList(context),
                  defaultRenderer: charts.BarRendererConfig<DateTime>(
                    cornerStrategy: const charts.ConstCornerStrategy(10),
                  ),
                  defaultInteractions: false,
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(
                      zeroBound: false,
                    ),
                    renderSpec: renderSpecPrimary,
                  ),
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: renderSpecDomain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
