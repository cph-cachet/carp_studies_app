part of carp_study_app;


class HeartRateCardViewModel extends SerializableViewModel<WeeklyHeartRate> {
  PedometerDatum? _lastStep;

  @override
  WeeklyHeartRate createModel() => WeeklyHeartRate();

  /// A map of weekly HeartRate organized by the day of the week.
  Map<int, int> get weeklyHeartRate => model.weeklyHeartRate;

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
class WeeklyHeartRate extends DataModel {
  /// A map of weekly HeartRate organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> weeklyHeartRate = {};

  WeeklyHeartRate() {
    // initialize the weekly HeartRate table
    for (int i = 1; i <= 7; i++) weeklyHeartRate[i] = 0;
  }

  /// The list of HeartRate listed pr. weekday.
  List<DailyHeartRate> get HeartRate => weeklyHeartRate.entries
      .map((entry) => DailyHeartRate(entry.key, entry.value))
      .toList();

  void increateStepCount(int weekday, int HeartRate) =>
      weeklyHeartRate[weekday] = (weeklyHeartRate[weekday] ?? 0) + HeartRate;

  String toString() {
    String _str = ' day | HeartRate\n';
    weeklyHeartRate.forEach((day, HeartRate) => _str += '  $day  | $HeartRate\n');
    return _str;
  }

  WeeklyHeartRate fromJson(Map<String, dynamic> json) =>
      _$WeeklyHeartRateFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyHeartRateToJson(this);
}

/// HeartRate per weekday.
class DailyHeartRate extends DailyMeasure {
  /// Number of HeartRate for this [weekday].
  final int HeartRate;

  DailyHeartRate(int weekday, this.HeartRate) : super(weekday);
}
