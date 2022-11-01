part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  // Map<TimeOfDay, HeartRate> get hourlyHeartRate => model.hourlyHeartRate;
  // generate a map of time of day to integer heart rate in range 50 to 80
  Map<int, HeartRateMinMaxPrHour> get hourlyHeartRate => model.hourlyHeartRate;

  /// The current heart rate
  int get currentHeartRate => model.currentHeartRate;

  /// The dataset for the graph
  Map<int, HeartRateMinMaxPrHour> get graphData => {};

  /// Stream of heart rate [PolarHRDatum] measures.
  Stream<DataPoint>? get heartRateEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is PolarHRDatum);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    heartRateEvents?.listen((heartRateDataPoint) {
      PolarHRDatum? _heartRate = heartRateDataPoint.data as PolarHRDatum;
      model.addHeartRate(_heartRate.timestamp.hour, _heartRate.hr);

      if (_heartRate.hr > model.maxHeartRate) {
        model.maxHeartRate = _heartRate.hr;
      }
      if (_heartRate.hr < model.minHeartRate) {
        model.minHeartRate = _heartRate.hr;
      }
    });
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
  /// A map of hourly HeartRate with min and max.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, HeartRateMinMaxPrHour> hourlyHeartRate = {};

  HourlyHeartRate() {
    for (int i = 0; i < 24; i++) {
      hourlyHeartRate[i] = HeartRateMinMaxPrHour(0, 0);
    }
  }

  /// The current heart rate
  int currentHeartRate = 50;

  int maxHeartRate = 50;
  int minHeartRate = 50;

  void addHeartRate(int hour, int heartRate) {
    currentHeartRate = heartRate;

    if (hourlyHeartRate.containsKey(hour)) {
      if (heartRate < hourlyHeartRate[hour]!.min) {
        hourlyHeartRate[hour]!.min = heartRate;
      }

      if (heartRate > hourlyHeartRate[hour]!.max) {
        hourlyHeartRate[hour]!.max = heartRate;
      }
    } else {
      hourlyHeartRate[hour] = HeartRateMinMaxPrHour(heartRate, heartRate);
    }
  }

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

class HeartRateMinMaxPrHour {
  int min = 50;
  int max = 50;

  HeartRateMinMaxPrHour(this.min, this.max);
}
