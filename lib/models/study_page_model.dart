part of carp_study_app;

class StudyPageModel extends DataModel {
  String get title => bloc.deployment?.protocolDescription?.title ?? 'Unnamed';
  String get description => bloc.deployment?.protocolDescription?.description ?? '';
  String get purpose => bloc.deployment?.protocolDescription?.purpose ?? '';
  Image get image => Image.asset('assets/images/study.png');
  String? get userID => bloc.deployment?.userId;

  String get piTitle => bloc.deployment?.responsible?.title ?? '';
  String get piName => bloc.deployment?.responsible?.name ?? '';
  String get piAddress => bloc.deployment?.responsible?.address ?? '';
  String get piEmail => bloc.deployment?.responsible?.email ?? '';
  String get piAffiliation =>
      bloc.deployment?.responsible?.affiliation ?? 'Copenhagen Center for Health Technology';

  /// Events on the state of the study executor
  Stream<ProbeState> get studyExecutorStateEvents => Sensing().controller!.executor!.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ProbeState get studyState => Sensing().controller!.executor!.state;

  /// Get all sesing events (i.e. all [DataPoint] objects being collected).
  Stream<DataPoint> get samplingEvents => Sensing().controller!.data;

  /// The total sampling size so far since this study was started.
  int get samplingSize => Sensing().controller!.samplingSize;

  /// The list of messages to be displayed.
  List<Message>? get messages => bloc.messages;

  StudyPageModel();

  void init(StudyDeploymentController controller) {
    super.init(controller);
  }
}

/// A message to be shown in the message list
class Message {
  /// Type of message
  MessageType type;

  /// The icon for this type of message
  Icon get typeIcon {
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

  /// Creation timestamp
  late DateTime timestamp;

  /// A short title
  String? title;

  /// A short sub title
  String? subTitle;

  /// A longer detailed message
  String? message;

  /// A URL to redirect the user to for an online item
  String? url;

  String? imagePath;

  Message({
    this.type = MessageType.announcement,
    this.title,
    this.subTitle,
    this.message,
    this.url,
    this.imagePath,
  }) {
    timestamp = DateTime.now();
  }

  /// Only articles have images, if not specified, get it randomly
  Image get image => obtainImage();

  Image obtainImage() {
    if (imagePath == null) imagePath = 'assets/images/article_' + Random(10).nextInt(3).toString() + '.png';
    return Image.asset(imagePath!, fit: BoxFit.fitHeight);
  }
}

/// The different types of messages that can occur in the list of messages
enum MessageType {
  announcement,
  article,
  news,
}
