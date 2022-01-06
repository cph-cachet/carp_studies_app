part of carp_study_app;

class MobilityCardViewModel extends SerializableViewModel<WeeklyMobility> {
  @override
  WeeklyMobility createModel() => WeeklyMobility();

  Map<int, double?> get weeklyHomeStay => model.weeklyHomeStay;
  List<DailyMobility> get homeStay => model.homeStay;
  Map<int, int?> get weeklyPlaces => model.weeklyPlaces;
  List<DailyMobility> get places => model.places;
  Map<int, double?> get weeklyDistanceTraveled => model.weeklyDistanceTraveled;
  List<DailyMobility> get distance => model.distance;

  /// Stream of mobility [DataPoint] measures.
  Stream<DataPoint>? get mobilityEvents =>
      controller?.data.where((dataPoint) => dataPoint.data is MobilityDatum);

  MobilityCardViewModel();
  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // listen for mobility events and update the features
    mobilityEvents?.listen((mobilityDataPoint) {
      MobilityDatum _mobility = mobilityDataPoint.data as MobilityDatum;
      model.setMobilityFeatures(_mobility);
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
  final Map<int, double?> _weeklyHomeStay = {};
  final Map<int, int?> _weeklyPlaces = {};
  final Map<int, double?> _weeklyDistanceTraveled = {};

  /// A map of weekly home stays (%) organized by the day of the week.
  ///
  ///    (weekday,home_stay)
  ///
  Map<int, double?> get weeklyHomeStay => _weeklyHomeStay;

  /// The list of [DailyMobility] object representing home stay.
  List<DailyMobility> get homeStay => _weeklyHomeStay.entries
      .map((entry) => DailyMobility(entry.key, 0, entry.value, 0))
      .toList();

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  Map<int, int?> get weeklyPlaces => _weeklyPlaces;

  /// The list of [DailyMobility] object representing the places visited.
  List<DailyMobility> get places => _weeklyPlaces.entries
      .map((entry) => DailyMobility(entry.key, entry.value, 0, 0))
      .toList();

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  Map<int, double?> get weeklyDistanceTraveled => _weeklyDistanceTraveled;

  /// The list of [DailyMobility] object representing distance traveled.
  List<DailyMobility> get distance => _weeklyDistanceTraveled.entries
      .map((entry) => DailyMobility(entry.key, 0, 0, entry.value))
      .toList();

  WeeklyMobility() {
    for (int i = 1; i <= 7; i++) {
      _weeklyDistanceTraveled[i] = 0;
      _weeklyHomeStay[i] = 0;
      _weeklyPlaces[i] = 0;
    }
  }

  void setMobilityFeatures(MobilityDatum data) {
    DateTime day = data.date ?? DateTime.now();
    weeklyDistanceTraveled[day.weekday] =
        data.distanceTravelled ?? weeklyDistanceTraveled[day.weekday];
    weeklyHomeStay[day.weekday] = data.homeStay ?? weeklyHomeStay[day.weekday];
    weeklyPlaces[day.weekday] =
        data.numberOfPlaces ?? weeklyPlaces[day.weekday];
  }

  WeeklyMobility fromJson(Map<String, dynamic> json) =>
      _$WeeklyMobilityFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyMobilityToJson(this);
}

/// Mobility features for a weekday.
class DailyMobility extends DailyMeasure {
  final int? places;
  final double? homeStay;
  final double? distance;

  DailyMobility(int weekday, this.places, this.homeStay, this.distance)
      : super(weekday);
}
