part of carp_study_app;

class MeasuresCardDataModel extends DataModel {
  // StudyController _controller;
  final Map<String, int> _samplingTable = {};

  /// Stream of measures, i.e. [Datum] measures.
  Stream<Datum> get measureEvents => controller.events;

  /// The total sampling size
  int get samplingSize => controller.samplingSize;

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  MeasuresCardDataModel() : super();

  void init(StudyController controller) {
    super.init(controller);

    // initialize the sampling table
    controller.study.measures
        .forEach((measure) => _samplingTable[measure.type.name] = 2); // TODO - change back to 0

    // listen to incoming events in order to count the measure types
    controller.events.listen((datum) => _samplingTable[datum.format.name]++);
  }

  String toString() {
    String _str = 'MEASURE\t| #\n';
    _samplingTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }
}

class Measures {
  final String measure;
  final int size;
  Measures(this.measure, this.size);
}
