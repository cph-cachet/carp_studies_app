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
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${locale.translate('pages.data_viz.hello')} ${bloc.friendlyUsername}'
                            .toUpperCase(),
                        style: dataCardTitleStyle.copyWith(
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

  // The list of cards, depending on what measures are defined in the study.
  // TODO - this needs to adjusted when more measures can be visualized
  List<Widget> get _dataVizCards {
    final List<Widget> widgets = [];

    widgets.add(HeartRateOuterStatefulWidget(model.heartRateCardDataModel));

    // always show scoreboard
    //widgets.add(ScoreboardCardWidget(model));

    // always show tasks progress
    widgets.add(StudyProgressCardWidget(model.studyProgressCardDataModel));

    // check to show overall measure stats
    //if (bloc.hasMeasures()) widgets.add(MeasuresCardWidget(model.measuresCardDataModel));

    // check to show surveys stats
    if (bloc.hasSurveys())
      widgets.add(TaskCardWidget(
        model.surveysCardDataModel,
        chartType: TaskCardChartType.pie,
      ));

    List<TaskCardViewModel> mediaModelsList = [];

    // check what media types are in the study and add them to de media card
    if (bloc.hasMeasure(MediaSamplingPackage.AUDIO))
      mediaModelsList.add(model.audioCardDataModel);
    if (bloc.hasMeasure(MediaSamplingPackage.VIDEO))
      mediaModelsList.add(model.videoCardDataModel);
    if (bloc.hasMeasure(MediaSamplingPackage.IMAGE))
      mediaModelsList.add(model.imageCardDataModel);
    if (mediaModelsList.isNotEmpty)
      widgets.add(MediaCardWidget(mediaModelsList));

    // check to show device data visualizations
    if (bloc.hasDevices()) {
      //TODO ADD DEVICES VIZ
    }

    if (bloc.hasMeasure(SensorSamplingPackage.PEDOMETER))
      widgets.add(StepsOuterStatefulWidget(model.stepsCardDataModel));
    if (bloc.hasMeasure(ContextSamplingPackage.MOBILITY))
      widgets.add(MobilityOuterStatefulWidget(model.mobilityCardDataModel));
    if (bloc.hasMeasure(ContextSamplingPackage.ACTIVITY))
      widgets.add(ActivityOuterStatefulWidget(model.activityCardDataModel));

    return widgets.toSet().toList();
  }
}
