part of carp_study_app;

class MobilityCard extends StatefulWidget {
  final List<Color> colors;

  final MobilityCardViewModel model;
  const MobilityCard(this.model,
      {super.key,
      this.colors = const [CACHET.CAQUI, CACHET.ORANGE, CACHET.BLUE_3]});

  @override
  State<MobilityCard> createState() => _MobilityCardState();
}

class _MobilityCardState extends State<MobilityCard> {
  int touchedIndex = DateTime.now().weekday;

  num _homestay = 0;
  num _places = 0;

  @override
  void initState() {
    _homestay = widget.model.weekData[DateTime.now().weekday]!.homeStay;
    _places = widget.model.weekData[DateTime.now().weekday]!.places;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StudiesMaterial(
      backgroundColor: Theme.of(context).extension<CarpColors>()!.white!,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$_homestay%',
                  style: dataVizCardTitleNumber.copyWith(
                    color: widget.colors[0],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    locale.translate('cards.mobility.homestay'),
                    style: dataVizCardTitleText.copyWith(
                      color:
                          Theme.of(context).extension<CarpColors>()!.grey900!,
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
                builder: (context, snapshot) {
                  return barCharts;
                },
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '$_places',
                      style: dataVizCardBottomNumber.copyWith(
                        color: widget.colors[0],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        locale.translate('cards.mobility.places'),
                        style: dataVizCardBottomText.copyWith(
                            color: Theme.of(context)
                                .extension<CarpColors>()!
                                .grey800),
                      ),
                    ),
                  ],
                ),
              ],
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
      maxY: 100,
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
        .map((e) => generateGroupData(e.key, e.value.homeStay, e.value.places))
        .toList();
  }

  BarChartGroupData generateGroupData(int x, int homestay, int places) {
    bool isTouched = touchedIndex == x;
    if (isTouched) {
      _homestay = homestay;
      _places = places;
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: places.toDouble(),
          color: widget.colors[1].withValues(alpha: isTouched ? 0.8 : 1),
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: homestay.toDouble(),
          color: widget.colors[0].withValues(alpha: isTouched ? 0.8 : 1),
          width: 16,
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

  Widget leftTitles(double value, TitleMeta meta) {
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
