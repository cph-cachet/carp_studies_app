part of carp_study_app;

class InformedConsentPage extends StatefulWidget {
  static const String route = '/consent';
  final InformedConsentViewModel model;
  const InformedConsentPage({super.key, required this.model});

  @override
  InformedConsentState createState() => InformedConsentState();
}

class InformedConsentState extends State<InformedConsentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void resultCallback(RPTaskResult result) {
    widget.model.informedConsentHasBeenAccepted(result);
    if (context.mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations localization = RPLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder<RPOrderedTask?>(
        future: widget.model.getInformedConsent(localization.locale).then(
          (document) {
            if (document == null) {
              bloc.hasInformedConsentBeenAccepted = true;
              context.go('/');
            }
            return document;
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return RPUITask(
                task: snapshot.data!,
                onSubmit: resultCallback,
              );
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
