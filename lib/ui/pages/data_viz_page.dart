part of carp_study_app;

class DataVisualization extends StatelessWidget {
  final DataPageModel model;
  DataVisualization(this.model);

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
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
                            StepsCardWidget(model.stepsCardDataModel),
                            MobilityCardWidget(model.mobilityCardDataModel),
                            ActivityCardWidget(model.activityCardDataModel),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
