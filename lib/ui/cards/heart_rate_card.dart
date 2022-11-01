part of carp_study_app;

class HeartRateCardWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  final List<Color> colors;

  HeartRateCardWidget(this.model, {this.colors = const [CACHET.BLUE_1]});

  factory HeartRateCardWidget.withSampleData(HeartRateCardViewModel model) =>
      HeartRateCardWidget(model);

  @override
  _HeartRateCardWidgetState createState() => _HeartRateCardWidgetState();
}

class _HeartRateCardWidgetState extends State<HeartRateCardWidget> {
  // Axis render settings
  charts.RenderSpec<num> renderSpecNum = AxisTheme.axisThemeNum();
  charts.RenderSpec<String> renderSpecString = AxisTheme.axisThemeOrdinal();

  // HeartRate? _selectedHeartRate = HeartRate(0);

  @override
  void initState() {
    // Get current day HeartRate
    // _selectedHeartRate = widget.model.hourlyHeartRate[0];
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
              StreamBuilder(
                stream: widget.model.heartRateEvents,
                builder: (context, AsyncSnapshot<DataPoint> snapshot) {
                  return Column(
                    children: [
                      ChartsLegend(
                        title: locale.translate('cards.heartrate.title'),
                        iconAssetName: Icon(Icons.monitor_heart,
                            color: Theme.of(context).primaryColor),
                        heroTag: 'HeartRate-card',
                        values: [locale.translate('cards.heartrate.heartrate')],
                        colors: widget.colors,
                      ),
                      Container(height: 160, child: barCharts),
                    ],
                  );
                },
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
        alignment: BarChartAlignment.center,
        barTouchData: BarTouchData(
          enabled: false,
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
              getTitlesWidget: leftTitles,
              interval: 55,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
          getDrawingVerticalLine: (value) => FlLine(
            color: const Color.fromARGB(255, 179, 179, 181),
            strokeWidth: 1,
          ),
          verticalInterval: 1 / 48,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        groupsSpace: 4,
        barGroups: getHeartRateBars(),
        minY: 55,
        maxY: 70,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff939393),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 6) {
      text = '6';
    } else if (value == 12) {
      text = '12';
    } else if (value == 18) {
      text = '18';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: AxisSide.right,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final text = value.toString().split('.').first;
    const style = TextStyle(
      color: Color.fromARGB(255, 235, 75, 48),
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    return SideTitleWidget(
      axisSide: AxisSide.right,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  List<BarChartGroupData> getHeartRateBars() {
    const normal = Color.fromARGB(255, 243, 54, 32);

    return widget.model.hourlyHeartRate.entries.map((value) {
      return BarChartGroupData(
        x: value.key,
        barRods: [
          BarChartRodData(
            fromY: value.value.min as double,
            toY: value.value.max as double,
            color: normal,
            width: 6,
          ),
        ],
      );
    }).toList();
  }
}

class HeartRateOuterStatefulWidget extends StatefulWidget {
  final HeartRateCardViewModel model;
  HeartRateOuterStatefulWidget(this.model);

  @override
  _HeartRateOuterStatefulWidgetState createState() =>
      _HeartRateOuterStatefulWidgetState();
}

class _HeartRateOuterStatefulWidgetState
    extends State<HeartRateOuterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return HeartRateCardWidget.withSampleData(widget.model);
  }
}
