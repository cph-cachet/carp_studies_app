part of carp_study_app;

class DataVisualizationPage extends StatelessWidget {
  final DataVisualizationPageModel model;
  DataVisualizationPage(this.model);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarpAppBar(),
            Expanded(
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

    // always show overall measure stats
    widgets.add(MeasuresCardWidget(model.measuresCardDataModel));

    // check which measures are in the study
    model.controller.deployment.measures.forEach((measure) {
      if (measure.type == SensorSamplingPackage.PEDOMETER)
        widgets.add(StepsOuterStatefulWidget(model.stepsCardDataModel));
      if (measure.type == ContextSamplingPackage.MOBILITY)
        widgets.add(MobilityOuterStatefulWidget(model.mobilityCardDataModel));
      if (measure.type == ContextSamplingPackage.ACTIVITY)
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
