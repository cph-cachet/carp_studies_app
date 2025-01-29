part of carp_study_app;

class DistanceCard extends StatefulWidget {
  final List<Color> colors;

  final MobilityCardViewModel model;
  const DistanceCard(this.model,
      {super.key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]});

  @override
  State<DistanceCard> createState() => _DistanceCardState();
}

class _DistanceCardState extends State<DistanceCard> {
  // Distance is the average distance over the week
  num _accumulatedDistance = 0;
  String _distance = '';
  num maxValue = 0;

  int touchedIndex = DateTime.now().weekday;

  @override
  void initState() {
    for (int i = 1; i <= 7; i++) {
      _accumulatedDistance += widget.model.weekData[i]!.distance;
    }
    _distance = (_accumulatedDistance / 7).toStringAsPrecision(3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StudiesMaterial(
      backgroundColor: Theme.of(context).extension<CarpColors>()!.white!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                  locale.translate('cards.distance.title').toUpperCase(),
                  style: dataCardTitleStyle),
            ),
            // UI that shows the average distance over the week, in the style of Apple Health
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Text saying "Average distance" in the style of Apple Health
                  Row(
                    children: [
                      Text(
                        locale
                            .translate('cards.distance.average')
                            .toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          _distance,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        ' km',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.9,
              child: StreamBuilder(
                stream: widget.model.mobilityEvents,
                builder: (context, snapshot) => barCharts,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChart get barCharts {
    return LineChart(LineChartData(
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitles,
            reservedSize: 20,
          ),
        ),
        leftTitles: const AxisTitles(),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: rightTitles,
            reservedSize: 48,
          ),
        ),
        topTitles: const AxisTitles(),
      ),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          tooltipRoundedRadius: 8,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              final textStyle = activityVisualisationTextStyle(
                color: Colors.black,
                fontSize: 12,
              );
              return LineTooltipItem('${touchedSpot.y.toInt()} km', textStyle);
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: lineChartsGroups,
          barWidth: 8,
          isCurved: true,
          curveSmoothness: 0.25,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 4,
              color: widget.colors[0].withOpacity(0.5),
              strokeWidth: 0,
            ),
          ),
          color: widget.colors[1],
          isStrokeCapRound: true,
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0.5, 0),
            FlSpot(7.5, 0),
          ],
          barWidth: 0,
          dotData: const FlDotData(
            show: false,
          ),
        )
      ],
      maxY: (maxValue) * 1.2,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    ));
  }

  List<FlSpot> get lineChartsGroups {
    return widget.model.weekData.entries
        .map((e) => generateSpotData(e.key, e.value.distance))
        .toList();
  }

  FlSpot generateSpotData(int x, double y) {
    maxValue = max(maxValue, y);
    return FlSpot(x.toDouble(), y);
  }

  TextStyle activityVisualisationTextStyle(
      {double? fontSize, Color? color, List<ui.FontFeature>? fontFeatures}) {
    return GoogleFonts.barlow(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      fontFeatures: fontFeatures,
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    final text =
        value.toInt() % meta.appliedInterval == 0 ? '${value.toInt()}' : '';

    final style = activityVisualisationTextStyle(
      color: Colors.grey.withOpacity(0.8),
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: AxisSide.right,
      space: 16,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    if (value > 7 || value < 1) return Container();
    switch (value.toInt()) {
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Tue';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      case 7:
        text = 'Sun';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }
}
