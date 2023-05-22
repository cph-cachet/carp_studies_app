part of carp_study_app;

class ActivityCardWidget extends StatefulWidget {
  final ActivityCardViewModel model;
  final List<Color> colors;
  const ActivityCardWidget(this.model,
      {Key? key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivityCardWidgetState();
}

class ActivityCardWidgetState extends State<ActivityCardWidget> {
  num? _walk = 0;
  num? _run = 0;
  num? _cycle = 0;

  num maxValue = 0;
  int touchedIndex = DateTime.now().weekday - 1;

  final betweenSpace = 2.4;

  List<List<int>> activitiesList = List.generate(
      7, (_) => List.generate(4, (index) => index, growable: false),
      growable: false);

  @override
  void initState() {
    widget.model.activityEvents?.listen((event) {
      setState(() {
        _walk = widget
            .model.activities[ActivityType.WALKING]![DateTime.now().weekday];
        _run = widget
            .model.activities[ActivityType.RUNNING]![DateTime.now().weekday];
        _cycle = widget
            .model.activities[ActivityType.ON_BICYCLE]![DateTime.now().weekday];
      });
    });

    /// Doing some conversions to make the data readable by the chart
    /// The data is organized in a list of lists, where each list represents a day
    /// and each element in the list represents the time spent doing a specific
    /// activity.
    widget.model.activities.forEach((activityType, innerMap) {
      int idx;
      if (activityType == ActivityType.WALKING) {
        idx = 1;
      } else if (activityType == ActivityType.RUNNING) {
        idx = 2;
      } else if (activityType == ActivityType.ON_BICYCLE) {
        idx = 3;
      } else {
        return;
      }
      innerMap.forEach((weekday, time) {
        activitiesList[weekday - 1][0] = weekday; // Assign weekday at index 0
        activitiesList[weekday - 1][idx] = time;
      });
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
                title: locale.translate('cards.activity.title'),
                iconAssetName: Icon(Icons.fitness_center,
                    color: Theme.of(context).colorScheme.primary),
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

    return BarChart(
      BarChartData(
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
              _walk = activitiesList[groupIndex][1];
              _run = activitiesList[groupIndex][2];
              _cycle = activitiesList[groupIndex][3];
              return null;
            }),
          ),
          touchCallback: (p0, p1) {
            setState(() {
              touchedIndex = (p1?.spot?.touchedBarGroupIndex ?? DateTime.now().weekday - 1) + 1;
            });
          },
        ),
        groupsSpace: 4,
        barGroups: activitiesList
            .map((e) => generateGroupData(e[0], e[1], e[2], e[3]))
            .toList(),
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
      ),
    );
  }

  BarChartGroupData generateGroupData(
    int x,
    num walking,
    num running,
    num cycling,
  ) {
    double roundness = 2;
    bool isTouched = touchedIndex == x;
    maxValue = max(maxValue, walking + running + cycling);

    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0, 1, 2] : [],
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: walking + 0,
            color: widget.colors[0].withOpacity(isTouched ? 0.8 : 1),
            width: 32,
            borderRadius: BorderRadius.all(Radius.circular(roundness))),
        BarChartRodData(
            fromY: walking + betweenSpace,
            toY: walking + betweenSpace + running,
            color: widget.colors[1].withOpacity(isTouched ? 0.8 : 1),
            width: 32,
            borderRadius: BorderRadius.all(Radius.circular(roundness))),
        BarChartRodData(
          fromY: walking + betweenSpace + running + betweenSpace,
          toY: walking + betweenSpace + running + betweenSpace + cycling,
          color: widget.colors[2].withOpacity(isTouched ? 0.8 : 1),
          width: 32,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: Radius.circular(roundness),
            bottomRight: Radius.circular(roundness),
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
