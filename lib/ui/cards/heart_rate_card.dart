part of carp_study_app;

class HeartRateCardWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  static const colors = [
    Color.fromARGB(255, 243, 54, 32),
    Color.fromARGB(255, 179, 179, 181),
    Color.fromARGB(70, 0, 0, 0),
  ];

  const HeartRateCardWidget(this.model, {super.key});

  factory HeartRateCardWidget.withSampleData(HeartRateCardViewModel model) =>
      HeartRateCardWidget(model);

  @override
  HeartRateCardWidgetState createState() => HeartRateCardWidgetState();
}

class HeartRateCardWidgetState extends State<HeartRateCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1,
    )..repeat(
        reverse: true,
      );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StudiesMaterial(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: widget.model.heartRateStream,
              builder: (context, AsyncSnapshot<double> snapshot) {
                // animationController.duration = Duration(
                //     milliseconds: 1000 ~/
                //         (((widget.model.currentHeartRate ?? 0) + 1) / 60));

                return Column(
                  children: [
                    ChartsLegend(
                        title: locale.translate('cards.heartrate.title'),
                        iconAssetName: Icon(Icons.monitor_heart,
                            color: Theme.of(context).primaryColor),
                        heroTag: 'HeartRate-card',
                        values: const [],
                        colors: HeartRateCardWidget.colors),
                    getDailyRange,
                    SizedBox(
                      height: 240,
                      child: barCharts,
                    ),
                    SizedBox(
                      height: 80,
                      child: currentHeartRateWidget,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Row get getDailyRange {
    RPLocalizations locale = RPLocalizations.of(context)!;

    final min = widget.model.dayMinMax.min;
    final max = widget.model.dayMinMax.max;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 2),
          child: Text(
            min == null || max == null
                // ? locale.translate('cards.no_data')
                ? '-'
                : '${(min.toInt())} - ${(max.toInt())}',
            style: heartRateNumberStyle.copyWith(
              fontSize: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            min == null || max == null
                ? ''
                : locale.translate('cards.heartrate.bpm'),
            style: heartRateNumberStyle.copyWith(
              fontSize: 12,
              color: Theme.of(context).extension<CarpColors>()!.grey600,
            ),
          ),
        ),
      ],
    );
  }

  Stack get currentHeartRateWidget {
    RPLocalizations locale = RPLocalizations.of(context)!;

    final currentHeartRate = widget.model.currentHeartRate;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: currentHeartRate != null
                    ? Text(
                        currentHeartRate.toStringAsFixed(0),
                        style: heartRateNumberStyle,
                      )
                    : Text('-', style: heartRateNumberStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepaintBoundary(
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 1, end: 1)
                            .animate(animationController),
                        child: Icon(
                          Icons.favorite_outline_rounded,
                          color: HeartRateCardWidget.colors[0],
                          size: 32,
                        ),
                      ),
                    ),
                    Text(
                      locale.translate('cards.heartrate.bpm'),
                      style: heartRateNumberStyle.copyWith(
                        color:
                            Theme.of(context).extension<CarpColors>()!.grey600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChart get barCharts {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            fitInsideHorizontally: true,
            // tooltipBgColor: Theme.of(context).primaryColorLight,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '',
                textAlign: TextAlign.start,
                children: [
                  TextSpan(
                    text:
                        locale.translate('cards.heartrate.range').toUpperCase(),
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "\n${rod.fromY.toInt()} - ${rod.toY.toInt()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: "${locale.translate('cards.heartrate.bpm')}\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall?.color,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: "$groupIndex-${groupIndex + 1} ",
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.bodySmall?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
                heartRateNumberStyle,
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: bottomTitles,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: rightTitles,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withValues(alpha: 0.2),
                  strokeWidth: 1,
                ),
            checkToShowHorizontalLine: (value) => value % 100 == 0,
            getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.withValues(alpha: 0.2),
                strokeWidth: 1,
                dashArray: [3, 2]),
            verticalInterval: 1 / 24,
            checkToShowVerticalLine: (value) {
              if (value == 1 / 4) return true;
              if (value == 12 / 24) return true;
              if (value == 18 / 24) return true;
              if (value == 24 / 24) return true;
              return false;
            }),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            width: 1,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        groupsSpace: 4,
        barGroups: getHeartRateBars(),
        minY: 0,
        maxY: 200,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.grey.withValues(alpha: 0.6),
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    String text;
    if (value == 0) {
      text = '00';
    } else if (value == 6) {
      text = '06';
    } else if (value == 12) {
      text = '12';
    } else if (value == 18) {
      text = '18';
    } else {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: Text(
        value.toInt() % meta.appliedInterval == 0
            ? value.toInt().toString()
            : '',
        style: dataCardRightTitleStyle.copyWith(
          color: Theme.of(context).extension<CarpColors>()!.grey600,
        ),
        maxLines: 1,
      ),
    );
  }
  
  List<BarChartGroupData> getHeartRateBars() =>
      widget.model.hourlyHeartRate.entries
          .map((value) => BarChartGroupData(
                x: value.key,
                barRods: [
                  BarChartRodData(
                    fromY: value.value.min,
                    toY: value.value.max ?? 0,
                    color: HeartRateCardWidget.colors[0],
                    width: 6,
                  ),
                ],
              ))
          .toList();
}

class HeartRateOuterStatefulWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  const HeartRateOuterStatefulWidget(this.model, {super.key});

  @override
  HeartRateOuterStatefulWidgetState createState() =>
      HeartRateOuterStatefulWidgetState();
}

class HeartRateOuterStatefulWidgetState
    extends State<HeartRateOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return HeartRateCardWidget.withSampleData(widget.model);
  }
}
