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
      body: Column(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.3,
            color: Theme.of(context).accentColor,
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
                  message.type == MessageType.article
                      ? Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height * 0.22,
                          //color: Color(0xFFF1F9FF),
                          child: messageImage,
                        )
                      : SizedBox.shrink(),
                  //SizedBox(height: 20),
                  // Text(locale.translate(studyPageModel.title),
                  //     style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(locale.translate(message.title!),
                        style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                  ),
                  SizedBox(width: 15),
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
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: message.url != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await launch(message.url!);
                        } catch (error) {
                          warning("Could not launch message URL - '${message.url!}'");
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public_outlined, color: Theme.of(context).primaryColor),
                          Text(locale.translate('pages.about.study.website'),
                              style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
      // bottomSheet: message.url != null
      //     ? Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: InkWell(
      //           onTap: () async {
      //             try {
      //               await launch(message.url!);
      //             } catch (error) {
      //               warning("Could not launch message URL - '${message.url!}'");
      //             }
      //           },
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(Icons.public_outlined,
      //                   color: Theme.of(context).primaryColor),
      //               Text(locale.translate('pages.about.study.website'),
      //                   style: aboutCardSubtitleStyle.copyWith(
      //                       color: Theme.of(context).primaryColor)),
      //             ],
      //           ),
      //         ),
      //       )
      //     : SizedBox.shrink(),
    );
  }
}
