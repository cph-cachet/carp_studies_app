part of carp_study_app;
class HeartRateCardWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  final List<Color> colors;
  final List<charts.Series<HourlyHeartRate, String>> seriesList;

  HeartRateCardWidget(this.seriesList, this.model,
      {this.colors = const [CACHET.BLUE_1]});

  factory HeartRateCardWidget.withSampleData(HeartRateCardViewModel model) =>
      HeartRateCardWidget(_createChartList(model, [CACHET.BLUE_1]), model);

  static List<charts.Series<HourlyHeartRate, String>> _createChartList(
    HeartRateCardViewModel model,
    List<Color> colors,
  ) =>
      [
        charts.Series<HourlyHeartRate, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
          id: 'DailyHeartRateList',
          data: model.hourlyHeartRate
          domainFn: (HourlyHeartRate HeartRate, _) => HeartRate.toString(),
          measureFn: (HourlyHeartRate HeartRate, _) => HeartRate.hourlyHeartRate,
        )
      ];

  @override
  _HeartRateCardWidgetState createState() => _HeartRateCardWidgetState();
}

class _HeartRateCardWidgetState extends State<HeartRateCardWidget> {
  // Axis render settings
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  int? _selectedHeartRate = 0;

  @override
  void initState() {
    // Get current day HeartRate
    _selectedHeartRate = widget.model.hourlyHeartRate[DateTime.now().weekday];
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
                stream: widget.model.,
                builder: (context, AsyncSnapshot<DataPoint> snapshot) {
                  return Column(
                    children: [
                      ChartsLegend(
                        title: locale.translate('cards.HeartRate.title'),
                        iconAssetName: Icon(Icons.directions_walk,
                            color: Theme.of(context).primaryColor),
                        heroTag: 'HeartRate-card',
                        values: [
                          '$_selectedHeartRate ' +
                              locale.translate('cards.HeartRate.HeartRate')
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
        _selectedHeartRate = model.selectedSeries[0]
            .measureFn(model.selectedDatum[0].index) as int?;
      });
  }
}

class HeartRateOuterStatefulWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  HeartRateOuterStatefulWidget(this.model);

  @override
  _HeartRateOuterStatefulWidgetState createState() =>
      _HeartRateOuterStatefulWidgetState();
}

class _HeartRateOuterStatefulWidgetState extends State<HeartRateOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return HeartRateCardWidget.withSampleData(widget.model);
  }
}
