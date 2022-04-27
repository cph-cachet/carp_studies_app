part of carp_study_app;

class MeasuresCardViewModel extends ViewModel {
  final Map<String, int> _samplingTable = {};

  int _samplingSize = 0;

  /// Stream of [DataPoint] measures.
  Stream<DataPoint>? get measureEvents => controller?.data;

  /// The total sampling size
  int get samplingSize => _samplingSize;

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  /// The list of measures
  List<MeasureCount> get measures =>
      _samplingTable.entries.map((entry) => MeasureCount(entry.key, entry.value)).toList();

  /// The number of measures event to remove (in order to not show sensor events)
  int numToRemove = 0;

  MeasuresCardViewModel() : super();

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // listen to incoming events in order to count the measure types
    controller.data.listen((dataPoint) {
      final String key = dataPoint.carpHeader.dataFormat.name;
      // Do not add sensor events as measures
      if (key != 'sensor') {
        if (!_samplingTable.containsKey(key)) _samplingTable[key] = 0;
        _samplingTable[key] = _samplingTable[key]! + 1;
      } else
        numToRemove += 1;
    });
  }

  String toString() {
    String _str = 'MEASURE\t| #\n';
    _samplingTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }

  /// Order the measures based on the amount of entries
  void orderedMeasures() {
    var mapEntries = _samplingTable.entries.toList()..sort((b, a) => a.value.compareTo(b.value));
    _samplingTable
      ..clear()
      ..addEntries(mapEntries);
  }

  void removeSensingEvents() {
    _samplingSize = controller!.samplingSize - numToRemove;
  }
}

/// Holds the count for a measure.
class MeasureCount {
  final String measure;
  final int size;
  MeasureCount(this.measure, this.size);
}
