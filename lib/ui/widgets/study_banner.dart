part of carp_study_app;

class StudyBanner extends StatelessWidget {
  final StudyPageModel studyPageModel = StudyPageModel();

  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;
    return Container(
      color: Theme.of(context).accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandablePanel(
            collapsed: Container(
              height: 110,
              color: Theme.of(context).accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(locale.translate(studyPageModel.title),
                          style: studyTitleStyle.copyWith(
                              color: Theme.of(context).primaryColor))
                    ],
                  ),
                ],
              ),
            ),
            expanded: Container(
                height: 110,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                color: Theme.of(context).accentColor,
                child: Column(children: <Widget>[
                  Expanded(
                      child: Text(locale.translate(studyPageModel.description),
                          style: studyDescriptionStyle.copyWith(
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.justify)),
                ])),
            theme: ExpandableThemeData(
              iconPlacement: ExpandablePanelIconPlacement.right,
              iconColor: Theme.of(context).primaryColor,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapHeaderToExpand: true,
              hasIcon: true,
            ),
          ),
        ],
      ),
    );
  }
}
