part of carp_study_app;

class MobilityCardWidget extends StatefulWidget {
  final List<Color> colors;
  final List<charts.Series<DailyMobility, String>> seriesList;
  final MobilityCardViewModel model;
  const MobilityCardWidget(this.seriesList, this.model,
      {super.key, this.colors = const [CACHET.BLUE_2, CACHET.BLUE_1, CACHET.RED_1]});

  factory MobilityCardWidget.withSampleData(MobilityCardViewModel model) {
    return MobilityCardWidget(
        _createChartList(model, [CACHET.BLUE_2, CACHET.BLUE_1, CACHET.RED_1]),
        model);
  }

  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  static List<charts.Series<DailyMobility, String>> _createChartList(
          MobilityCardViewModel model, List<Color> colors) =>
      [
        charts.Series<DailyMobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[0]),
          id: 'weeklyDistanceTraveled',
          data: model.distance,
          domainFn: (DailyMobility datum, _) => datum.toString(),
          measureFn: (DailyMobility datum, _) => datum.distance,
        )..setAttribute(charts.rendererIdKey, 'customLine'),
        charts.Series<DailyMobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[1]),
          id: 'weeklyHomeStay',
          data: model.homeStay,
          domainFn: (DailyMobility datum, _) => datum.toString(),
          measureFn: (DailyMobility datum, _) => datum.homeStay,
        )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
        charts.Series<DailyMobility, String>(
          colorFn: (d, i) => charts.ColorUtil.fromDartColor(colors[2]),
          id: 'weeklyPlaces',
          data: model.places,
          domainFn: (DailyMobility datum, _) => datum.toString(),
          measureFn: (DailyMobility datum, _) => datum.places,
        ),
      ];

  @override
  MobilityCardWidgetState createState() => MobilityCardWidgetState();
}

class MobilityCardWidgetState extends State<MobilityCardWidget> {
  // Axis rendering settings
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<DateTime> renderSpecTime = AxisTheme.axisThemeDateTime();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  final _measures = <String?, List<num?>>{
    'weeklyDistanceTraveled': [0, 0, 0],
    'weeklyHomeStay': [0, 0, 0],
    'weeklyPlaces': [0, 0, 0],
  };

  @override
  void initState() {
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
              ChartsLegend(
                title: locale.translate('cards.mobility.title'),
                iconAssetName: Icon(Icons.emoji_transportation,
                    color: Theme.of(context).primaryColor),
                heroTag: 'mobility-card',
                values: [
                  '${_measures['weeklyDistanceTraveled']![0]} ${locale.translate('cards.mobility.distance')}',
                  '${_measures['weeklyHomeStay']![1]} ${locale.translate('cards.mobility.homestay')}',
                  '${_measures['weeklyPlaces']![2]} ${locale.translate('cards.mobility.places')}',
                ],
                colors: widget.colors,
              ),
              SizedBox(
                height: 160,
                child: charts.OrdinalComboChart(
                  widget.seriesList,
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: renderSpecString,
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 3)),
                  secondaryMeasureAxis: charts.NumericAxisSpec(
                      renderSpec: renderSpecNum,
                      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
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

  void _infoSelectionModelChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    if (selectedDatum.isNotEmpty) {
      setState(() {
        for (var datumPair in selectedDatum) {
          _measures[datumPair.series.displayName] = [
            datumPair.datum.distance,
            datumPair.datum.homeStay,
            datumPair.datum.places
          ];
        }
      });
    }
  }
}

class MobilityOuterStatefulWidget extends StatefulWidget {
  final MobilityCardViewModel model;
  const MobilityOuterStatefulWidget(this.model, {super.key});

  @override
  MobilityOuterStatefulWidgetState createState() =>
      MobilityOuterStatefulWidgetState();
}

class MobilityOuterStatefulWidgetState
    extends State<MobilityOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MobilityCardWidget.withSampleData(widget.model);
  }
}
