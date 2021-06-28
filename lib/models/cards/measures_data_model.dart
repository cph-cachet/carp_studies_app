part of carp_study_app;

class MeasuresCardDataModel extends DataModel {
  final Map<String, int> _samplingTable = {};

  /// Stream of measures, i.e. [DataPoint] measures.
  Stream<DataPoint> get measureEvents => controller.data;

  /// The total sampling size
  int get samplingSize => controller.samplingSize;

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  /// The list of measures
  List<Measures> get measures => _samplingTable.entries
      .map((entry) => Measures(entry.key, entry.value))
      .toList();

  MeasuresCardDataModel() : super();

  void init(StudyDeploymentController controller) {
    super.init(controller);

    // listen to incoming events in order to count the measure types
    controller.data.listen((dataPoint) {
      final String key = dataPoint.carpHeader.dataFormat.name;
      if (!_samplingTable.containsKey(key)) _samplingTable[key] = 0;
      _samplingTable[key]++;
    });
  }

  String toString() {
    String _str = 'MEASURE\t| #\n';
    _samplingTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }

  // Orders the measures based on the amount of entries to display those with more entries
  void orderedMeasures() {
    var mapEntries = _samplingTable.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    _samplingTable
      ..clear()
      ..addEntries(mapEntries);

    print(_samplingTable);
  }
}

class Measures {
  final String measure;
  final int size;
  Measures(this.measure, this.size);
}
