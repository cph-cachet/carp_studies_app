part of carp_study_app;

class SurveyTaskRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RPUITask(
        task: surveys.timedExposure.survey, onSubmit: resultCallback // Collecting results, see next section
        );
  }

  void resultCallback(RPTaskResult result) {
    // Do whatever you want with the result
    // In this case we are just printing the result's keys
    print(result.results.keys);
  }
}
