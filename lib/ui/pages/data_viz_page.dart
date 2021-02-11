part of carp_study_app;

class DataVisualization extends StatelessWidget {
  final DataPageModel model;
  DataVisualization(this.model);

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
                  children: <Widget>[
                    MeasuresCardWidget(model.measuresCardDataModel),
                    StepsOuterStatefulWidget(model.stepsCardDataModel),
                    MobilityOuterStatefulWidget(model.mobilityCardDataModel),
                    ActivityOuterStatefulWidget(model.activityCardDataModel),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
