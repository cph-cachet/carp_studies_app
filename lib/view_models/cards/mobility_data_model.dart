part of carp_study_app;

class MobilityCardViewModel extends SerializableViewModel<WeeklyMobility> {
  @override
  WeeklyMobility createModel() => WeeklyMobility();

  Map<int, int> get weeklyHomeStay => model.weeklyHomeStay;
  List<DailyMobility> get homeStay => model.homeStay;
  Map<int, int> get weeklyPlaces => model.weeklyPlaces;
  List<DailyMobility> get places => model.places;
  Map<int, double> get weeklyDistanceTraveled => model.weeklyDistanceTraveled;
  List<DailyMobility> get distance => model.distance;

  /// Stream of mobility [DataPoint] measures.
  Stream<DataPoint>? get mobilityEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is MobilityDatum);

  MobilityCardViewModel();
  @override
  void init(SmartphoneDeploymentController ctrl) {
    super.init(ctrl);

    // listen for mobility events and update the features
    mobilityEvents?.listen((mobilityDataPoint) {
      MobilityDatum mobility = mobilityDataPoint.data as MobilityDatum;
      model.setMobilityFeatures(mobility);
    });
  }
}

/// Weekly mobility data in terms of
///  * percentage at home (home stay)
///  * visited places
///  * distance traveled
///
/// All organized pr week day. In accordance with Dart [DateTime] a week
/// starts with Monday, which has the value 1.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class WeeklyMobility extends DataModel {
  /// A map of weekly home stays (%) organized by the day of the week.
  Map<int, int> weeklyHomeStay = {};

  /// A map of weekly places organized by the day of the week.
  Map<int, int> weeklyPlaces = {};

  /// A map of distance traveled organized by the day of the week.
  Map<int, double> weeklyDistanceTraveled = {};

  /// The list of [DailyMobility] object representing home stay.
  List<DailyMobility> get homeStay => weeklyHomeStay.entries
      .map((entry) => DailyMobility(entry.key, 0, entry.value, 0))
      .toList();

  /// The list of [DailyMobility] object representing the places visited.
  List<DailyMobility> get places => weeklyPlaces.entries
      .map((entry) => DailyMobility(entry.key, entry.value, 0, 0))
      .toList();

  /// The list of [DailyMobility] object representing distance traveled.
  List<DailyMobility> get distance => weeklyDistanceTraveled.entries
      .map((entry) => DailyMobility(entry.key, 0, 0, entry.value))
      .toList();

  WeeklyMobility() {
    for (int i = 1; i <= 7; i++) {
      weeklyDistanceTraveled[i] = 0;
      weeklyHomeStay[i] = 0;
      weeklyPlaces[i] = 0;
    }
  }

  /// Update the mobility feature with [data].
  void setMobilityFeatures(MobilityDatum data) {
    DateTime day = data.date ?? DateTime.now();

    if (data.distanceTraveled != null) {
      weeklyDistanceTraveled[day.weekday] = data.distanceTraveled!;
    }
    if (data.numberOfPlaces != null) {
      weeklyPlaces[day.weekday] = data.numberOfPlaces!;
    }

    // only set home stay % if larger than zero (can return -1)
    // also convert to int (1-100) instead of double (0-1)
    if (data.homeStay != null && data.homeStay! > 0) {
      weeklyHomeStay[day.weekday] = (100 * data.homeStay!).toInt();
    }
  }

  @override
  WeeklyMobility fromJson(Map<String, dynamic> json) =>
      _$WeeklyMobilityFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WeeklyMobilityToJson(this);
}

/// Mobility features for a weekday.
class DailyMobility extends DailyMeasure {
  final int places;
  final int homeStay;
  final double distance;

  DailyMobility(int weekday, this.places, this.homeStay, this.distance)
      : super(weekday);
}
