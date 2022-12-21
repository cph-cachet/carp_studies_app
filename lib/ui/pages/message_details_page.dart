part of carp_study_app;

class MessageDetailsPage extends StatelessWidget {
  final Message message;
  final Image messageImage;

  MessageDetailsPage({
    required this.message,
    required this.messageImage,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ]),
              Flexible(
                child: CustomScrollView(
                  slivers: [
                    DetailsBanner(message.title!, message.imagePath),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                locale.translate(message.type.toString().split('.').last.toLowerCase()) +
                                    ' - ' +
                                    timeago.format(
                                        DateTime.now().copyWithAdditional(
                                            years: -DateTime.now().year + message.timestamp.year,
                                            months: -DateTime.now().month + message.timestamp.month,
                                            days: -DateTime.now().day + message.timestamp.day,
                                            hours: -DateTime.now().hour + message.timestamp.hour,
                                            minutes: -DateTime.now().minute + message.timestamp.minute),
                                        locale: Localizations.localeOf(context).languageCode),
                                style:
                                    aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                            SizedBox(height: 5),
                            message.subTitle != null
                                ? Text(locale.translate(message.subTitle!),
                                    style:
                                        aboutCardContentStyle.copyWith(color: Theme.of(context).primaryColor))
                                : SizedBox.shrink(),
                            SizedBox(height: 5),
                            message.message != null
                                ? Text(
                                    locale.translate(message.message!),
                                    style: aboutCardContentStyle,
                                    textAlign: TextAlign.justify,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: message.url != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            try {
                              await launchUrl(Uri.parse(message.url!));
                            } catch (error) {
                              warning("Could not launch message URL - '${message.url!}'");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.public_outlined, color: Theme.of(context).primaryColor),
                              Text(locale.translate('pages.about.study.website'),
                                  style:
                                      aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
