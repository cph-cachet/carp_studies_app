part of carp_study_app;

class ActivityCardWidget extends StatefulWidget {
  final ActivityCardViewModel model;
  final List<charts.Series<DailyActivity, String>> seriesList;
  final List<Color> colors;
  const ActivityCardWidget(this.seriesList, this.model,
      {super.key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]});

  factory ActivityCardWidget.withSampleData(ActivityCardViewModel model) {
    return ActivityCardWidget(
        _createChartList(model, [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]),
        model);
  }

  static List<charts.Series<DailyActivity, String>> _createChartList(
          ActivityCardViewModel model, List<Color> colors) =>
      [
        charts.Series<DailyActivity, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
          id: 'walking',
          data: model.activitiesByType(ActivityType.WALKING),
          domainFn: (DailyActivity datum, _) => datum.toString(),
          measureFn: (DailyActivity datum, _) => datum.minutes,
        ),
        charts.Series<DailyActivity, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[1]),
          id: 'running',
          data: model.activitiesByType(ActivityType.RUNNING),
          domainFn: (DailyActivity datum, _) => datum.toString(),
          measureFn: (DailyActivity datum, _) => datum.minutes,
        ),
        charts.Series<DailyActivity, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[2]),
          id: 'cycling',
          data: model.activitiesByType(ActivityType.ON_BICYCLE),
          domainFn: (DailyActivity datum, _) => datum.toString(),
          measureFn: (DailyActivity datum, _) => datum.minutes,
        )
      ];

  @override
  ActivityCardWidgetState createState() => ActivityCardWidgetState();
}

class ActivityCardWidgetState extends State<ActivityCardWidget> {
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  num? _walk = 0;
  num? _run = 0;
  num? _cycle = 0;

  @override
  void initState() {
    // Get current day activities
    _walk =
        widget.model.activities[ActivityType.WALKING]![DateTime.now().weekday];
    _run =
        widget.model.activities[ActivityType.RUNNING]![DateTime.now().weekday];
    _cycle = widget
        .model.activities[ActivityType.ON_BICYCLE]![DateTime.now().weekday];
    super.initState();
  }

  @override
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
            children: <Widget>[
              ChartsLegend(
                title: locale.translate('cards.activity.title'),
                iconAssetName: Icon(Icons.fitness_center,
                    color: Theme.of(context).primaryColor),
                heroTag: 'activity-card',
                values: [
                  '$_walk ${locale.translate('cards.activity.walking')}',
                  '$_run ${locale.translate('cards.activity.running')}',
                  '$_cycle ${locale.translate('cards.activity.cycling')}'
                ],
                colors: widget.colors,
              ),
              SizedBox(
                height: 160,
                child: charts.BarChart(
                  widget.seriesList,
                  barGroupingType: charts.BarGroupingType.stacked,
                  animate: true,
                  domainAxis:
                      charts.OrdinalAxisSpec(renderSpec: renderSpecString),
                  primaryMeasureAxis:
                      charts.NumericAxisSpec(renderSpec: renderSpecNum),
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
                    charts.SelectNearest(
                        eventTrigger: charts.SelectionTrigger.tapAndDrag),
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
    final measures = <String?, num?>{};
    if (selectedDatum.isNotEmpty) {
      for (var datumPair in selectedDatum) {
        measures[datumPair.series.displayName] = datumPair.datum.minutes;
      }
    }
    setState(() {});

    measures.forEach((key, value) {
      if (key == 'walking') {
        _walk = value;
      } else if (key == 'running') {
        _run = value;
      } else if (key == 'cycling') {
        _cycle = value;
      }
    });
  }
}

class ActivityOuterStatefulWidget extends StatefulWidget {
  final ActivityCardViewModel model;
  const ActivityOuterStatefulWidget(this.model, {super.key});

  @override
  ActivityOuterStatefulWidgetState createState() =>
      ActivityOuterStatefulWidgetState();
}

class ActivityOuterStatefulWidgetState
    extends State<ActivityOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) =>
      ActivityCardWidget.withSampleData(widget.model);
}
