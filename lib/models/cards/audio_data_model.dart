part of carp_study_app;

class AudioCardDataModel extends DataModel {
  // StudyController _controller;
  final Map<String, int> _samplingTable = {};

  /// Stream of measures, i.e. [Datum] measures.
  Stream<Datum> get measureEvents => controller.events;

  /// The total sampling size
  int get samplingSize => audioTaskCompleted;

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  /// The list of measures
  List<Audio> get measures => _samplingTable.entries.map((entry) => Audio(entry.key, entry.value)).toList();

  AudioCardDataModel() : super();

  void init(StudyController controller) {
    super.init(controller);

    // initialize the sampling table
    // controller.study.tasks.forEach((task) => _samplingTable[task.name] = 0);
    controller.study.measures
        .where((measure) => measure.type == MeasureType(NameSpace.CARP, AudioSamplingPackage.AUDIO))
        .forEach((measure) => _samplingTable[measure.name] = 0);

    // listen to incoming events in order to count the measure types
    // controller.events.listen((datum) => _samplingTable[datum.format.name]++);
    controller.events.listen((datum) {
      if (_samplingTable.containsKey(datum.format.name)) _samplingTable[datum.format.name]++;
    });
  }

  String toString() {
    String _str = 'MEASURE\t| #\n';
    _samplingTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }

  int get audioTaskCompleted => AppTaskController()
      .userTaskQueue
      .where((task) => task.state == UserTaskState.done && task.type == AudioUserTask.AUDIO_TYPE)
      .length;

  // Orders the measures based on the amount of entries to display those with more entries
  void orderedMeasures() {
    var mapEntries = _samplingTable.entries.toList()..sort((b, a) => a.value.compareTo(b.value));
    _samplingTable
      ..clear()
      ..addEntries(mapEntries);

    print(_samplingTable);
  }

  List<String> listId = [];

  void updateMeasures() {
    print(listId);
    AppTaskController()
        .userTaskQueue
        .where((task) => task.state == UserTaskState.done && task.type == AudioUserTask.AUDIO_TYPE)
        .forEach((task) {
      if (!listId.contains(task.id) && _samplingTable.containsKey(task.title)) {
        _samplingTable[task.title]++;
        listId.add(task.id);
      }
    });
  }
}

class Audio {
  final String audioName;
  final int size;
  Audio(this.audioName, this.size);
}
