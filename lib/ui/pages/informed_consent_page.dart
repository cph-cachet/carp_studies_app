part of carp_study_app;

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
      context.go('/tasks');
    }
  }

  void cancelCallback(RPTaskResult? result) async {
    info("$runtimeType - Informed Consent canceled");

    await showDialog(
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
                context.go('/InformedConsent');
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
      body: FutureBuilder<RPOrderedTask?>(
        future: widget.model.informedConsent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData == false) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const Text("No informed consent found"),
                      ElevatedButton(
                        child: const Text('Okay'),
                        onPressed: () => context.go('/tasks'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return RPUITask(
            task: snapshot.data!,
            onSubmit: resultCallback,
            onCancel: cancelCallback,
          );
        },
      ),
    );
  }
}
