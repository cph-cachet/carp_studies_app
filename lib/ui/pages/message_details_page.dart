part of carp_study_app;

class MessageDetailsPage extends StatelessWidget {
  static const String route = '/message';
  final String messageId;

  const MessageDetailsPage({
    super.key,
    required this.messageId,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    Message message = bloc.messages
        .firstWhere((element) => element.id == messageId, orElse: () {
      return Message(
          id: '0',
          title: 'Unknown message',
          subTitle: 'Unknown message',
          type: MessageType.announcement,
          timestamp: DateTime.now(),
          image: './assets/images/kids.png');
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(CarpStudyAppState.homeRoute);
                      }
                    },
                    icon: const Icon(Icons.close_rounded))
              ]),
              Flexible(
                child: ListView(
                  children: [
                    DetailsBanner(message.title ?? '', message.image),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${locale.translate(message.type.toString().split('.').last.toLowerCase())} - ${timeago.format(DateTime.now().copyWithAdditional(years: -DateTime.now().year + message.timestamp.year, months: -DateTime.now().month + message.timestamp.month, days: -DateTime.now().day + message.timestamp.day, hours: -DateTime.now().hour + message.timestamp.hour, minutes: -DateTime.now().minute + message.timestamp.minute), locale: Localizations.localeOf(context).languageCode)}',
                              style: aboutCardSubtitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor)),
                          message.subTitle != null
                              ? Text(locale.translate(message.subTitle!),
                                  style: aboutCardContentStyle.copyWith(
                                      color: Theme.of(context).primaryColor))
                              : const SizedBox.shrink(),
                          if (message.message != null)
                            Text(
                              locale.translate(message.message!),
                              style: aboutCardContentStyle,
                              textAlign: TextAlign.justify,
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (message.url != null && message.url!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await launchUrl(Uri.parse(message.url!));
                        } catch (error) {
                          warning(
                              "Could not launch message URL - '${message.url!}'");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public_outlined,
                              color: Theme.of(context).primaryColor),
                          Text(locale.translate('pages.about.study.website'),
                              style: aboutCardSubtitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
