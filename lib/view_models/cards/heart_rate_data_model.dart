part of carp_study_app;


class HeartRateCardViewModel extends SerializableViewModel<DailyHeartRate> {
  PedometerDatum? _lastStep;

  @override
  DailyHeartRate createModel() => DailyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  Map<int, int> get weeklyHeartRate => model.dailyHeartRate;

  /// The list of HeartRate.
  List<DailyHeartRate> get HeartRate => model.HeartRate;

  /// Stream of pedometer (step) [DataPoint] measures.
  Stream<DataPoint>? get pedometerEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is PedometerDatum);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // listen for pedometer events and count them
    pedometerEvents?.listen((pedometerDataPoint) {
      PedometerDatum? _step = pedometerDataPoint.data as PedometerDatum?;
      if (_lastStep != null)
        model.increateStepCount(
            DateTime.now().weekday, _step!.stepCount! - _lastStep!.stepCount!);

      _lastStep = _step;
    });
  }
}

/// Weekly HeartRate organized by the day of the week.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DailyHeartRate extends DataModel {
  /// A map of weekly HeartRate organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> dailyHeartRate = {};

  DailyHeartRate() {
    // initialize the weekly HeartRate table
    for (int i = 1; i <= 7; i++) dailyHeartRate[i] = 0;
  }

  /// The list of HeartRate listed pr. weekday.
  List<DailyHeartRate> get HeartRate => dailyHeartRate.entries
      .map((entry) => DailyHeartRate(entry.key, entry.value))
      .toList();

  void increateStepCount(int weekday, int HeartRate) =>
      dailyHeartRate[weekday] = (dailyHeartRate[weekday] ?? 0) + HeartRate;

  String toString() {
    String _str = ' day | HeartRate\n';
    dailyHeartRate.forEach((day, HeartRate) => _str += '  $day  | $HeartRate\n');
    return _str;
  }

  DailyHeartRate fromJson(Map<String, dynamic> json) =>
      _$DailyHeartRateFromJson(json);
  Map<String, dynamic> toJson() => _$DailyHeartRateToJson(this);
}