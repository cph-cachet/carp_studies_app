part of carp_study_app;

class MobilityCardWidget extends StatefulWidget {
  final MobilityCardDataModel model;
  MobilityCardWidget(this.model);
  _MobilityCardWidgetState createState() => _MobilityCardWidgetState();
}

class _MobilityCardWidgetState extends State<MobilityCardWidget> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<Color> colors = [
    Color.fromRGBO(130, 206, 233, 1),
    Color.fromRGBO(12, 70, 128, 1),
    Color.fromRGBO(239, 68, 87, 1),
  ];

  // TODO: refactor
  List<charts.Series<Mobility, String>> _createChartList(BuildContext context, MobilityCardDataModel model) {
    List<Mobility> _distance =
        model._weeklyDistanceTraveled.entries.map((entry) => Mobility(entry.key, 0, 0, entry.value)).toList();
    List<Mobility> _homeStay =
        model._weeklyHomeStay.entries.map((entry) => Mobility(entry.key, 0, entry.value, 0)).toList();
    List<Mobility> _places =
        model._weeklyPlaces.entries.map((entry) => Mobility(entry.key, entry.value, 0, 0)).toList();

    return [
      charts.Series<Mobility, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
        id: 'weeklyDistanceTraveled',
        data: _distance,
        domainFn: (Mobility datum, _) => datum.toString(),
        measureFn: (Mobility datum, _) => datum.distance,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
      charts.Series<Mobility, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[1]),
        id: 'weeklyHomeStay',
        data: _homeStay,
        domainFn: (Mobility datum, _) => datum.toString(),
        measureFn: (Mobility datum, _) => datum.homeStay,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
      charts.Series<Mobility, String>(
        colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[2]),
        id: 'weeklyPlaces',
        data: _places,
        domainFn: (Mobility datum, _) => datum.toString(),
        measureFn: (Mobility datum, _) => datum.places,
      ),
    ];
  }

  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  final _measures = <String, List<num>>{
    'weeklyDistanceTraveled': [0, 0, 0],
    'weeklyHomeStay': [0, 0, 0],
    'weeklyPlaces': [0, 0, 0],
  };

  @override
  void initState() {
    // Get current day mobility // TODO: REFACTOR
    _measures['weeklyHomeStay'][1] = widget.model._weeklyHomeStay[DateTime.now().weekday];
    _measures['weeklyDistanceTraveled'][0] = widget.model._weeklyDistanceTraveled[DateTime.now().weekday];
    _measures['weeklyPlaces'][2] = widget.model._weeklyPlaces[DateTime.now().weekday];

    super.initState();
  }

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
                title: 'Mobility',
                iconAssetName: Icon(Icons.emoji_transportation, color: Theme.of(context).primaryColor),
                heroTag: 'mobility-card',
                values: [
                  '${_measures['weeklyDistanceTraveled'][0]} km travelled',
                  '${_measures['weeklyHomeStay'][1]} % homestay',
                  '${_measures['weeklyPlaces'][2]} places'
                ],
                colors: colors,
              ),
              Container(
                height: 160,
                child: charts.OrdinalComboChart(
                  _createChartList(context, widget.model),
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: renderSpecString,
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
                  secondaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
                  defaultRenderer: new charts.BarRendererConfig(groupingType: charts.BarGroupingType.grouped),
                  customSeriesRenderers: [
                    new charts.LineRendererConfig(
                      customRendererId: 'customLine',
                      includeArea: true,
                    )
                  ],
                  defaultInteractions: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info, changedListener: _infoSelectionModelChanged)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: refactor
  void _infoSelectionModelChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        _measures[datumPair.series.displayName] = [
          datumPair.datum.distance,
          datumPair.datum.homeStay,
          datumPair.datum.places
        ];
      });
    }
    print(_measures);
    setState(() {});
  }
}
