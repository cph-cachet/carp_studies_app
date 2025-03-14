part of carp_study_app;

class StepsCardWidget extends StatefulWidget {
  final List<Color> colors;

  final StepsCardViewModel model;
  const StepsCardWidget(this.model,
      {super.key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]});

  @override
  StepsCardWidgetState createState() => StepsCardWidgetState();
}

class StepsCardWidgetState extends State<StepsCardWidget> {
  num _step = 0;
  num maxValue = 0;

  int touchedIndex = DateTime.now().weekday;

  @override
  void initState() {
    _step = widget.model.steps[DateTime.now().weekday - 1].steps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StudiesMaterial(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ChartsLegend(
              title: locale.translate('cards.steps.title'),
              iconAssetName: Icon(Icons.directions_walk,
                  color: Theme.of(context).primaryColor),
              heroTag: 'steps-card',
              values: [
                '$_step ${locale.translate('cards.steps.steps')}',
              ],
              colors: widget.colors,
            ),
            SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.9,
              child: StreamBuilder(
                stream: widget.model.pedometerEvents,
                builder: (context, snapshot) {
                  return barCharts;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChart get barCharts {
    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
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
      barTouchData: BarTouchData(
        enabled: false,
        touchCallback: (p0, p1) {
          setState(() {
            touchedIndex =
                (p1?.spot?.touchedBarGroupIndex ?? DateTime.now().weekday - 1) +
                    1;
          });
        },
      ),
      groupsSpace: 4,
      barGroups: barChartsGroups,
      maxY: (maxValue) * 1.2,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withValues(alpha: 0.3),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          width: 1,
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
    ));
  }

  List<BarChartGroupData> get barChartsGroups {
    return widget.model.weeklySteps.entries
        .map((e) => generateGroupData(e.key, e.value))
        .toList();
  }

  BarChartGroupData generateGroupData(int x, int step) {
    bool isTouched = touchedIndex == x;
    maxValue = max(maxValue, step);
    if (isTouched) {
      _step = step;
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: step.toDouble(),
          color: widget.colors[1].withValues(alpha: isTouched ? 0.8 : 1),
          width: 32,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
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
    final text = value.toInt() % meta.appliedInterval == 0
        ? value.toInt().toString()
        : '';

    final style = activityVisualisationTextStyle(
      color: Colors.grey.withValues(alpha: 0.6),
      fontSize: 14,
    );
    return SideTitleWidget(
      meta: meta,
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
      meta: meta,
      child: Text(text, style: style),
    );
  }
}
