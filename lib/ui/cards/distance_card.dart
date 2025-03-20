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
          children: [
            Row(
              children: [
                Text(
                  _distance,
                  style: dataVizCardTitleNumber.copyWith(
                    color: Theme.of(context).extension<CarpColors>()!.grey900!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    'km',
                    style: dataVizCardTitleText.copyWith(
                      color: Theme.of(context).extension<CarpColors>()!.grey600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "${widget.model.currentMonth} ${widget.model.startOfWeek} - ${int.parse(widget.model.endOfWeek) < int.parse(widget.model.startOfWeek) ? widget.model.nextMonth : widget.model.currentMonth} ${widget.model.endOfWeek}, ${widget.model.currentYear}",
                  style: dataVizCardTitleText.copyWith(
                    color: Theme.of(context).extension<CarpColors>()!.grey600,
                  ),
                ),
                Spacer(),
              ],
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
    return widget.model.weekData.entries
        .map((e) => generateGroupData(e.key, e.value.distance))
        .toList();
  }

  BarChartGroupData generateGroupData(int x, double step) {
    bool isTouched = touchedIndex == x;
    maxValue = max(maxValue, step);
    if (isTouched) {
      _distance = step.toString();
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: step.toDouble(),
          color: widget.colors[0].withOpacity(isTouched ? 0.8 : 1),
          width: 32,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
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
