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
            //StudyCard(),
            Flexible(
              child: StreamBuilder<int>(
                  stream: widget.model.messageStream,
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    return CustomScrollView(
                      slivers: [
                        CarpBanner(),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) =>
                                _aboutStudyCard(
                                    context, widget.model.messages[index]),
                            childCount: widget.model.messages.length,
                          ),
                        ),

                        // ListView.builder(
                        //     itemCount: widget.model.messages!.length,
                        //     padding: EdgeInsets.symmetric(vertical: 5.0),
                        //     itemBuilder: (context, index) {
                        //       return _aboutStudyCard(context, widget.model.messages![index]);
                        //     }),
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
    // TODO - when the messaging system works (i.e., is not hard coded), the
    // locale need to be changed to use the RPLocalizations
    //
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

        // onTap: () async {
        //   if (message.url != null) if (await canLaunch(message.url!)) {
        //     await launch(message.url!);
        //   } else {
        //     throw 'Could not launch $message.url';
        //   }
        // },
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
                        style: aboutCardTitleStyle.copyWith(
                            color: Theme.of(context).primaryColor))),
              ],
            ),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              Text(
                  // locale.translate(message.type.toString().split('.')[1][0].toUpperCase() +
                  //         message.type.toString().split('.')[1].substring(1)) +
                  locale.translate(message.type
                          .toString()
                          .split('.')
                          .last
                          .toLowerCase()) +
                      ' - ' +
                      timeago.format(
                          DateTime.now().subtract(Duration(
                              days: message.timestamp.day,
                              hours: message.timestamp.hour,
                              minutes: message.timestamp.minute)),
                          locale: Localizations.localeOf(context).languageCode),
                  style: aboutCardSubtitleStyle.copyWith(
                      color: Theme.of(context).primaryColor)),
            ]),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              if (message.subTitle!.isNotEmpty)
                Expanded(
                    child: Text(locale.translate(message.subTitle!),
                        style: aboutCardContentStyle.copyWith(
                            color: Theme.of(context).primaryColor))),
            ]),
            SizedBox(height: 5),
            Row(children: [
              SizedBox(width: 15),
              if (message.message != null && message.message!.isNotEmpty)
                Expanded(
                    child: Text(
                  locale.translate(message.message!).substring(
                          0, (message.message!.length > 200) ? 200 : null) +
                      "...",
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                )),
              SizedBox(width: 15),
            ]),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(locale.translate("pages.about.message.read_more"),
                  style: aboutCardContentStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right),
              SizedBox(width: 15),
            ]),
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
