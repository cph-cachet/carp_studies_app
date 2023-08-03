part of carp_study_app;

class StudyPageViewModel extends ViewModel {
  String get title => bloc.deployment?.studyDescription?.title ?? 'Unnamed';
  String get description =>
      bloc.deployment?.studyDescription?.description ?? '';
  String get purpose => bloc.deployment?.studyDescription?.purpose ?? '';
  Image get image => Image.asset('assets/images/study.png');
  String? get userID => bloc.deployment?.userId;
  String get studyDescriptionUrl =>
      bloc.deployment?.studyDescription?.studyDescriptionUrl ?? '';
  String get privacyPolicyUrl =>
      bloc.deployment?.studyDescription?.privacyPolicyUrl ?? '';

  String get piTitle => bloc.deployment?.responsible?.title ?? '';
  String get piName => bloc.deployment?.responsible?.name ?? '';
  String get piAddress => bloc.deployment?.responsible?.address ?? '';
  String get piEmail => bloc.deployment?.responsible?.email ?? '';
  String get piAffiliation =>
      bloc.deployment?.responsible?.affiliation ??
      'Copenhagen Center for Health Technology';

  /// Events on the state of the study executor
  Stream<ExecutorState> get studyExecutorStateEvents =>
      Sensing().controller!.executor.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ExecutorState get studyState => Sensing().controller!.executor.state;

  /// Get all sensing events (i.e. all [DataPoint] objects being collected).
  Stream<Measurement> get samplingEvents => Sensing().controller!.measurements;

  /// The total sampling size so far since this study was started.
  int get samplingSize => Sensing().controller!.samplingSize;

  /// The stream of messages (count)
  Stream<int> get messageStream => bloc.messageStream;

  /// The list of messages to be displayed.
  List<Message> get messages => bloc.messages;

  /// The icon for a type of message
  Icon getMessageTypeIcon(MessageType type) {
    switch (type) {
      case MessageType.announcement:
        return const Icon(Icons.new_releases);
      case MessageType.article:
        return const Icon(Icons.description);
      case MessageType.news:
        return const Icon(Icons.create_new_folder);
      default:
        return const Icon(Icons.new_releases);
    }
  }

  /// Get the image based on [imagePath]. Can be both an asset and a network
  /// image. See [Message.imagePath].
  ///
  /// If [imagePath] is null, a random image is returned.
  Image getMessageImage(String? imagePath) {
    Image image;
    imagePath ??= 'assets/images/messages/img_${Random(10).nextInt(5) + 1}.png';

    if (imagePath.startsWith('http')) {
      image = Image.network(imagePath, fit: BoxFit.fitHeight);
    } else {
      image = Image.asset(imagePath, fit: BoxFit.fitHeight);
    }
    return image;
  }

  static const dummyID = '00000000-0000-0000-0000-000000000000';
  Message get studyDescriptionMessage => Message(
        id: dummyID,
        title: title,
        message: description,
        type: MessageType.announcement,
        timestamp: DateTime.now(),
        image: 'assets/images/kids.png',
      );

  StudyPageViewModel();
}
