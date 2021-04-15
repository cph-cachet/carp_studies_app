part of carp_study_app;

class StudyPage extends StatefulWidget {
  final StudyPageModel model;
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
          children: <Widget>[
            CarpAppBar(),
            //StudyBanner(),
            StudyCard(),
            Flexible(
              child: StreamBuilder<Datum>(
                  stream: widget.model.samplingEvents,
                  builder: (context, AsyncSnapshot<Datum> snapshot) {
                    return Scrollbar(
                      child: ListView.builder(
                          itemCount: widget.model.messages.length,
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          itemBuilder: (context, index) {
                            return _aboutStudyCard(context, widget.model.messages[index]);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutStudyCard(BuildContext context, Message message) {
    RPLocalizations locale = RPLocalizations.of(context);
    // Initialization the language of the tiemago package
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () async {
          if (message.url != null) if (await canLaunch(message.url)) {
            await launch(message.url);
          } else {
            throw 'Could not launch $message.url';
          }
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
                        color: Color(0xFFF1F9FF),
                        child: message.image,
                      ))
                    : SizedBox.shrink()
              ]),
              SizedBox(height: 10),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: [
                SizedBox(width: 15),
                Expanded(
                    child: Text(message.title,
                        style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor))),
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Text(
                    locale.translate(message.type.toString().split('.')[1][0].toUpperCase() +
                            message.type.toString().split('.')[1].substring(1)) +
                        ' - ' +
                        timeago.format(
                            DateTime.now().subtract(Duration(
                                days: message.timestamp.day,
                                hours: message.timestamp.hour,
                                minutes: message.timestamp.minute)),
                            locale: Localizations.localeOf(context).languageCode),
                    style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                if (message.subTitle.isNotEmpty)
                  Expanded(
                      child: Text(message.subTitle,
                          style: aboutCardContentStyle.copyWith(color: Theme.of(context).primaryColor))),
                if (message.message.isNotEmpty)
                  Expanded(
                      child: Text(
                    message.message,
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  )),
                SizedBox(width: 15),
              ]),
              SizedBox(height: 10),
            ]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      margin: EdgeInsets.all(5),
    );
  }
}
