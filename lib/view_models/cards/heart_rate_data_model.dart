part of carp_study_app;

class HeartRateCardViewModel extends SerializableViewModel<HourlyHeartRate> {
  @override
  HourlyHeartRate createModel() => HourlyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  Map<TimeOfDay, CurrentHeartRate> get hourlyHeartRate => model.hourlyHeartRate;

  /// The list of HeartRate.
  List<HourlyHeartRate> get currentHeartRate => model.heartRate;

  /// Stream of pedometer (step) [DataPoint] measures.
  Stream<DataPoint>? get heartRateEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is CurrentHeartRate);

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
  Map<TimeOfDay, CurrentHeartRate> hourlyHeartRate = {};

  HourlyHeartRate();

  /// The list of HeartRate listed pr. weekday.
  List<HourlyHeartRate> get heartRate => hourlyHeartRate.entries
      .map((key, value) => {
        return [key, value];
        })
      .toList();

  void increateStepCount(TimeOfDay weekday, int heartRate) =>
      hourlyHeartRate[weekday] = (hourlyHeartRate[weekday] ?? 0) + heartRate;

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

class CurrentHeartRate extends HourlyMeasure {
  final int heartRate;

  CurrentHeartRate(TimeOfDay time, this.heartRate)
      : super(time.hour, time.minute);
}
