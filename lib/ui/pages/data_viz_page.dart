part of carp_study_app;

// todo change text for survey progress
class DataVisualizationPage extends StatelessWidget {
  final DataVisualizationPageViewModel model;
  DataVisualizationPage(this.model);

  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarpAppBar(),
            Container(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${locale.translate('pages.data_viz.hello')} ${bloc.friendlyUsername}',
                        style: sectionTitleStyle.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(locale.translate('pages.data_viz.thanks'),
                          style: aboutCardSubtitleStyle),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _dataVizCards,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // the list of cards, depending on what measures are defined in the study
  // TODO - this needs to adjusted when more measures can be visualized
  List<Widget> get _dataVizCards {
    final List<Widget> widgets = [];

    // always show scoreboard
    //widgets.add(ScoreboardCardWidget(model));

    // always show tasks progress
    widgets.add(StudyProgressCardWidget(model.studyProgressCardDataModel));

    // always show overall measure stats
    widgets.add(MeasuresCardWidget(model.measuresCardDataModel));

    // check which measures are in the study
    if (bloc.hasMeasure(SurveySamplingPackage.SURVEY))
      widgets.add(TaskCardWidget(model.surveysCardDataModel));
    if (bloc.hasMeasure(MediaSamplingPackage.AUDIO))
      widgets.add(TaskCardWidget(model.audioCardDataModel));
    if (bloc.hasMeasure(MediaSamplingPackage.VIDEO)) // TODO ADD PHOTO
      widgets.add(TaskCardWidget(model.mediaCardDataModel));
    if (bloc.hasMeasure(SensorSamplingPackage.PEDOMETER))
      widgets.add(StepsOuterStatefulWidget(model.stepsCardDataModel));
    if (bloc.hasMeasure(ContextSamplingPackage.MOBILITY))
      widgets.add(MobilityOuterStatefulWidget(model.mobilityCardDataModel));
    if (bloc.hasMeasure(ContextSamplingPackage.ACTIVITY))
      widgets.add(ActivityOuterStatefulWidget(model.activityCardDataModel));

    return widgets.toSet().toList();
  }
}
