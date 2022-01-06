part of carp_study_app;

class ActivityCardViewModel extends SerializableViewModel<WeeklyActivities> {
  ActivityDatum _lastActivity = new ActivityDatum(ActivityType.STILL, 100);

  @override
  WeeklyActivities createModel() => WeeklyActivities();
  Map<ActivityType, Map<int, int>> get activities => model.activities;
  List<DailyActivity> activitiesByType(ActivityType type) =>
      model.activitiesByType(type);

  ActivityCardViewModel() : super();

  /// Stream of activity [DataPoint] measures.
  Stream<DataPoint>? get activityEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is ActivityDatum);

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // listen for activity events and count the minutes
    activityEvents?.listen((activityDataPoint) {
      ActivityDatum activity = activityDataPoint.data as ActivityDatum;

      if (activity.type != _lastActivity.type) {
        // if we have a new type of activity
        // add the minutes to the last know activity type
        model.increaseActivityDuration(
            _lastActivity, activity.timestamp ?? DateTime.now());
        // and then save the new activity
        _lastActivity = activity;
      }
    });
  }
}

/// Weekly activities in minutes organized by type.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class WeeklyActivities extends DataModel {
  /// A map of activities oganized first by type and then by day of week.
  ///
  ///   (type,weekday,minutes)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<ActivityType, Map<int, int>> activities = {};

  /// A list of activities of a specific [type].
  List<DailyActivity> activitiesByType(ActivityType type) => activities[type]!
      .entries
      .map((entry) => DailyActivity(entry.key, entry.value))
      .toList();

  WeeklyActivities() {
    // // Initialize every week or if is the first time opening the app
    ActivityType.values.forEach(
      (type) {
        activities[type] = {};
        for (int i = 1; i <= 7; i++) activities[type]![i] = 0;
      },
    );
  }

  /// Increase the number of minutes of doing [activity] until [timestamp].
  void increaseActivityDuration(ActivityDatum activity, DateTime timestamp) {
    activities[activity.type]![activity.timestamp!.weekday] =
        activities[activity.type]![activity.timestamp!.weekday] ??
            0 + timestamp.difference(activity.timestamp!).inMinutes;
  }

  WeeklyActivities fromJson(Map<String, dynamic> json) =>
      _$WeeklyActivitiesFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyActivitiesToJson(this);

  String toString() {
    String _str = '  TYPE\t| day | min.\n';
    activities.forEach((type, data) => data.forEach((day, minutes) =>
        _str += '${type.toString().split(".").last}\t|  $day  |  $minutes\n'));
    return _str;
  }
}

/// An activity of a specific type for a specific week day [1..7] and
/// the number of active minutes that day.
class DailyActivity extends DailyMeasure {
  final int minutes;
  ActivityType? type;

  /// Activity [type] as a string.
  String get typeString => type.toString().split(".").last;

  DailyActivity(int weekday, this.minutes) : super(weekday);
}
