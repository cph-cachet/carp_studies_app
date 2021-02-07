part of carp_study_app;

class MobilityCardDataModel extends DataModel {
  final Map<int, double> _weeklyHomeStay = {};
  final Map<int, int> _weeklyPlaces = {};
  final Map<int, double> _weeklyDistanceTraveled = {};

  /// A map of weekly home stays (%) organized by the day of the week.
  ///
  ///    (weekday,home_stay)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, double> get weeklyHomeStay => _weeklyHomeStay;

  /// The list of [Mobility] object representing home stay.
  List<Mobility> get homeStay => _weeklyHomeStay.entries
      .map((entry) => Mobility(entry.key, 0, entry.value, 0))
      .toList();

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> get weeklyPlaces => _weeklyPlaces;

  /// The list of [Mobility] object representing the places visited.
  List<Mobility> get places => _weeklyPlaces.entries
      .map((entry) => Mobility(entry.key, entry.value, 0, 0))
      .toList();

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, double> get weeklyDistanceTraveled => _weeklyDistanceTraveled;

  /// The list of [Mobility] object representing distance traveled.
  List<Mobility> get distance => _weeklyDistanceTraveled.entries
      .map((entry) => Mobility(entry.key, 0, 0, entry.value))
      .toList();

  MobilityCardDataModel();
  void init(StudyController controller) {
    super.init(controller);

    // Initialize with random data - TODO: remove
    for (int i = 1; i <= 7; i++) {
      _weeklyDistanceTraveled[i] = Random().nextInt(10).roundToDouble();
      _weeklyHomeStay[i] = Random().nextInt(100).roundToDouble();
      _weeklyPlaces[i] = Random().nextInt(10);
    }

    // listen for mobility events and count them
    controller.events.where((datum) => datum is MobilityDatum).listen((datum) {
      MobilityDatum _mobility = datum as MobilityDatum;
      // just collect the data asuming the date is correct
      _weeklyDistanceTraveled[_mobility.date.weekday] =
          _mobility.distanceTravelled;
      _weeklyHomeStay[_mobility.date.weekday] = _mobility.homeStay;
      _weeklyPlaces[_mobility.date.weekday] = _mobility.numberOfPlaces;
    });
  }
}

class Mobility {
  final int day;
  final int places;
  final double homeStay;
  final double distance;

  Mobility(this.day, this.places, this.homeStay, this.distance);

  /// Get the localilzed name of the [day].
  String toString() => DateFormat('EEEE')
      .format(DateTime(2021, 2, 7).add(Duration(days: day)))
      .substring(0, 3);
}
