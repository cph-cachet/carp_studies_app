part of carp_study_app;

class InformedConsentPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void resultCallback(RPTaskResult result) async {
      await bloc.informedConsentHasBeenAccepted(result);
      Navigator.of(context).pushReplacementNamed('/HomePage');
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) {
          return RPUITask(
            onSubmit: resultCallback,
            task: bloc.informedConsent,
          );
        },
      ),
    );
  }
}
