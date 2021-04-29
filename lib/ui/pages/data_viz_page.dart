part of carp_study_app;

class DataVisualizationPage extends StatelessWidget {
  final DataVisualizationPageModel model;
  DataVisualizationPage(this.model);

  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);
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
                      '${locale.translate('Hello')} ${bloc.user.firstName}',
                      style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    Text(
                        locale.translate(
                            'Thank you for participating in this study. This a summary of your contribution to the study.'),
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

    // always show survey stats
    widgets.add(SurveysCardWidget(model.surveysCardDataModel));

    // always show audio stats
    widgets.add(AudioCardWidget(model.audioCardDataModel));

    // check which measures are in the study
    model.controller.study.measures.forEach((measure) {
      if (measure.type.name == SensorSamplingPackage.PEDOMETER)
        widgets.add(StepsOuterStatefulWidget(model.stepsCardDataModel));
      if (measure.type.name == ContextSamplingPackage.MOBILITY)
        widgets.add(MobilityOuterStatefulWidget(model.mobilityCardDataModel));
      if (measure.type.name == ContextSamplingPackage.ACTIVITY)
        widgets.add(ActivityOuterStatefulWidget(model.activityCardDataModel));
    });

    return widgets;

    // return <Widget>[
    //   MeasuresCardWidget(model.measuresCardDataModel),
    //   StepsOuterStatefulWidget(model.stepsCardDataModel),
    //   MobilityOuterStatefulWidget(model.mobilityCardDataModel),
    //   ActivityOuterStatefulWidget(model.activityCardDataModel),
    // ];
  }
}
