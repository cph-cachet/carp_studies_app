part of carp_study_app;

class ActivityCardWidget extends StatefulWidget {
  final ActivityCardDataModel model;
  ActivityCardWidget(this.model);
  _ActivityCardWidgetState createState() => _ActivityCardWidgetState();
}

class _ActivityCardWidgetState extends State<ActivityCardWidget> {
  final List<Color> colors = [
    Color.fromRGBO(12, 70, 128, 1),
    Color.fromRGBO(33, 146, 201, 1),
    Color.fromRGBO(130, 206, 233, 1)
  ];

  List<charts.Series<Activity, String>> _createChartList(BuildContext context, ActivityCardDataModel model) {
    List<Activity> _running = [];
    List<Activity> _walking = [];
    List<Activity> _cycling = [];

    model._activities.forEach((k, v) {
      if (k == ActivityType.RUNNING)
        _running = v.entries.map((entry) => Activity(entry.key, entry.value)).toList();
      else if (k == ActivityType.WALKING)
        _walking = v.entries.map((entry) => Activity(entry.key, entry.value)).toList();
      else if (k == ActivityType.ON_BICYCLE)
        _cycling = v.entries.map((entry) => Activity(entry.key, entry.value)).toList();
    });
    _running = _running.map((entry) => Activity(entry.day, entry.minutes)).toList();
    _walking = _walking.map((entry) => Activity(entry.day, entry.minutes)).toList();
    _cycling = _cycling.map((entry) => Activity(entry.day, entry.minutes)).toList();
    return [
      charts.Series<Activity, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
        id: 'walking',
        data: _walking,
        domainFn: (Activity datum, _) => datum.toString(),
        measureFn: (Activity datum, _) => datum.minutes,
      ),
      charts.Series<Activity, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[1]),
        id: 'running',
        data: _running,
        domainFn: (Activity datum, _) => datum.toString(),
        measureFn: (Activity datum, _) => datum.minutes,
      ),
      charts.Series<Activity, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[2]),
        id: 'cycling',
        data: _cycling,
        domainFn: (Activity datum, _) => datum.toString(),
        measureFn: (Activity datum, _) => datum.minutes,
      )
    ];
  }

  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  final _myState = new charts.UserManagedState<String>();

  num _walk = 0;
  num _run = 0;
  num _cycle = 0;

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
              CardHeader(
                title: 'Activity',
                iconAssetName: Icon(Icons.fitness_center, color: Theme.of(context).primaryColor),
                heroTag: 'activity-card',
                values: ['$_walk min walking', '$_run min running', '$_cycle min cycling'],
                colors: colors,
              ),
              Container(
                height: 160,
                child: charts.BarChart(
                  _createChartList(context, widget.model),
                  barGroupingType: charts.BarGroupingType.stacked,
                  animate: true,
                  /* defaultRenderer: charts.BarRendererConfig<String>(
                    cornerStrategy: const charts.ConstCornerStrategy(2),
                  ), */
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: renderSpecString,
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: renderSpecNum),
                  userManagedState: _myState,
                  defaultInteractions: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        updatedListener: (charts.SelectionModel model) {
                          _myState.selectionModels[charts.SelectionModelType.info] =
                              charts.UserManagedSelectionModel(model: model);
                        },
                        changedListener: _infoSelectionModelChanged)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _infoSelectionModelChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    final measures = <String, num>{};
    if (selectedDatum.isNotEmpty) {
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.minutes;
      });
    }
    setState(() {});

    measures.forEach((k, v) {
      if (k == 'walking')
        _walk = v;
      else if (k == 'running')
        _run = v;
      else if (k == 'cycling') _cycle = v;
    });
  }
}
