part of carp_study_app;

class StepsCardDataModel extends DataModel {
  PedometerDatum _lastStep;
  final Map<int, int> _weeklySteps = {};

  /// A map of weekly steps organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> get weeklySteps => _weeklySteps;

  /// The list of steps.
  List<Steps> get steps => _weeklySteps.entries
      .map((entry) => Steps(entry.key, entry.value))
      .toList();

  StepsCardDataModel();

  void init(StudyDeploymentController controller) {
    super.init(controller);

    // initialize the weekly steps table
    if (DateTime.now().weekday == 1 || _weeklySteps.isEmpty) {
      for (int i = 1; i <= 7; i++) _weeklySteps[i] = 0;
    }

    // listen for pedometer events and count them
    controller.data
        .where((dataPoint) => dataPoint.data is PedometerDatum)
        .listen((pedometerDataPoint) {
      PedometerDatum _step = pedometerDataPoint.data as PedometerDatum;
      _weeklySteps[DateTime.now().weekday] +=
          (_lastStep != null) ? _step.stepCount - _lastStep.stepCount : 0;
      _lastStep = _step;
    });
  }

  String toString() {
    String _str = ' day | steps\n';
    _weeklySteps.forEach((day, steps) => _str += '  $day  | $steps\n');
    return _str;
  }
}

class Steps {
  final int day;
  final int steps;

  Steps(this.day, this.steps);

  /// Get the localilzed name of the [day].
  String toString() => DateFormat('EEEE')
      .format(DateTime(2021, 2, 7).add(Duration(days: day)))
      .substring(0, 3);
}
