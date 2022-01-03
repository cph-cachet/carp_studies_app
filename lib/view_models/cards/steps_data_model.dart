part of carp_study_app;

class StepsCardViewModel extends ViewModel {
  PedometerDatum? _lastStep;
  final WeeklySteps _weeklySteps = WeeklySteps();

  /// A map of weekly steps organized by the day of the week.
  Map<int, int> get weeklySteps => _weeklySteps.weeklySteps;

  /// The list of steps.
  List<DailySteps> get steps => _weeklySteps.steps;

  /// Stream of pedometer (step) [DataPoint] measures.
  Stream<DataPoint>? get pedometerEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is PedometerDatum);

  StepsCardViewModel();

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // listen for pedometer events and count them
    pedometerEvents?.listen((pedometerDataPoint) {
      PedometerDatum? _step = pedometerDataPoint.data as PedometerDatum?;
      print('Steps - got a step: $_step');
      if (_lastStep != null)
        _weeklySteps.increateStepCount(
            DateTime.now().weekday, _step!.stepCount! - _lastStep!.stepCount!);
      _lastStep = _step;
    });
  }
}

/// Weekly steps organized by the day of the week.
class WeeklySteps {
  final Map<int, int> _weeklySteps = {};

  WeeklySteps() {
    // initialize the weekly steps table
    for (int i = 1; i <= 7; i++) _weeklySteps[i] = 0;
  }

  /// A map of weekly steps organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  // @JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
  Map<int, int> get weeklySteps => _weeklySteps;

  /// The list of steps listed pr. weekday.
  List<DailySteps> get steps => _weeklySteps.entries
      .map((entry) => DailySteps(entry.key, entry.value))
      .toList();

  void increateStepCount(int weekday, int steps) {
    print('Steps - adding $steps for weekday $weekday');
    _weeklySteps[weekday] = _weeklySteps[weekday]! + steps;
  }

  String toString() {
    String _str = ' day | steps\n';
    _weeklySteps.forEach((day, steps) => _str += '  $day  | $steps\n');
    return _str;
  }
}

/// Steps pr. week day.
// @JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class DailySteps {
  /// Day of week - Monday = 1, Sunday = 7.
  final int weekday;

  /// Number of steps for this [weekday].
  final int steps;

  DailySteps(this.weekday, this.steps);

  /// Get the localilzed name of the [weekday].
  String toString() => DateFormat('EEEE')
      .format(DateTime(2021, 2, 7).add(Duration(days: weekday)))
      .substring(0, 3);
}
