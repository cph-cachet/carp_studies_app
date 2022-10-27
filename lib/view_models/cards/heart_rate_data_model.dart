part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  static const color = Color.fromARGB(255, 235, 75, 48);

  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  // Map<TimeOfDay, HeartRate> get hourlyHeartRate => model.hourlyHeartRate;
  // generate a map of time of day to integer heart rate in range 50 to 80
  Map<TimeOfDay, HeartRate> get hourlyHeartRate => {
        TimeOfDay(hour: 0, minute: 0): HeartRate(50),
        TimeOfDay(hour: 0, minute: 2): HeartRate(53),
        TimeOfDay(hour: 0, minute: 2, second: 4): HeartRate(54),
        TimeOfDay(hour: 0, minute: 2, second: 5): HeartRate(52),
        TimeOfDay(hour: 0, minute: 30): HeartRate(50),
        TimeOfDay(hour: 0, minute: 31): HeartRate(50),
        TimeOfDay(hour: 0, minute: 35): HeartRate(50),
        TimeOfDay(hour: 1, minute: 0): HeartRate(60),
        TimeOfDay(hour: 2, minute: 0): HeartRate(70),
        TimeOfDay(hour: 3, minute: 0): HeartRate(80),
        TimeOfDay(hour: 4, minute: 0): HeartRate(70),
        TimeOfDay(hour: 5, minute: 0): HeartRate(60),
        TimeOfDay(hour: 6, minute: 0): HeartRate(50),
        TimeOfDay(hour: 7, minute: 0): HeartRate(60),
        TimeOfDay(hour: 8, minute: 0): HeartRate(70),
        TimeOfDay(hour: 9, minute: 0): HeartRate(80),
        TimeOfDay(hour: 10, minute: 0): HeartRate(70),
        TimeOfDay(hour: 11, minute: 0): HeartRate(60),
      };

  /// The current heart rate
  HeartRate get currentHeartRate => model.heartRate;

  /// The dataset for the graph

  /// Stream of heart rate [HeartRate] measures.
  Stream<DataPoint>? get heartRateEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is HeartRate);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
  }

  BarChartGroupData getSeparaterStick(xAxis, height) {
    return BarChartGroupData(x: xAxis, barsSpace: 0, barRods: [
      BarChartRodData(
          toY: height,
          fromY: 0,
          width: 1,
          color: const Color.fromARGB(70, 0, 0, 0))
    ]);
  }
}

/// Weekly HeartRate organized by the day of the week.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class HourlyHeartRate extends DataModel {
  /// A map of weekly HeartRate organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<TimeOfDay, HeartRate> hourlyHeartRate = {};

  HourlyHeartRate();

  /// The current heart rate
  HeartRate get heartRate => hourlyHeartRate.values.last;

  String toString() {
    String _str = 'time | heart rate\n';
    hourlyHeartRate
        .forEach((time, heartRate) => _str += '$time  | $heartRate\n');
    return _str;
  }

  @override
  DataModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class HeartRate {
  final int heartRate;

  HeartRate(this.heartRate);
}
