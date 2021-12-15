part of carp_study_app;

/// A [UserTaskFactory] that can handle the user tasks in this app.
class AppUserTaskFactory implements UserTaskFactory {
  List<String> types = [
    AudioUserTask.AUDIO_TYPE,
  ];

  UserTask create(AppTaskExecutor executor) {
    switch (executor.appTask.type) {
      case AudioUserTask.AUDIO_TYPE:
        return AudioUserTask(executor);
      default:
        return SensingUserTask(executor);
    }
  }
}

/// A user task handling audio recordings.
/// When started, creates a [AudioTaskPage] and shows it to the user.
class AudioUserTask extends UserTask {
  static const String AUDIO_TYPE = 'audio';

  StreamController<int>? _countDownController;
  Stream<int>? get countDownEvents => _countDownController?.stream;

  /// Total duration of audio recording in seconds.
  int recordingDuration = 60;

  /// Seconds left in ongoing recording
  int? ongoingRecordingDuration;

  AudioUserTask(AppTaskExecutor executor) : super(executor) {
    recordingDuration = (executor.appTask.minutesToComplete != null)
        ? executor.appTask.minutesToComplete! * 60
        : 60;
  }

  void onStart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AudioTaskPage(audioUserTask: this)),
    );
  }

  Timer? timer;

  /// Callback when recording is to start.
  void onRecordStart() {
    _countDownController = StreamController.broadcast();
    ongoingRecordingDuration = recordingDuration;
    state = UserTaskState.started;
    executor.resume();

    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (ongoingRecordingDuration != null)
        _countDownController!.add(ongoingRecordingDuration! - 1);

      if (ongoingRecordingDuration == 0) {
        timer.cancel();
        _countDownController!.close();

        executor.pause();
        state = UserTaskState.done;
      }
    });
  }

  /// Callback when recording is to stop.
  void onRecordStop() {
    timer?.cancel();
    _countDownController!.close();

    executor.pause();
    state = UserTaskState.done;
  }
}

/// A user task handling video and image recordings.
/// When started, creates a [CameraTaskPage] and shows it to the user.
class VideoUserTask extends UserTask {
  static const String VIDEO_TYPE = 'video';

  VideoUserTask(AppTaskExecutor executor) : super(executor);

  VideoProbe get videoProbe => executor.probes
          .firstWhere((probe) => probe.type == AudioVideoSamplingPackage.VIDEO)
      as VideoProbe;

  void onStart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraTaskPage(videoUserTask: this)),
    );
  }

  DateTime? _startRecordingTime, _endRecordingTime;
  XFile? file;
  VideoType _videoType = VideoType.image;

  /// Callback when a picture is captured.
  void onPictureCapture(XFile image) {
    onRecordStart();

    // now wait for 2 secs to finish up any other sensing in the task
    Timer(const Duration(seconds: 2),
        () => onRecordStop(image, videoType: VideoType.image));
  }

  /// Callback when video recording is started.
  void onRecordStart() {
    _startRecordingTime = DateTime.now();
    state = UserTaskState.started;
    executor.resume();
  }

  /// Callback when video recording is stopped.
  void onRecordStop(XFile video, {VideoType videoType = VideoType.video}) {
    executor.pause();
    file = video;
    _videoType = videoType;
    state = UserTaskState.done;
  }

  /// Callback when the recorded image/video is to be "saved", i.e. committed to
  /// data stream.
  void onSave() {
    if (file != null) {
      // create the datum directly here...
      VideoDatum datum = VideoDatum(
          filename: file!.path,
          startRecordingTime: _startRecordingTime!,
          endRecordingTime: _endRecordingTime,
          videoType: _videoType)
        ..filename = file!.path.split("/").last;

      // ... and add it to the probe controller
      videoProbe.controller.add(datum);
    }
  }
}
