part of carp_study_app;

class ActivityCard extends StatefulWidget {
  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class Activity {
  final DateTime date;
  final int minutes;
  Activity(this.date, this.minutes);
}

class _ActivityCardState extends State<ActivityCard> {
  static List<charts.Series<Activity, DateTime>> _createChartList(BuildContext context) {
    final randomWalkData = [
      new Activity(DateTime.now().add(Duration(days: 1)), 90),
      new Activity(DateTime.now().add(Duration(days: 2)), 100),
      new Activity(DateTime.now().add(Duration(days: 3)), 120),
      new Activity(DateTime.now().add(Duration(days: 4)), 50),
    ];
    final randomRunData = [
      new Activity(DateTime.now().add(Duration(days: 1)), 30),
      new Activity(DateTime.now().add(Duration(days: 2)), 0),
      new Activity(DateTime.now().add(Duration(days: 3)), 0),
      new Activity(DateTime.now().add(Duration(days: 4)), 30),
    ];
    final randomBikeData = [
      new Activity(DateTime.now().add(Duration(days: 1)), 20),
      new Activity(DateTime.now().add(Duration(days: 2)), 40),
      new Activity(DateTime.now().add(Duration(days: 3)), 20),
      new Activity(DateTime.now().add(Duration(days: 4)), 20),
    ];

    return [
      charts.Series<Activity, DateTime>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor).darker.darker,
        id: 'DailyWalkList',
        data: randomWalkData,
        domainFn: (Activity datum, _) => datum.date,
        measureFn: (Activity datum, _) => datum.minutes,
      ),
      charts.Series<Activity, DateTime>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor),
        id: 'DailyRunList',
        data: randomRunData,
        domainFn: (Activity datum, _) => datum.date,
        measureFn: (Activity datum, _) => datum.minutes,
      ),
      charts.Series<Activity, DateTime>(
        colorFn: (d, i) =>
            charts.ColorUtil.fromDartColor(Theme.of(context).primaryColor).lighter.lighter.lighter.lighter,
        id: 'DailyBikeList',
        data: randomBikeData,
        domainFn: (Activity datum, _) => datum.date,
        measureFn: (Activity datum, _) => datum.minutes,
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
                  title: 'Activity',
                  iconAssetName: Icon(Icons.fitness_center, color: Theme.of(context).primaryColor),
                  heroTag: 'activity-card',
                  value: '43 min running'),
              Container(
                height: 160,
                child: charts.TimeSeriesChart(
                  _createChartList(context),
                  defaultRenderer: charts.BarRendererConfig<DateTime>(
                      cornerStrategy: const charts.ConstCornerStrategy(10),
                      groupingType: charts.BarGroupingType.grouped),
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
