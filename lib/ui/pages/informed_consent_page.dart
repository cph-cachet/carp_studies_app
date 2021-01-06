part of carp_study_app;

class InformedConsentPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Informed consent upload has failed"),
      action: SnackBarAction(
          onPressed: () {
            //TODO: implement retry
            print("retrying");
          },
          label: "RETRY"),
    );

    void resultCallback(RPTaskResult result) async {
      SharedPreferences sp = await SharedPreferences.getInstance();

      // Upload consent document
      try {
        Navigator.of(context).pushReplacementNamed('/HomePage');
        // TODO: uploadInformedConsent
        /* ConsentDocument consentDocument = await CARPBackend().uploadInformedConsent(result);
        if (consentDocument != null) {
          // Save consent complete
          sp.setBool(CARPBackend.SP_INFORMED_CONSENT, true);
          print("LOG INFO: Informed consent uploaded");
          Navigator.of(context).pushReplacementNamed('/demographics');
        } else {
          _scaffoldKey.currentState.showSnackBar(snackBar);
          // TODO: Handle errors in uploading consent document
        } */
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }

      // sp.setBool(CARPBackend.SP_INFORMED_CONSENT, true);
      // print("LOG INFO: Informed consent uploaded");
      // Navigator.of(context).pushReplacementNamed('/demographics');
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) {
          return RPUITask(
            onSubmit: resultCallback,
            task: informedConsentTask,
          );
        },
      ),
    );
  }
}
