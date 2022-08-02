part of carp_study_app;

class StudyPage extends StatefulWidget {
  final StudyPageViewModel model;
  const StudyPage(this.model);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarpAppBar(),
            Flexible(
              child: StreamBuilder<int>(
                  stream: widget.model.messageStream,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return CustomScrollView(
                      slivers: [
                        DetailsBanner(widget.model.title, './assets/images/kids.png', isCarpBanner: true),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) =>
                                _aboutStudyCard(context, widget.model.messages[index]),
                            childCount: widget.model.messages.length,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutStudyCard(BuildContext context, Message message) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Initialization the language of the tiemago package
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());

    Image messageImage = widget.model.getMessageImage(message.imagePath);

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MessageDetailsPage(
                        message: message,
                        messageImage: messageImage,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              message.type == MessageType.article
                  ? Expanded(
                      child: Container(
                      height: 150.0,
                      color: Theme.of(context).colorScheme.secondary, //Color(0xFFF1F9FF),
                      child: messageImage,
                    ))
                  : SizedBox.shrink()
            ]),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                SizedBox(width: 15),
                Expanded(
                    child: Text(locale.translate(message.title!),
                        style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor))),
              ],
            ),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              Text(
                  // locale.translate(message.type.toString().split('.')[1][0].toUpperCase() +
                  //         message.type.toString().split('.')[1].substring(1)) +
                  locale.translate(message.type.toString().split('.').last.toLowerCase()) +
                      ' - ' +
                      timeago.format(
                        DateTime.now().copyWithAdditional(
                            years: -DateTime.now().year + message.timestamp.year,
                            months: -DateTime.now().month + message.timestamp.month,
                            days: -DateTime.now().day + message.timestamp.day,
                            hours: -DateTime.now().hour + message.timestamp.hour,
                            minutes: -DateTime.now().minute + message.timestamp.minute),
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                  style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
            ]),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              if (message.subTitle!.isNotEmpty)
                Expanded(
                    child: Text(locale.translate(message.subTitle!),
                        style: aboutCardContentStyle.copyWith(color: Theme.of(context).primaryColor))),
            ]),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              if (message.message != null && message.message!.isNotEmpty)
                Expanded(
                    child: Text(
                  locale
                          .translate(message.message!)
                          .substring(0, (message.message!.length > 150) ? 150 : null) +
                      "...",
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                )),
              SizedBox(width: 15),
            ]),
            SizedBox(height: 5),
            // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //   Icon(Icons.touch_app, color: Theme.of(context).primaryColor, size: 18),
            //   // Text(locale.translate("pages.about.message.read_more"),
            //   //     style: aboutCardContentStyle.copyWith(
            //   //         color: Theme.of(context).primaryColor, fontStyle: FontStyle.italic),
            //   //     textAlign: TextAlign.right),
            //   SizedBox(width: 15),
            // ]),
            SizedBox(height: 10),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      margin: EdgeInsets.all(5),
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
    print(hours);
    print(DateTime.now().hour);

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
