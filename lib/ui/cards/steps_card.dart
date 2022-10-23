part of carp_study_app;

class StepsCardWidget extends StatefulWidget {
  final StepsCardViewModel model;
  final List<Color> colors;
  final List<charts.Series<DailySteps, String>> seriesList;

  StepsCardWidget(
    this.seriesList,
    this.model, {
    this.colors = const [CACHET.BLUE_1],
  });

  factory StepsCardWidget.withSampleData(StepsCardViewModel model) =>
      StepsCardWidget(_createChartList(model, [CACHET.BLUE_1]), model);

  static List<charts.Series<DailySteps, String>> _createChartList(
    StepsCardViewModel model,
    List<Color> colors,
  ) =>
      [
        charts.Series<DailySteps, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
          id: 'DailyStepsList',
          data: model.steps,
          domainFn: (DailySteps steps, _) => steps.toString(),
          measureFn: (DailySteps steps, _) => steps.steps,
        )
      ];

  @override
  StepsCardWidgetState createState() => StepsCardWidgetState();
}

class StepsCardWidgetState extends State<StepsCardWidget> {
  // Axis render settings
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  int? _selectedSteps = 0;

  @override
  void initState() {
    // Get current day steps
    _selectedSteps = widget.model.weeklySteps[DateTime.now().weekday];
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
              StreamBuilder(
                stream: widget.model.pedometerEvents,
                builder: (context, AsyncSnapshot<DataPoint> snapshot) {
                  return Column(
                    children: [
                      ChartsLegend(
                        title: locale.translate('cards.steps.title'),
                        iconAssetName: Icon(Icons.directions_walk,
                            color: Theme.of(context).primaryColor),
                        heroTag: 'steps-card',
                        values: [
                          '$_selectedSteps ' +
                              locale.translate('cards.steps.steps')
                        ],
                        colors: widget.colors,
                      ),
                      Container(
                        height: 160,
                        child: charts.BarChart(
                          widget.seriesList,
                          animate: true,
                          defaultRenderer: charts.BarRendererConfig<String>(
                            cornerStrategy: const charts.ConstCornerStrategy(2),
                          ),
                          domainAxis: charts.OrdinalAxisSpec(
                            renderSpec: renderSpecString,
                          ),
                          primaryMeasureAxis:
                              charts.NumericAxisSpec(renderSpec: renderSpecNum),
                          defaultInteractions: false,
                          selectionModels: [
                            charts.SelectionModelConfig(
                                type: charts.SelectionModelType.info,
                                changedListener: _infoSelectionModelChanged)
                          ],
                          behaviors: [
                            charts.SelectNearest(
                                eventTrigger:
                                    charts.SelectionTrigger.tapAndDrag),
                            charts.DomainHighlighter(),
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

  void _infoSelectionModelChanged(charts.SelectionModel model) {
    if (model.hasDatumSelection)
      setState(() {
        _selectedSteps = model.selectedSeries[0]
            .measureFn(model.selectedDatum[0].index) as int?;
      });
  }
}

class StepsOuterStatefulWidget extends StatefulWidget {
  final StepsCardViewModel model;
  StepsOuterStatefulWidget(this.model);

  @override
  _StepsOuterStatefulWidgetState createState() =>
      _StepsOuterStatefulWidgetState();
}

class _StepsOuterStatefulWidgetState extends State<StepsOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return StepsCardWidget.withSampleData(widget.model);
  }
}
