part of carp_study_app;

class StudyVisualization extends StatefulWidget {
  final StudyPageModel model;
  const StudyVisualization(this.model);

  @override
  _StudyVisualizationState createState() => _StudyVisualizationState();
}

class _StudyVisualizationState extends State<StudyVisualization> {
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .075),
                    CarpAppBar(),
                    StudyBanner(),
                    Flexible(
                      child: StreamBuilder<Datum>(
                          stream: widget.model.samplingEvents,
                          builder: (context, AsyncSnapshot<Datum> snapshot) {
                            return Scrollbar(
                              child: ListView.builder(
                                  itemCount: widget.model.messages.length,
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
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
          });
    });
  }

  Widget _aboutStudyCard(BuildContext context, Message message) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () async {
          print("tapped");
          if (await canLaunch(message.url)) {
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
                    message.type.toString().split('.')[1][0].toUpperCase() +
                        message.type.toString().split('.')[1].substring(1) +
                        ' - ' +
                        timeago.format(DateTime.now().subtract(Duration(
                            days: message.timestamp.day,
                            hours: message.timestamp.hour,
                            minutes: message.timestamp.minute))),
                    style: aboutCardSubtitleStyle),
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Expanded(child: Text(message.subTitle, style: aboutCardContentStyle)),
                SizedBox(width: 15),
              ]),
              SizedBox(height: 10),
            ]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
