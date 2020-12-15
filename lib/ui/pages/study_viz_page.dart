part of carp_study_app;

class StudyVisualization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(height: height * .08),
                  CarpAppBar(),
                  StudyBanner(),
                  articleStudyCard(
                      'Carp’s Mcardia study verifies the importance of wearables in patient motivation',
                      'This study will ask you to provide information about the following categories categories categories',
                      'https://www.cachet.dk/newslist/Nyhed?id={58737646-B6D2-4BC9-9D73-45D3F7D9962B}'),
                  announcementStudyCard('New version of Carp app will be out soon in the app store',
                      'Minor bug fixes has been implemented. To enjoy the latest and fastest version of the app please update it '),
                  articleStudyCard(
                      'Carp’s Mcardia study verifies the importance of wearables in patient motivation',
                      'This study will ask you to provide information about the following categories categories categories',
                      'https://www.cachet.dk/newslist/Nyhed?id={58737646-B6D2-4BC9-9D73-45D3F7D9962B}'),
                  announcementStudyCard('New version of Carp app will be out soon in the app store',
                      'Minor bug fixes has been implemented. To enjoy the latest and fastest version of the app please update it ')
                ])))
      ]
          //child: CircularProgressIndicator(),
          ),
    ));
  }

  Widget articleStudyCard(String subtitle, String content, String url) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () async {
          print("tapped");
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(
                  child: Image.asset(
                    'assets/study.png',
                    fit: BoxFit.fill,
                  ),
                )
              ]),
              SizedBox(height: 5),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: [
                SizedBox(width: 15),
                Icon(Icons.menu_book, color: Color.fromRGBO(32, 111, 162, 1)),
                SizedBox(width: 15),
                Text('ARTICLE', style: aboutCardTitleStyle),
                SizedBox(width: 15),
                Text('2 hours ago', style: aboutCardInfoStyle),
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Expanded(child: Text(subtitle, style: aboutCardSubtitleStyle)),
                SizedBox(width: 15)
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Expanded(child: Text(content, style: aboutCardContentStyle)),
                SizedBox(width: 15),
              ]),
              SizedBox(height: 5),
            ]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }

  Widget announcementStudyCard(String subtitle, String content) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          print("tapped");
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: [
                SizedBox(width: 15),
                Icon(Icons.campaign_outlined, color: Color.fromRGBO(32, 111, 162, 1)),
                SizedBox(width: 15),
                Text('ANNOUNCEMENT', style: aboutCardTitleStyle),
                SizedBox(width: 15),
                Text('2 hours ago', style: aboutCardInfoStyle),
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Expanded(child: Text(subtitle, style: aboutCardSubtitleStyle)),
                SizedBox(width: 15)
              ]),
              SizedBox(height: 5),
              Row(children: [
                SizedBox(width: 15),
                Expanded(child: Text(content, style: aboutCardContentStyle)),
                SizedBox(width: 15),
              ]),
              SizedBox(height: 5),
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
