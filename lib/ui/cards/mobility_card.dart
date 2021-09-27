part of carp_study_app;

class MobilityCardWidget extends StatefulWidget {
  final List<Color> colors;
  final List<charts.Series<Mobility, String>> seriesList;
  final MobilityCardDataModel model;
  MobilityCardWidget(this.seriesList, this.model,
      {this.colors = const [CACHET.BLUE_2, CACHET.BLUE_1, CACHET.RED_1]});

  factory MobilityCardWidget.withSampleData(MobilityCardDataModel model) {
    return MobilityCardWidget(
        _createChartList(model, [CACHET.BLUE_2, CACHET.BLUE_1, CACHET.RED_1]),
        model);
  }

  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  static List<charts.Series<Mobility, String>> _createChartList(
          MobilityCardDataModel model, List<Color> colors) =>
      [
        charts.Series<Mobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
          id: 'weeklyDistanceTraveled',
          data: model.distance,
          domainFn: (Mobility datum, _) => datum.toString(),
          measureFn: (Mobility datum, _) => datum.distance,
        )..setAttribute(charts.rendererIdKey, 'customLine'),
        charts.Series<Mobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[1]),
          id: 'weeklyHomeStay',
          data: model.homeStay,
          domainFn: (Mobility datum, _) => datum.toString(),
          measureFn: (Mobility datum, _) => datum.homeStay,
        )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
        charts.Series<Mobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[2]),
          id: 'weeklyPlaces',
          data: model.places,
          domainFn: (Mobility datum, _) => datum.toString(),
          measureFn: (Mobility datum, _) => datum.places,
        ),
      ];

  @override
  _MobilityCardWidgetState createState() => _MobilityCardWidgetState();
}

class _MobilityCardWidgetState extends State<MobilityCardWidget> {
  // Axis rendering settings
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  // TODO: refactor
  final _measures = <String?, List<num?>>{
    'weeklyDistanceTraveled': [0, 0, 0],
    'weeklyHomeStay': [0, 0, 0],
    'weeklyPlaces': [0, 0, 0],
  };

  @override
  void initState() {
    // Get current day mobility // TODO: REFACTOR
    _measures['weeklyHomeStay']![1] =
        widget.model.weeklyHomeStay[DateTime.now().weekday];
    _measures['weeklyDistanceTraveled']![0] =
        widget.model.weeklyDistanceTraveled[DateTime.now().weekday];
    _measures['weeklyPlaces']![2] =
        widget.model.weeklyPlaces[DateTime.now().weekday];

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
              CardHeader(
                title: locale.translate('cards.mobility.title'),
                iconAssetName: Icon(Icons.emoji_transportation,
                    color: Theme.of(context).primaryColor),
                heroTag: 'mobility-card',
                values: [
                  '${_measures['weeklyDistanceTraveled']![0]} ' +
                      locale.translate('cards.mobility.distance'),
                  '${_measures['weeklyHomeStay']![1]} ' +
                      locale.translate('cards.mobility.homestay'),
                  '${_measures['weeklyPlaces']![2]} ' +
                      locale.translate('cards.mobility.places'),
                ],
                colors: widget.colors,
              ),
              Container(
                height: 160,
                child: charts.OrdinalComboChart(
                  widget.seriesList,
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: renderSpecString,
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 3)),
                  secondaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 3)),
                  customSeriesRenderers: [
                    charts.LineRendererConfig(
                      customRendererId: 'customLine',
                      includeArea: true,
                      areaOpacity: 0.3,
                      layoutPaintOrder: 0,
                    ),
                  ],
                  defaultInteractions: true,
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: _infoSelectionModelChanged),
                  ],
                  behaviors: [
                    charts.LinePointHighlighter(
                      defaultRadiusPx: 0,
                      showHorizontalFollowLine:
                          charts.LinePointHighlighterFollowLineType.none,
                      showVerticalFollowLine:
                          charts.LinePointHighlighterFollowLineType.all,
                    ),
                    charts.SelectNearest(
                      selectAcrossAllDrawAreaComponents: true,
                      selectionModelType: charts.SelectionModelType.info,
                      eventTrigger: charts.SelectionTrigger.tap,
                    ),
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

  // TODO: refactor
  void _infoSelectionModelChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      setState(() {
        selectedDatum.forEach((charts.SeriesDatum datumPair) {
          _measures[datumPair.series.displayName] = [
            datumPair.datum.distance,
            datumPair.datum.homeStay,
            datumPair.datum.places
          ];
        });
      });
    }
  }
}

class MobilityOuterStatefulWidget extends StatefulWidget {
  final MobilityCardDataModel model;
  MobilityOuterStatefulWidget(this.model);

  @override
  _MobilityOuterStatefulWidgetState createState() =>
      _MobilityOuterStatefulWidgetState();
}

class _MobilityOuterStatefulWidgetState
    extends State<MobilityOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MobilityCardWidget.withSampleData(widget.model);
  }
}
