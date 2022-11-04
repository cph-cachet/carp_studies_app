part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of heart rate values for each hour of the day.
  /// The key is the hour of the day (0-23) and the value is the min and max heart rate for that hour.
  Map<int, HeartRateMinMaxPrHour> get hourlyHeartRate => model.hourlyHeartRate;

  /// The current heart rate
  double? get currentHeartRate => model.currentHeartRate;

  // If the device is touching skin. Returns true if the device is touching skin, false otherwise.
  // If the device is not capable of detecting skin contact, this value is always true.
  bool contactStatus = false;

  HeartRateMinMaxPrHour get dayMinMax =>
      HeartRateMinMaxPrHour(model.minHeartRate, model.maxHeartRate);

  /// Stream of heart rate [PolarHRDatum] measures.
  Stream<DataPoint>? get heartRateEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is PolarHRDatum);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    heartRateEvents?.listen((heartRateDataPoint) {
      PolarHRDatum? _heartRate = heartRateDataPoint.data as PolarHRDatum;

      double _hr = _heartRate.hr.toDouble();
      // ignore: unnecessary_statements
      if (!(_hr > 0)) {
        contactStatus = false;
        return;
      }
      model.addHeartRate(DateTime.now().hour, _hr);

      if (_hr > model.maxHeartRate) {
        model.maxHeartRate = _hr;
      }
      if (_hr < model.minHeartRate) {
        model.minHeartRate = _hr;
      }

      contactStatus =
          _heartRate.contactStatusSupported ? _heartRate.contactStatus : true;
    });
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
  double? currentHeartRate;

  /// The minimum and maximum heart rate for the day
  /// Used to scale the graph
  double maxHeartRate = 80;
  double minHeartRate = 80;

  /// Add a heart rate value for a given hour.
  /// If the hour already exists, the min and max values are updated.
  /// If the hour does not exist, it is added.
  void addHeartRate(int hour, double heartRate) {
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
  double min = 80;
  double max = 80;

  HeartRateMinMaxPrHour(this.min, this.max);
}
