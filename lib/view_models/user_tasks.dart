part of carp_study_app;

/// A [UserTaskFactory] that can handle the user tasks in this app.
class AppUserTaskFactory implements UserTaskFactory {
  @override
  List<String> types = [
    AudioUserTask.audioType,
    VideoUserTask.videoType,
    VideoUserTask.imageType,
  ];

  @override
  UserTask create(AppTaskExecutor executor) {
    switch (executor.task.type) {
      case AudioUserTask.audioType:
        return AudioUserTask(executor);
      case VideoUserTask.videoType:
        return VideoUserTask(executor);
      case VideoUserTask.imageType:
        return VideoUserTask(executor);
      default:
        return BackgroundSensingUserTask(executor);
    }
  }
}

/// A user task handling audio recordings.
/// When started, creates a [AudioTaskPage] and shows it to the user.
class AudioUserTask extends UserTask {
  static const String audioType = 'audio';

  late BuildContext _context;
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

  @override
  void onStart(BuildContext context) {
    // saving the build context for later use
    _context = context;
    super.onStart(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AudioTaskPage(audioUserTask: this)),
    );
  }

  Timer? _timer;

  /// Callback when recording is to start.
  void onRecordStart() {
    ongoingRecordingDuration = recordingDuration;
    state = UserTaskState.started;
    executor.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _countDownController.add(--ongoingRecordingDuration);

      if (ongoingRecordingDuration <= 0) {
        _timer?.cancel();
        _countDownController.close();

        executor.stop();
        super.onDone(_context);
      }
    });
  }

  /// Callback when recording is to stop.
  void onRecordStop() {
    _timer?.cancel();
    _countDownController.close();

    executor.stop();
    super.onDone(_context);
  }
}

/// A user task handling video and image recordings.
/// When started, creates a [CameraTaskPage] and shows it to the user.
class VideoUserTask extends UserTask {
  static const String videoType = 'video';
  static const String imageType = 'image';

  late BuildContext _context;

  VideoUserTask(AppTaskExecutor executor) : super(executor);

  @override
  void onStart(BuildContext context) async {
    // saving the build context for later use
    _context = context;

    super.onStart(context);

    final cameras = await availableCameras();
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CameraTaskPage(mediaUserTask: this, cameras: cameras)),
      );
    }
  }

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

    executor.start();
  }

  /// Callback when video recording is started.
  void onRecordStart() {
    debug('$runtimeType - onRecordStart()');
    _startRecordingTime = DateTime.now();
    executor.start();
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
    executor.stop();
    super.onDone(_context);
  }
}

// class ImageUserTask extends UserTask {
//   static const String IMAGE_TYPE = 'image';

//   ImageUserTask(AppTaskExecutor executor) : super(executor);

//   void onStart(BuildContext context) async {
//     final cameras = await availableCameras();
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CameraTaskPage(mediaUserTask: this, cameras: cameras)),
//     );
//   }

//   DateTime? _startRecordingTime, _endRecordingTime;
//   XFile? file;
//   MediaType _mediaType = MediaType.image;

//   /// Callback when a picture is captured.
//   void onPictureCapture(XFile image) {
//     onRecordStart();

//     // now wait for 2 secs to finish up any other sensing in the task
//     Timer(const Duration(seconds: 2), () => onRecordStop(image, mediaType: MediaType.image));
//   }

//   /// Callback when video recording is started.
//   void onRecordStart() {
//     _startRecordingTime = DateTime.now();
//     state = UserTaskState.started;
//     executor.resume();
//   }

//   /// Callback when video recording is stopped.
//   void onRecordStop(XFile video, {MediaType mediaType = MediaType.video}) {
//     executor.pause();
//     file = video;
//     _mediaType = mediaType;
//     state = UserTaskState.done;
//   }

//   /// Callback when the recorded image/video is to be "saved", i.e. committed to
//   /// data stream.
//   void onSave() {
//     if (file != null) {
//       // create the datum directly here...
//       MediaDatum datum = MediaDatum(
//           filename: file!.path,
//           startRecordingTime: _startRecordingTime!,
//           endRecordingTime: _endRecordingTime,
//           mediaType: _mediaType)
//         ..filename = file!.path.split("/").last;

//       // ... and add it to the sensing controller
//       bloc.addDatum(datum);
//     }
//   }
// }
