part of carp_study_app;

/// An abstract view model used for all other view models in the app.
abstract class ViewModel {
  SmartphoneDeploymentController? _controller;

  SmartphoneDeploymentController? get controller => _controller;

  /// Initialize this view model before use.
  @mustCallSuper
  void init(SmartphoneDeploymentController ctrl) {
    this._controller = ctrl;
  }
}

/// A serializable data model to be used in a [SerializableViewModel].
abstract class DataModel {
  DataModel();
  DataModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

/// An abstract view model which can serialize a [DataModel] across app restart.
abstract class SerializableViewModel<D extends DataModel> extends ViewModel {
  /// The [DataModel] to be serialized.
  late D dataModel;

  @mustCallSuper
  void init(SmartphoneDeploymentController controller) {
    super.init(controller);

    // restore the data model
    restore().then((json) => dataModel = dataModel.fromJson(json) as D);

    // save the data model on a regular basis.
    Timer.periodic(const Duration(minutes: 1), (_) => save(dataModel.toJson()));
  }

  /// Current path and filename of the data.
  Future<String> get filename async {
    String path = await Settings().deploymentBasePath ?? '';
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

  Future<Map<String, dynamic>> restore() async {
    Map<String, dynamic> result = {};
    try {
      String name = (await filename);
      info("Restoring $runtimeType data from file '$name'.");
      String jsonString = File(name).readAsStringSync();
      result = json.decode(jsonString) as Map<String, dynamic>;
    } catch (exception) {
      warning('Failed to load $runtimeType - $exception');
    }
    return result;
  }
}

/// The view model for the entire app.
class CarpStydyAppViewModel extends ViewModel {
  final DataVisualizationPageViewModel _dataVisualizationPageViewModel =
      DataVisualizationPageViewModel();
  final StudyPageViewModel _studyPageViewModel = StudyPageViewModel();
  final TaskListPageViewModel _taskListPageViewModel = TaskListPageViewModel();
  final ProfilePageViewModel _profilePageViewModel = ProfilePageViewModel();

  CarpStydyAppViewModel() : super();

  DataVisualizationPageViewModel get dataVisualizationPageViewModel =>
      _dataVisualizationPageViewModel;
  StudyPageViewModel get studyPageViewModel => _studyPageViewModel;
  TaskListPageViewModel get taskListPageViewModel => _taskListPageViewModel;
  ProfilePageViewModel get profilePageViewModel => _profilePageViewModel;

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
    _dataVisualizationPageViewModel.init(controller);
    _studyPageViewModel.init(controller);
    _taskListPageViewModel.init(controller);
    _profilePageViewModel.init(controller);
  }
}
