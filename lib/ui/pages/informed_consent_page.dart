part of carp_study_app;

class InformedConsentPage extends StatefulWidget {
  final InformedConsentState state = InformedConsentState();
  InformedConsentPage({Key? key}) : super(key: key);
  InformedConsentState createState() => state;
}

// class InformedConsentPage extends StatelessWidget {

class InformedConsentState extends State<InformedConsentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void resultCallback(RPTaskResult result) async {
    await bloc.informedConsentHasBeenAccepted(result);
    Navigator.of(context).pushReplacementNamed('/HomePage');
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
          );
        },
      ),
    );
  }
}
