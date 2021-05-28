part of carp_study_app;

class SurveysCardDataModel extends DataModel {
  final Map<String, int> _samplingTable = {};

  /// Stream of survey measures, i.e. [DataPoint] measures.
  Stream<DataPoint> get measureEvents => controller.data;

  /// The total sampling size
  int get samplingSize => surveysCompleted; //controller.samplingSize;

  /// A table with sampling size of each measure type
  Map<String, int> get samplingTable => _samplingTable;

  /// The list of measures
  List<Surveys> get measures =>
      _samplingTable.entries.map((entry) => Surveys(entry.key, entry.value)).toList();

  SurveysCardDataModel() : super();

  void init(StudyDeploymentController controller) {
    super.init(controller);

    // initialize the sampling table
    //controller.study.measures.forEach((measure) => _samplingTable[measure.name] = 0);
    // controller.study.measures
    //     .where((measure) => measure.type == MeasureType(NameSpace.CARP, SurveySamplingPackage.SURVEY))
    //     .forEach((measure) => _samplingTable[measure.name] = 0);

    // listen to incoming events in order to count the measure types
    //controller.events.listen((datum) => _samplingTable[datum.format.name]++);
    controller.data.listen((dataPoint) {
      print("Data Point: ");
      print(dataPoint);
      final String key = dataPoint.carpHeader.dataFormat.name;
      if (!_samplingTable.containsKey(key)) _samplingTable[key] = 0;
      _samplingTable[key]++;
    });
  }

  String toString() {
    String _str = 'SURVEY\t| #\n';
    _samplingTable.forEach((type, no) => _str += '$type\t| $no\n');
    return _str;
  }

  int get surveysCompleted => AppTaskController()
      .userTaskQueue
      .where((task) => task.state == UserTaskState.done && task.type == SurveyUserTask.SURVEY_TYPE)
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
        .where((task) => task.state == UserTaskState.done && task.type == SurveyUserTask.SURVEY_TYPE)
        .forEach((task) {
      if (!listId.contains(task.id) && _samplingTable.containsKey(task.title)) {
        _samplingTable[task.title]++;
        listId.add(task.id);
      }
    });
  }
}

class Surveys {
  final String surveyName;
  final int size;
  Surveys(this.surveyName, this.size);
}
