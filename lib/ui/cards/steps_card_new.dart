part of carp_study_app;

class StepsCardWidgetNew extends StatefulWidget {
  final StepsCardViewModel model;
  final List<Color> colors;
  const StepsCardWidgetNew(this.model,
      {Key? key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => StepsCardWidgetNewState();
}

class StepsCardWidgetNewState extends State<StepsCardWidget> {
  num _step = 0;
  num maxValue = 0;

  int touchedIndex = DateTime.now().weekday - 1;

  @override
  void initState() {
    widget.model.pedometerEvents?.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
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
                child: barCharts,
              ),
            ],
          ),
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
        leftTitles: AxisTitles(),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: rightTitles,
            reservedSize: 48,
          ),
        ),
        topTitles: AxisTitles(),
      ),
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: ((group, groupIndex, rod, rodIndex) {
            _step = 0; //TODO: placeholder
            return null;
          }),
        ),
        touchCallback: (p0, p1) {
          setState(() {
            touchedIndex =
                (p1?.spot?.touchedBarGroupIndex ?? DateTime.now().weekday - 1) +
                    1;
          });
        },
      ),
      groupsSpace: 4,
      barGroups: [
        for (int i = 1; i <= 7; i++)
          generateGroupData(i, widget.model.weeklySteps[i] ?? 0)
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

  BarChartGroupData generateGroupData(int x, int step) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: step as double,
          color: widget.colors[0],
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
      color: Colors.grey.withOpacity(0.6),
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
