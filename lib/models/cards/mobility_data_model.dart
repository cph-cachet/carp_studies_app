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

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, int> get weeklyPlaces => _weeklyPlaces;

  /// A map of weekly places organized by the day of the week.
  ///
  ///    (weekday,places)
  ///
  /// In accordance with Dart [DateTime] a week starts with Monday,
  /// which has the value 1.
  Map<int, double> get weeklyDistanceTraveled => _weeklyDistanceTraveled;

  MobilityCardDataModel();
  void init(StudyController controller) {
    super.init(controller);

    // Initialize with random data - TODO: remove
    for (int i = 1; i <= 7; i++) {
      _weeklyDistanceTraveled[i] = Random().nextInt(10).roundToDouble();
      _weeklyHomeStay[i] = Random().nextInt(100).roundToDouble();
      _weeklyPlaces[i] = Random().nextInt(10);
    }

    // listen for pedometer events and count them
    controller.events.where((datum) => datum is MobilityDatum).listen((datum) {
      MobilityDatum _mobility = datum as MobilityDatum;
      // just collect the data asuming the date is correct
      _weeklyDistanceTraveled[_mobility.date.weekday] = _mobility.distanceTravelled;
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

  String toString() {
    if (this.day == 1)
      return "Mon";
    else if (this.day == 2)
      return "Tue";
    else if (this.day == 3)
      return "Wed";
    else if (this.day == 4)
      return "Thu";
    else if (this.day == 5)
      return "Fri";
    else if (this.day == 6)
      return "Sat";
    else if (this.day == 7)
      return "Sun";
    else
      return "?";
  }

  Mobility(this.day, this.places, this.homeStay, this.distance);
}
