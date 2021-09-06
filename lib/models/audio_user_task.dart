part of carp_study_app;

/// A user task handling audio recordings.
/// When started, creates a [AudioMeasurePage] and shows it to the user.
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

class AudioUserTaskFactory implements UserTaskFactory {
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
