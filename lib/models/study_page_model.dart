part of carp_study_app;

class StudyPageModel extends DataModel {
  String get name => bloc.deployment.protocolDescription.title;
  String get description => bloc.deployment.protocolDescription.description;
  Image get image => Image.asset('assets/images/study.png');
  String get userID => bloc.deployment.userId;
  String get affiliation =>
      bloc.deployment.responsible.affiliation ?? 'Copenhagen Center for Health Technology';

  /// Events on the state of the study executor
  Stream<ProbeState> get studyExecutorStateEvents => Sensing().controller.executor.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ProbeState get studyState => Sensing().controller.executor.state;

  /// Get all sesing events (i.e. all [DataPoint] objects being collected).
  Stream<DataPoint> get samplingEvents => Sensing().controller.data;

  /// The total sampling size so far since this study was started.
  int get samplingSize => Sensing().controller.samplingSize;

  /// The list of messages to be displayed.
  List<Message> get messages => bloc.messages;

  StudyPageModel();

  void init(StudyDeploymentController controller) {
    super.init(controller);
  }
}

/// A message to be shown in the message list
class Message {
  /// Type of message
  MessageType type;

  //TODO - these has to be updated to the correct ones picked by @gonzalo
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
  DateTime timestamp;

  /// A short title
  String title;

  /// A short sub title
  String subTitle;

  /// A longer detailed message
  String message;

  /// A URL to redirect the user to for an online item
  String url;

  String imagePath;

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

  // TODO - add the defult images to the assets/images folder
  /// The default image based on the [type] of message.
  /// Image get image => Image.asset('assets/images/$type.png');
  ///
  /// Only articles have images, get it randomly
  Image get image => obtainImage();

  Image obtainImage() {
    if (imagePath == null) imagePath = 'assets/images/article_' + Random(10).nextInt(3).toString() + '.png';
    return Image.asset(imagePath, fit: BoxFit.fitHeight);
  }
}

/// The different types of messages that can occur in the list of messages
enum MessageType {
  announcement,
  article,
  news,
}
