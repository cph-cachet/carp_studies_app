part of carp_study_app;

class StepsCardViewModel extends SerializableViewModel<WeeklySteps> {
  PedometerDatum? _lastStep;

  @override
  WeeklySteps createModel() => WeeklySteps();

  /// A map of weekly steps organized by the day of the week.
  Map<int, int> get weeklySteps => model.weeklySteps;

  /// The list of steps.
  List<DailySteps> get steps => model.steps;

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

/// Weekly steps organized by the day of the week.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class WeeklySteps extends DataModel {
  /// A map of weekly steps organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> weeklySteps = {};

  WeeklySteps() {
    // initialize the weekly steps table
    for (int i = 1; i <= 7; i++) weeklySteps[i] = 0;
  }

  /// The list of steps listed pr. weekday.
  List<DailySteps> get steps => weeklySteps.entries
      .map((entry) => DailySteps(entry.key, entry.value))
      .toList();

  void increateStepCount(int weekday, int steps) {
    weeklySteps[weekday] = weeklySteps[weekday] ?? 0 + steps;
  }

  String toString() {
    String _str = ' day | steps\n';
    weeklySteps.forEach((day, steps) => _str += '  $day  | $steps\n');
    return _str;
  }

  WeeklySteps fromJson(Map<String, dynamic> json) =>
      _$WeeklyStepsFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyStepsToJson(this);
}

/// Steps per weekday.
class DailySteps extends DailyMeasure {
  /// Number of steps for this [weekday].
  final int steps;

  DailySteps(int weekday, this.steps) : super(weekday);
}
