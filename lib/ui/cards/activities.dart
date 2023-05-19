part of carp_study_app;

class ActivitiesWidget extends StatefulWidget {
  final ActivityCardViewModel model;
  final List<Color> colors;
  const ActivitiesWidget(this.model,
      {Key? key,
      this.colors = const [CACHET.BLUE_1, CACHET.BLUE_2, CACHET.BLUE_3]})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivitiesWidgetState();
}

class ActivitiesWidgetState extends State<ActivitiesWidget> {
  num? _walk = 0;
  num? _run = 0;
  num? _cycle = 0;

  final betweenSpace = 0.2;

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
              height: 240,
              child: barCharts,
            ),
          ],
        ),
      ),
    );
  }

  BarChart get barCharts {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 20)),
            leftTitles: AxisTitles(),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: rightTitles,
                reservedSize: 20,
              ),
            ),
            topTitles: AxisTitles(),
          ),
          barTouchData: BarTouchData(
            enabled: false,
          ),
          barGroups: convertMapToList(widget.model.activities)),
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

  /// Doing some conversions to make the data readable by the chart
  /// The data is organized in a list of lists, where each list represents a day
  /// and each element in the list represents the time spent doing a specific
  /// activity.
  List<BarChartGroupData> convertMapToList(
      Map<ActivityType, Map<int, int>> data) {
    List<List<int>> resultList = List.generate(
        7, (_) => List.generate(4, (index) => index, growable: false),
        growable: false);

    data.forEach((activityType, innerMap) {
      innerMap.forEach((weekday, time) {
        int idx;
        if (activityType == ActivityType.WALKING) {
          idx = 0;
        } else if (activityType == ActivityType.RUNNING) {
          idx = 1;
        } else if (activityType == ActivityType.ON_BICYCLE) {
          idx = 2;
        } else {
          idx = -1;
        }
        resultList[weekday - 1][idx + 1] = time;
      });
    });

    List<BarChartGroupData> result = resultList
        .map((e) => generateGroupData(e[0], e[1], e[2], e[3]))
        .toList();

    return result;
  }

  BarChartGroupData generateGroupData(
    int x,
    num walking,
    num running,
    num cycling,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: walking + 0,
          color: widget.colors[0],
          width: 20,
          borderRadius: const BorderRadius.only()
        ),
        BarChartRodData(
          fromY: walking + betweenSpace,
          toY: walking + betweenSpace + running,
          color: widget.colors[1],
          width: 20,
          borderRadius: const BorderRadius.only()
        ),
        BarChartRodData(
          fromY: walking + betweenSpace + running + betweenSpace,
          toY: walking + betweenSpace + running + betweenSpace + cycling,
          color: widget.colors[2],
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
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
    final text = value.toInt().toString();
    final style = activityVisualisationTextStyle(
      color: Colors.grey.withOpacity(0.6),
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: AxisSide.right,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
