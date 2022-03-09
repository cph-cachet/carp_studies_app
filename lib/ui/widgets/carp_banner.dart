part of carp_study_app;

class CarpBanner extends StatelessWidget {
  final StudyPageViewModel studyPageModel = StudyPageViewModel();

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return SliverAppBar(
      expandedHeight: 150.0,
      backgroundColor: Theme.of(context).accentColor,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(top: 15),
        title: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudyDetailsPage()));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Text(locale.translate(studyPageModel.title),
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.touch_app, color: Theme.of(context).primaryColor, size: 15),
                  ],
                )
              ],
            ),
          ),
        ),
        background: Image.asset('./assets/images/kids.png', fit: BoxFit.fitHeight),
      ),
    );
  }
}
