part of '../../main.dart';

class InformedConsentPage extends StatefulWidget {
  final InformedConsentViewModel model;

  const InformedConsentPage(this.model, {super.key});

  @override
  InformedConsentState createState() => InformedConsentState();
}

class InformedConsentState extends State<InformedConsentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void resultCallback(RPTaskResult result) async {
    await widget.model.informedConsentHasBeenAccepted(result);
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
          (value) {
            if (value == null) {
              bloc.hasInformedConsentBeenAccepted = true;
              context.go('/');
            }
            return value;
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

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
