part of carp_study_app;

/// An abstract view model used for all other view models in the app.
abstract class ViewModel {
  SmartphoneDeploymentController? _controller;

  SmartphoneDeploymentController? get controller => _controller;

  /// Initialize this view model before use.
  @mustCallSuper
  void init(SmartphoneDeploymentController ctrl) {
    _controller = ctrl;
  }
}

/// A serializable data model to be used in a [SerializableViewModel].
abstract class DataModel {
  DataModel();
  DataModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

/// An abstract view model which can serialize its [DataModel] across app restart.
abstract class SerializableViewModel<D extends DataModel> extends ViewModel {
  /// The current data model.
  ///
  /// The data model is either created using the [createModel] method or loaded
  /// from persistent storage.
  D get model => _model!;
  D? _model;

  /// The [DataModel] to be serialized.
  ///
  /// Subclasses should override this method to return a newly created instance
  /// of their associated [DataModel] subclass. For example:
  ///
  /// ```dart
  /// @override
  /// MyDataModel createModel() => MyDataModel();
  /// ```
  @protected
  D createModel();

  @override
  @mustCallSuper
  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
    _model = createModel();

    // restore the data model (if any saved)
    restore().then((savedModel) => _model = savedModel ?? _model);

    // save the data model on a regular basis.
    Timer.periodic(const Duration(minutes: 5), (_) => save(model.toJson()));
  }

  /// Current path and filename of the data.
  Future<String> get filename async {
    String path = await LocalSettings().deploymentBasePath ?? '';
    return '$path/$runtimeType.json';
  }

  Future<bool> save(Map<String, dynamic> json) async {
    bool success = true;
    try {
      String name = (await filename);
      info("Saving $runtimeType data to file '$name'.");
      File(name).writeAsStringSync(jsonEncode(json));
    } catch (exception) {
      success = false;
      warning('Failed to save $runtimeType data - $exception');
    }
    return success;
  }

  // Future<Map<String, dynamic>> restore() async {
  //   Map<String, dynamic> result = {};
  //   try {
  //     String name = (await filename);
  //     info("Restoring $runtimeType data from file '$name'.");
  //     String jsonString = File(name).readAsStringSync();
  //     result = json.decode(jsonString) as Map<String, dynamic>;
  //   } catch (exception) {
  //     warning('Failed to load $runtimeType - $exception');
  //   }
  //   return result;
  // }

  Future<D?> restore() async {
    D? result;
    try {
      String name = (await filename);
      info("Restoring $runtimeType data from file '$name'.");
      final jsonString = File(name).readAsStringSync();
      final modelAsJson = json.decode(jsonString) as Map<String, dynamic>;
      result = model.fromJson(modelAsJson) as D;
    } catch (exception) {
      warning('Failed to load $runtimeType - $exception');
    }
    return result;
  }
}

/// A measure for a specific week day. [weekday] is numbered in accordance with
/// Dart [DateTime] a week starts with Monday, which has the value 1.
class DailyMeasure {
  /// Day of week - Monday = 1, Sunday = 7.
  final int weekday;

  DailyMeasure(this.weekday);

  /// Get the localilzed name of the [weekday].
  @override
  String toString() =>
      DateFormat('EEEE').format(DateTime(2021, 2, 7).add(Duration(days: weekday))).substring(0, 3);
}

/// The view model for the entire app.
class CarpStydyAppViewModel extends ViewModel {
  final DataVisualizationPageViewModel _dataVisualizationPageViewModel = DataVisualizationPageViewModel();
  final StudyPageViewModel _studyPageViewModel = StudyPageViewModel();
  final TaskListPageViewModel _taskListPageViewModel = TaskListPageViewModel();
  final ProfilePageViewModel _profilePageViewModel = ProfilePageViewModel();
  final DevicesPageViewModel _devicesPageViewModel = DevicesPageViewModel();

  CarpStydyAppViewModel() : super();

  DataVisualizationPageViewModel get dataVisualizationPageViewModel => _dataVisualizationPageViewModel;
  StudyPageViewModel get studyPageViewModel => _studyPageViewModel;
  TaskListPageViewModel get taskListPageViewModel => _taskListPageViewModel;
  ProfilePageViewModel get profilePageViewModel => _profilePageViewModel;
  DevicesPageViewModel get devicesPageViewModel => _devicesPageViewModel;

  @override
  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
    _dataVisualizationPageViewModel.init(controller);
    _studyPageViewModel.init(controller);
    _taskListPageViewModel.init(controller);
    _profilePageViewModel.init(controller);
    _devicesPageViewModel.init(controller);
  }
}
