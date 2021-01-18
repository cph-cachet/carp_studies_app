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

  StepsCardDataModel();

  void init(StudyController controller) {
    super.init(controller);

    // initialize the weekly steps table
    // TODO - set values to zero once a new week starts.
    for (int i = 1; i <= 7; i++) _weeklySteps[i] = 0;

    // listen for pedometer events and count them
    controller.events.where((datum) => datum is PedometerDatum).listen((datum) {
      PedometerDatum _step = datum as PedometerDatum;
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
  final DateTime date;
  final int steps;
  Steps(this.date, this.steps);
}
