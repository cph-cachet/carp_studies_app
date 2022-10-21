part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  Map<TimeOfDay, HeartRate> get hourlyHeartRate => model.hourlyHeartRate;

  /// The list of HeartRate.
  HeartRate get currentHeartRate => model.heartRate;

  /// Stream of pedometer (step) [DataPoint] measures.
  Stream<DataPoint>? get heartRateEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is HeartRate);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
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
