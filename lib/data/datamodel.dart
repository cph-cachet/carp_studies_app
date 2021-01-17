part of carp_study_app;

/// The data model for the entire app.
class CarpStydyAppDataModel {
  StudyController _controller;
  PedometerDatum _lastStep;
  ActivityDatum _lastActivity = ActivityDatum()
    ..type = ActivityType.STILL
    ..confidence = 100;

  /// The total sampling size
  int get samplingSize => _controller.samplingSize;

  final Map<String, int> _samplingTable = {};

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  void printSamplingTable() =>
      _samplingTable.forEach((type, no) => print('$type : $no'));

  final Map<int, int> _weeklySteps = {};

  /// A map of weekly steps organized by the day of the week.
  ///
  ///    (weekday,step_count)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> get weeklySteps => _weeklySteps;

  void printWeeklySteps() =>
      _weeklySteps.forEach((day, steps) => print('$day : $steps'));

  final Map<ActivityType, Map<int, int>> _activities = {};

  /// A map of activities oganized first by type and then by day of week.
  ///
  ///   (type,weekday,minutes)
  Map<ActivityType, Map<int, int>> get activities => _activities;

  void printWeeklyActivities() => _activities.forEach((type, data) =>
      data.forEach((day, minutes) => print('$type : $day, $minutes')));

  final Map<int, double> _weeklyHomeStay = {};

  /// A map of weekly home stays (%) organized by the day of the week.
  ///
  ///    (weekday,home_stay)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, double> get weeklyHomeStay => _weeklyHomeStay;

  final Map<int, int> _weeklyPlaces = {};

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> get weeklyPlaces => _weeklyPlaces;

  final Map<int, double> _weeklyDistanceTraveled = {};

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, double> get weeklyDistanceTraveled => _weeklyDistanceTraveled;

  Future<void> init(StudyController controller) async {
    _controller = controller;

    // initialize the sampling table
    controller.study.measures
        .forEach((measure) => _samplingTable[measure.type.name] = 0);

    // initialize the weekly steps table
    // TODO - set values to zero once a new week starts.
    for (int i = 1; i <= 7; i++) _weeklySteps[i] = 0;

    // initialize the activity weekly tables
    // TODO - set values to zero once a new week starts.
    ActivityType.values.forEach((type) {
      _activities[type] = {};
      for (int i = 1; i <= 7; i++) _activities[type][i] = 0;
    });

    // listen to incoming events in order to build the data models
    controller.events.listen((datum) {
      print('>> datum: $datum');
      // update the sampling table
      _samplingTable[datum.format.name]++;

      switch (datum.runtimeType) {
        case PedometerDatum:
          PedometerDatum _step = datum as PedometerDatum;
          _weeklySteps[DateTime.now().weekday] +=
              (_lastStep != null) ? _step.stepCount - _lastStep.stepCount : 0;
          _lastStep = _step;
          break;
        case ActivityDatum:
          ActivityDatum _activity = datum as ActivityDatum;

          if (_activity.type != _lastActivity.type) {
            // if we have a new type of activity
            // add the minutes to the last know activity type
            _activities[_lastActivity.type][DateTime.now().weekday] += _activity
                .timestamp
                .difference(_lastActivity.timestamp)
                .inMinutes;
            // and then save the new activity
            _lastActivity = _activity;
          }
          break;
        case MobilityDatum:
          MobilityDatum _mobility = datum as MobilityDatum;
          // just collect the data asuming the date is correct
          _weeklyDistanceTraveled[_mobility.date.weekday] =
              _mobility.distanceTravelled;
          _weeklyHomeStay[_mobility.date.weekday] = _mobility.homeStay;
          _weeklyPlaces[_mobility.date.weekday] = _mobility.numberOfPlaces;
          break;
      }
    });
  }
}

class Steps {
  final DateTime date;
  final int steps;
  Steps(this.date, this.steps);
}

class Activity {
  ActivityType type;

  /// Activity [type] as a string.
  String get typeString => type.toString().split(".").last;

  final DateTime date;
  final int minutes;
  Activity(this.date, this.minutes);
}
