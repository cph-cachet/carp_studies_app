part of carp_study_app;

class ActivityCardWidget extends StatefulWidget {
  final ActivityCardDataModel model;
  final List<charts.Series<Activity, String>> seriesList;
  final List<Color> colors;
  ActivityCardWidget(this.seriesList, this.model,
      {this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]});

  factory ActivityCardWidget.withSampleData(ActivityCardDataModel model) {
    return ActivityCardWidget(_createChartList(model, [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]), model);
  }

  static List<charts.Series<Activity, String>> _createChartList(
      ActivityCardDataModel model, List<Color> colors) {
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

  @override
  _ActivityCardWidgetState createState() => _ActivityCardWidgetState();
}

class _ActivityCardWidgetState extends State<ActivityCardWidget> {
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  num _walk = 0;
  num _run = 0;
  num _cycle = 0;

  @override
  void initState() {
    // Get current day activities
    _walk = widget.model._activities[ActivityType.WALKING][DateTime.now().weekday];
    _run = widget.model._activities[ActivityType.RUNNING][DateTime.now().weekday];
    _cycle = widget.model._activities[ActivityType.ON_BICYCLE][DateTime.now().weekday];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.model.toString());
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
                colors: widget.colors,
              ),
              Container(
                height: 160,
                child: charts.BarChart(
                  widget.seriesList,
                  barGroupingType: charts.BarGroupingType.stacked,
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(renderSpec: renderSpecString),
                  primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: renderSpecNum),
                  //userManagedState: _myState,
                  defaultInteractions: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        /* updatedListener: (charts.SelectionModel model) {
                                  _myState.selectionModels[charts.SelectionModelType.info] =
                                      charts.UserManagedSelectionModel(model: model);
                                }, */
                        changedListener: _infoSelectionModelChanged)
                  ],
                  behaviors: [
                    charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
                    charts.DomainHighlighter(),
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

class ActivityOuterStatefulWidget extends StatefulWidget {
  final ActivityCardDataModel model;
  ActivityOuterStatefulWidget(this.model);

  @override
  _ActivityOuterStatefulWidgetState createState() => _ActivityOuterStatefulWidgetState();
}

class _ActivityOuterStatefulWidgetState extends State<ActivityOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ActivityCardWidget.withSampleData(widget.model);
  }
}
