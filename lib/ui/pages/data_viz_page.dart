part of carp_study_app;

// todo change text for survey progress
class DataVisualizationPage extends StatelessWidget {
  final DataVisualizationPageModel model;
  DataVisualizationPage(this.model);

  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context);
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarpAppBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${locale.translate('pages.data_viz.hello')} ${bloc.user.firstName}',
                      style: sectionTitleStyle.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(locale.translate('pages.data_viz.thanks'),
                        style: aboutCardSubtitleStyle),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
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
    widgets.add(ScoreboardCardWidget(model));

    // always show tasks progress
    widgets.add(StudyProgressCardWidget(model.studyProgressCardDataModel));

    // always show overall measure stats
    widgets.add(MeasuresCardWidget(model.measuresCardDataModel));

    // widgets.add(SurveysCardWidget(model.surveysCardDataModel));
    // widgets.add(AudioCardWidget(model.audioCardDataModel));
    widgets.add(TaskCardWidget(model.surveysCardDataModel));
    widgets.add(TaskCardWidget(model.audioCardDataModel));

    // check which measures are in the study
    bloc.deployment.measures.forEach((measure) {
      if (measure.type == SensorSamplingPackage.PEDOMETER)
        widgets.add(StepsOuterStatefulWidget(model.stepsCardDataModel));
      if (measure.type == ContextSamplingPackage.MOBILITY)
        widgets.add(MobilityOuterStatefulWidget(model.mobilityCardDataModel));
      if (measure.type == ContextSamplingPackage.ACTIVITY)
        widgets.add(ActivityOuterStatefulWidget(model.activityCardDataModel));
    });
    print(widgets);

    return widgets.toSet().toList();

    // return <Widget>[
    //   MeasuresCardWidget(model.measuresCardDataModel),
    //   StepsOuterStatefulWidget(model.stepsCardDataModel),
    //   MobilityOuterStatefulWidget(model.mobilityCardDataModel),
    //   ActivityOuterStatefulWidget(model.activityCardDataModel),
    // ];
  }
}
