part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of heart rate values for each hour of the day.
  /// The key is the hour of the day (0-23) and the value is the min and max heart rate for that hour.
  Map<int, HeartRateMinMaxPrHour> get hourlyHeartRate => model.hourlyHeartRate;

  /// The current heart rate
  int get currentHeartRate => model.currentHeartRate;

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

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class HourlyHeartRate extends DataModel {
  /// A map of heart rate values for each hour of the day.
  ///
  ///    (hour of the day, min and max heart rate for that hour)
  ///
  /// The hour of the day is expressed as an integer between 0 and 23.
  /// The min and max heart rate is expressed as a [HeartRateMinMaxPrHour] object.
  Map<int, HeartRateMinMaxPrHour> hourlyHeartRate = {};

  HourlyHeartRate() {
    for (int i = 0; i < 24; i++) {
      hourlyHeartRate[i] = HeartRateMinMaxPrHour(0, 0);
    }
  }

  /// The current heart rate
  int currentHeartRate = 50;

  /// The minimum and maximum heart rate for the day
  /// Used to scale the graph
  int maxHeartRate = 50;
  int minHeartRate = 50;

  /// Add a heart rate value for a given hour.
  /// If the hour already exists, the min and max values are updated.
  /// If the hour does not exist, it is added.
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
