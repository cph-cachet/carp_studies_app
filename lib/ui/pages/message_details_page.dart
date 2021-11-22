part of carp_study_app;

class MessageDetailsPage extends StatelessWidget {
  Message message;
  MessageDetailsPage({required this.message});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    //bool hasArticle = message.url!.isNotEmpty ? true : false;
    return Scaffold(
      body: Column(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.3,
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ]),
                  message.type == MessageType.article
                      ? Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height * 0.22,
                          //color: Color(0xFFF1F9FF),
                          child: message.image,
                        )
                      : SizedBox.shrink(),
                  //SizedBox(height: 20),
                  // Text(locale.translate(studyPageModel.title),
                  //     style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),

                  Text(locale.translate(message.title!),
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(width: 15),
                  Text(
                      locale.translate(message.type.toString().split('.').last.toLowerCase()) +
                          ' - ' +
                          timeago.format(
                              DateTime.now().subtract(Duration(
                                  days: message.timestamp.day,
                                  hours: message.timestamp.hour,
                                  minutes: message.timestamp.minute)),
                              locale: Localizations.localeOf(context).languageCode),
                      style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.3,
                  //color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            if (message.message!.isNotEmpty)
                              Expanded(
                                  child: Text(
                                locale.translate(message.message!),
                                style: aboutCardContentStyle,
                                textAlign: TextAlign.justify,
                              )),
                            SizedBox(width: 15),
                          ]),
                          SizedBox(height: 50),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: message.url != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (await canLaunch(message.url!)) {
                      await launch(locale.translate(message.url!));
                    } else {
                      throw 'Could not launch project URL';
                    }
                  },
                  icon: Icon(Icons.public_outlined, color: Theme.of(context).primaryColor),
                ),
                Text(locale.translate('pages.about.study.website'),
                    style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
