part of carp_study_app;

class StudyPageModel extends DataModel {
  String get title => bloc.deployment?.protocolDescription?.title ?? 'Unnamed';
  String get description =>
      bloc.deployment?.protocolDescription?.description ?? '';
  String get purpose => bloc.deployment?.protocolDescription?.purpose ?? '';
  Image get image => Image.asset('assets/images/study.png');
  String? get userID => bloc.deployment?.userId;
  String get studyDescriptionUrl =>
      bloc.deployment?.protocolDescription?.studyDescriptionUrl ?? '';
  String get privacyPolicyUrl =>
      bloc.deployment?.protocolDescription?.privacyPolicyUrl ?? '';

  String get piTitle => bloc.deployment?.responsible?.title ?? '';
  String get piName => bloc.deployment?.responsible?.name ?? '';
  String get piAddress => bloc.deployment?.responsible?.address ?? '';
  String get piEmail => bloc.deployment?.responsible?.email ?? '';
  String get piAffiliation =>
      bloc.deployment?.responsible?.affiliation ??
      'Copenhagen Center for Health Technology';

  /// Events on the state of the study executor
  Stream<ProbeState> get studyExecutorStateEvents =>
      Sensing().controller!.executor!.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ProbeState get studyState => Sensing().controller!.executor!.state;

  /// Get all sesing events (i.e. all [DataPoint] objects being collected).
  Stream<DataPoint> get samplingEvents => Sensing().controller!.data;

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
        return Icon(Icons.new_releases);
      case MessageType.article:
        return Icon(Icons.description);
      case MessageType.news:
        return Icon(Icons.create_new_folder);
      default:
        return Icon(Icons.new_releases);
    }
  }

  /// Get the image based on [imagePath]. Can be both an asset and a network
  /// image. See [Message.imagePath].
  ///
  /// If [imagePath] is null, a random image is returned.
  Image getMessageImage(String? imagePath) {
    Image image;
    if (imagePath == null)
      imagePath =
          'assets/images/article_' + Random(10).nextInt(3).toString() + '.png';

    if (imagePath.startsWith('http')) {
      image = Image.network(imagePath, fit: BoxFit.fitHeight);
    } else {
      image = Image.asset(imagePath, fit: BoxFit.fitHeight);
    }
    return image;
  }

  StudyPageModel();

  void init(SmartphoneDeploymentController controller) {
    super.init(controller);
  }
}
