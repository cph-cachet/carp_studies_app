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
  void init(SmartphoneDeploymentController ctrl) {
    super.init(ctrl);
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

  /// Persistently save the [model].
  /// Returns true if successful, false otherwise.
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

  /// Permanently delete the [model].
  /// Returns true if successful, false otherwise.
  Future<bool> delete() async {
    bool success = true;
    try {
      String name = (await filename);
      info("Deleting $runtimeType data to file '$name'.");
      File(name).deleteSync();
    } catch (exception) {
      success = false;
      warning('Failed to delete $runtimeType data - $exception');
    }
    return success;
  }

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

  /// Get the localized name of the [weekday].
  @override
  String toString() => DateFormat('EEEE')
      .format(DateTime(2021, 2, 7).add(Duration(days: weekday)))
      .substring(0, 3);
}

/// A measure for a specific hour of the day. [hour] and [minute] is the time of the day in 24 hour format.
/// [hour] is numbered in accordance with Dart [DateTime] a day starts with 0.
class HourlyMeasure {
  final int hour;
  final int minute;

  HourlyMeasure(this.hour, this.minute);

  @override
  String toString() => '$hour:$minute';
}

/// The view model for the entire app.
class CarpStudyAppViewModel extends ViewModel {
  final DataVisualizationPageViewModel _dataVisualizationPageViewModel =
      DataVisualizationPageViewModel();
  final StudyPageViewModel _studyPageViewModel = StudyPageViewModel();
  final TaskListPageViewModel _taskListPageViewModel = TaskListPageViewModel();
  final ProfilePageViewModel _profilePageViewModel = ProfilePageViewModel();
  final DevicesPageViewModel _devicesPageViewModel = DevicesPageViewModel();

  CarpStudyAppViewModel() : super();

  DataVisualizationPageViewModel get dataVisualizationPageViewModel =>
      _dataVisualizationPageViewModel;
  StudyPageViewModel get studyPageViewModel => _studyPageViewModel;
  TaskListPageViewModel get taskListPageViewModel => _taskListPageViewModel;
  ProfilePageViewModel get profilePageViewModel => _profilePageViewModel;
  DevicesPageViewModel get devicesPageViewModel => _devicesPageViewModel;

  @override
  void init(SmartphoneDeploymentController ctrl) {
    super.init(ctrl);
    _dataVisualizationPageViewModel.init(ctrl);
    _studyPageViewModel.init(ctrl);
    _taskListPageViewModel.init(ctrl);
    _profilePageViewModel.init(ctrl);
    _devicesPageViewModel.init(ctrl);
  }
}
