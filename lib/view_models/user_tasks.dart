part of carp_study_app;

/// A [UserTaskFactory] that can handle the user tasks in this app.
class AppUserTaskFactory implements UserTaskFactory {
  @override
  List<String> types = [
    SurveyUserTask.AUDIO_TYPE,
    SurveyUserTask.VIDEO_TYPE,
    SurveyUserTask.IMAGE_TYPE,
    SurveyUserTask.HEALTH_ASSESSMENT_TYPE,
  ];

  @override
  UserTask create(AppTaskExecutor executor) {
    switch (executor.task.type) {
      case SurveyUserTask.AUDIO_TYPE:
        return AudioUserTask(executor);
      case SurveyUserTask.VIDEO_TYPE:
        return VideoUserTask(executor);
      case SurveyUserTask.IMAGE_TYPE:
        return VideoUserTask(executor);
      case SurveyUserTask.HEALTH_ASSESSMENT_TYPE:
        return OneTimeBackgroundSensingUserTask(executor);
      default:
        return BackgroundSensingUserTask(executor);
    }
  }
}

/// A user task handling audio recordings.
/// When started, creates a [AudioTaskPage] and shows it to the user.
class AudioUserTask extends UserTask {
  final StreamController<int> _countDownController =
      StreamController.broadcast();
  Stream<int>? get countDownEvents => _countDownController.stream;

  /// Total duration of audio recording in seconds.
  int recordingDuration = 60;

  /// Seconds left in ongoing recording
  int ongoingRecordingDuration = 60;

  AudioUserTask(AppTaskExecutor executor) : super(executor) {
    recordingDuration = (executor.task.minutesToComplete != null)
        ? executor.task.minutesToComplete! * 60
        : 60;
  }

  Timer? _timer;

  /// Callback when recording is to start.
  void onRecordStart() {
    ongoingRecordingDuration = recordingDuration;
    state = UserTaskState.started;
    backgroundTaskExecutor.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _countDownController.add(--ongoingRecordingDuration);

      if (ongoingRecordingDuration <= 0) {
        _timer?.cancel();
        _countDownController.close();

        backgroundTaskExecutor.stop();
        super.onDone();
      }
    });
  }

  /// Callback when recording is to stop.
  void onRecordStop() {
    _timer?.cancel();
    _countDownController.close();

    backgroundTaskExecutor.stop();
    super.onDone();
  }
}

/// A user task handling video and image recordings.
/// When started, creates a [CameraTaskPage].
class VideoUserTask extends UserTask {
  VideoUserTask(super.executor);

  @override
  bool get hasWidget => true;

  @override
  Widget? get widget => CameraTaskPage(mediaUserTask: this);

  DateTime? _startRecordingTime, _endRecordingTime;
  XFile? _file;
  MediaType _mediaType = MediaType.image;

  /// Callback when a picture is captured.
  void onPictureCapture(XFile image) {
    debug('$runtimeType - onPictureCapture(), media: ${image.path}');
    _file = image;
    _mediaType = MediaType.image;
    _startRecordingTime = DateTime.now();
    _endRecordingTime = DateTime.now();

    backgroundTaskExecutor.start();
  }

  /// Callback when video recording is started.
  void onRecordStart() {
    debug('$runtimeType - onRecordStart()');
    _startRecordingTime = DateTime.now();
    backgroundTaskExecutor.start();
  }

  /// Callback when video recording is stopped.
  void onRecordStop(XFile media) {
    debug('$runtimeType - onRecordStop(), media: ${media.path}');
    _file = media;
    _endRecordingTime = DateTime.now();
    _mediaType = MediaType.video;
  }

  /// Callback when the recorded image/video is to be "saved", i.e. committed to
  /// the data stream.
  void onSave() {
    debug('$runtimeType - onSave(), file: ${_file?.path}');
    if (_file != null) {
      // create the media measurement directly here...
      Media media = Media(
          filename: _file!.path,
          startRecordingTime: _startRecordingTime!,
          endRecordingTime: _endRecordingTime,
          mediaType: _mediaType)
        ..filename = _file!.path.split("/").last
        ..path = _file!.path;

      // ... and add it to the sensing controller
      bloc.addMeasurement(Measurement.fromData(media));
    }
    backgroundTaskExecutor.stop();
    super.onDone();
  }
}
