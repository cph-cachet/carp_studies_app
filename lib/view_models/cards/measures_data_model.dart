part of carp_study_app;

class MeasuresCardViewModel extends ViewModel {
  final Map<String, int> _samplingTable = {};

  /// Stream of [DataPoint] measures.
  Stream<DataPoint>? get measureEvents => controller?.data;

  /// Stream of more quiet [DataPoint] measures.
  Stream<DataPoint>? get quietMeasureEvents => controller?.data
      .where((dataPoint) => dataPoint.carpHeader.dataFormat.name != 'sensor');

  /// The total sampling size
  int get samplingSize =>
      controller?.samplingSize == null ? 0 : controller!.samplingSize;
  // samplingTable.values.fold(0, (prev, element) => prev + element);

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable {
    quietMeasureEvents?.listen((dataPoint) {
      String key = dataPoint.carpHeader.dataFormat.name;
      if (!_samplingTable.containsKey(key)) _samplingTable[key] = 0;
      _samplingTable[key] = _samplingTable[key]! + 1;
    });
    return _samplingTable;
  }

  /// The list of measures
  List<MeasureCount> get measures {
    // sort them first
    var mapEntries = _samplingTable.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    Map<String, int> sortedTasksTable = {}..addEntries(mapEntries);

    // and map to the [TaskCount] model
    List<MeasureCount> tasksList = sortedTasksTable.entries
        .map((entry) => MeasureCount(entry.key, entry.value))
        .toList();

    return tasksList;
  }

  MeasuresCardViewModel() : super();

  // void init(SmartphoneDeploymentController controller) {
  //   super.init(controller);

  //   // listen to incoming events in order to count the measure types
  //   this.quietMeasureEvents?.listen((dataPoint) {
  //     final String key = dataPoint.carpHeader.dataFormat.name;

  //     if (!_samplingTable.containsKey(key)) _samplingTable[key] = 0;
  //     _samplingTable[key] = _samplingTable[key]! + 1;
  //   });
  // }

  @override
  String toString() {
    String str = 'MEASURE\t| #\n';
    samplingTable.forEach((type, no) => str += '$type\t| $no\n');
    return str;
  }

  // /// Order the measures based on the amount of entries
  // void orderedMeasures() {
  //   var mapEntries = _samplingTable.entries.toList()..sort((b, a) => a.value.compareTo(b.value));
  //   _samplingTable
  //     ..clear()
  //     ..addEntries(mapEntries);
  // }
}

/// Holds the count for a measure.
class MeasureCount {
  final String title;
  final int size;
  MeasureCount(this.title, this.size);
}
