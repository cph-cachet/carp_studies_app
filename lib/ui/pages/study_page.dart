part of carp_study_app;

class StudyPage extends StatefulWidget {
  static const String route = '/study';
  final StudyPageViewModel model;
  const StudyPage({super.key, required this.model});

  @override
  StudyPageState createState() => StudyPageState();
}

class StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CarpAppBar(hasProfileIcon: true),
            ),
            Flexible(
              child: StreamBuilder<int>(
                  stream: widget.model.messageStream,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await bloc.refreshMessages();
                      },
                      child: ListView.builder(
                        itemCount: bloc.messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _aboutStudyCard(
                              context,
                              widget.model.studyDescriptionMessage,
                              onTap: () {
                                context.push(StudyDetailsPage.route);
                              },
                            );
                          }

                          return _aboutStudyCard(
                              context, bloc.messages[index - 1]);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutStudyCard(
    BuildContext context,
    Message message, {
    Function? onTap,
  }) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Initialization the language of the tiemago package
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());

    return StudiesMaterial(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            context.push('${MessageDetailsPage.route}/${message.id}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (message.image != null && message.image != '')
                Center(
                  child: Container(
                    height: 150.0,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary, //Color(0xFFF1F9FF),
                    child: widget.model.getMessageImage(message.image),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(locale.translate(message.title!),
                    style: aboutCardTitleStyle.copyWith(
                        color: Theme.of(context).primaryColor)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                    '${locale.translate(message.type.toString().split('.').last.toLowerCase())} - ${timeago.format(
                      DateTime.now().copyWithAdditional(
                          years: -DateTime.now().year + message.timestamp.year,
                          months:
                              -DateTime.now().month + message.timestamp.month,
                          days: -DateTime.now().day + message.timestamp.day,
                          hours: -DateTime.now().hour + message.timestamp.hour,
                          minutes: -DateTime.now().minute +
                              message.timestamp.minute),
                      locale: Localizations.localeOf(context).languageCode,
                    )}',
                    style: aboutCardSubtitleStyle.copyWith(
                        color: Theme.of(context).primaryColor)),
              ),
              if (message.subTitle != null && message.subTitle!.isNotEmpty)
                Row(children: [
                  Expanded(
                      child: Text(locale.translate(message.subTitle!),
                          style: aboutCardContentStyle.copyWith(
                              color: Theme.of(context).primaryColor))),
                ]),
              if (message.message != null && message.message!.isNotEmpty)
                Row(children: [
                  Expanded(
                      child: Text(
                    "${locale.translate(message.message!).substring(0, (message.message!.length > 150) ? 150 : null)}...",
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  )),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}

extension CopyWithAdditional on DateTime {
  DateTime copyWithAdditional({
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    return DateTime(
      year + years,
      month + months,
      day + days,
      hour + hours,
      minute + minutes,
      second + seconds,
      millisecond + milliseconds,
      microsecond + microseconds,
    );
  }
}
