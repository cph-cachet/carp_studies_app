part of carp_study_app;

class InformedConsentPage extends StatefulWidget {
  final InformedConsentState state = InformedConsentState();
  InformedConsentPage({Key? key}) : super(key: key);
  InformedConsentState createState() => state;
}

class InformedConsentState extends State<InformedConsentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void resultCallback(RPTaskResult result) async {
    await bloc.informedConsentHasBeenAccepted(result);
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  void cancellCallback(RPTaskResult? result) async {
    print("$runtimeType - Informed Consent not accepted");

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        RPLocalizations locale = RPLocalizations.of(context)!;

        return AlertDialog(
          title: Text(locale.translate("pages.ic.need_accept")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("pages.ic.go_to_ic")),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/InformedConsent');
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) {
          return RPUITask(
            task: bloc.informedConsent!,
            onSubmit: resultCallback,
            //onCancel: cancellCallback,
          );
        },
      ),
    );
  }
}
