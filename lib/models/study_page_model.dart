part of carp_study_app;

class StudyPageModel {
  String get name => bloc.study.name;
  String get description =>
      bloc.study.description ?? 'No description available.';
  Image get image => Image.asset('assets/images/study.png');
  String get userID => bloc.study.userId;

  /// Events on the state of the study executor
  Stream<ProbeState> get studyExecutorStateEvents =>
      bloc.controller.executor.stateEvents;

  /// Current state of the study executor (e.g., resumed, paused, ...)
  ProbeState get studyState => bloc.controller.executor.state;

  /// Get all sesing events (i.e. all [Datum] objects being collected).
  Stream<Datum> get samplingEvents => bloc.controller.events;

  /// The total sampling size so far since this study was started.
  int get samplingSize => bloc.controller.samplingSize;

  /// The list of messages to be displayed.
  List<Message> get messages => bloc.messages;

  StudyPageModel();
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

  Message({
    this.type = MessageType.announcement,
    this.title,
    this.subTitle,
    this.message,
    this.url,
  }) {
    timestamp = DateTime.now();
  }

  // TODO - add the defult images to the assets/images folder
  /// The default image based on the [type] of message.
  /// Image get image => Image.asset('assets/images/$type.png');
  ///
  /// Only articles have images, get it randomly
  Image get image => Image.asset(
      'assets/images/article_' + Random().nextInt(3).toString() + '.png',
      fit: BoxFit.fitHeight);
}

/// The different types of messages that can occur in the list of messages
enum MessageType {
  announcement,
  article,
  news,
}
