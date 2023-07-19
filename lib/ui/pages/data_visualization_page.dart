part of carp_study_app;

// todo change text for survey progress
class DataVisualizationPage extends StatelessWidget {
  final DataVisualizationPageViewModel model;
  const DataVisualizationPage(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: FutureBuilder(
          future: bloc.data._dataVisualizationPageViewModel
              .init(Sensing().controller!),
          builder: (context, data) {
            if (!data.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CarpAppBar(),
                  Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            const SizedBox(height: 15),
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
              );
            }
          },
        ),
      ),
    );
  }

  // The list of cards, depending on what measures are defined in the study.
  List<Widget> get _dataVizCards {
    final List<Widget> widgets = [];

    // always show tasks progress
    widgets.add(StudyProgressCardWidget(model.studyProgressCardDataModel));

    // check to show overall measure stats
    //if (bloc.hasMeasures()) widgets.add(MeasuresCardWidget(model.measuresCardDataModel));

    // check to show heart rate stats, if there is a POLAR device in the study
    if (bloc.hasMeasure(PolarSamplingPackage.HR)) {
      widgets.add(HeartRateOuterStatefulWidget(model.heartRateCardDataModel));
    }

    // check to show surveys stats
    if (bloc.hasSurveys()) {
      widgets.add(SurveyCard(model.surveysCardDataModel));
    }

    List<TaskCardViewModel> mediaModelsList = [];

    // check what media types are in the study and add them to de media card
    if (bloc.hasMeasure(MediaSamplingPackage.AUDIO)) {
      mediaModelsList.add(model.audioCardDataModel);
    }
    if (bloc.hasMeasure(MediaSamplingPackage.VIDEO)) {
      mediaModelsList.add(model.videoCardDataModel);
    }
    if (bloc.hasMeasure(MediaSamplingPackage.IMAGE)) {
      mediaModelsList.add(model.imageCardDataModel);
    }
    if (mediaModelsList.isNotEmpty) {
      widgets.add(MediaCardWidget(mediaModelsList));
    }

    // check to show device data visualizations
    if (bloc.hasDevices()) {
      //TODO ADD DEVICES VIZ?
    }

    if (bloc.hasMeasure(SensorSamplingPackage.STEP_COUNT)) {
      widgets.add(StepsCardWidget(model.stepsCardDataModel));
    }
    if (bloc.hasMeasure(ContextSamplingPackage.ACTIVITY)) {
      widgets.add(ActivityCard(model.activityCardDataModel));
    }
    if (bloc.hasMeasure(ContextSamplingPackage.MOBILITY)) {
      widgets.add(MobilityCard(model.mobilityCardDataModel));
      widgets.add(DistanceCard(model.mobilityCardDataModel));
    }

    return widgets.toSet().toList();
  }
}
