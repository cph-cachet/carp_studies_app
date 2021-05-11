part of carp_study_app;

class InformedConsentPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Saving informed consent failed. Please restart the app."),
      action: SnackBarAction(
          onPressed: () {
            //TODO: restart the app?
            print("Restarting the app....");
          },
          label: "RESTART"),
    );

    void resultCallback(RPTaskResult result) async {
      Navigator.of(context).pushReplacementNamed('/HomePage');

      // Upload consent document
      try {
        await bloc.backend.uploadInformedConsent(result);
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
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
