part of carp_study_app;

class LoadingPage extends StatefulWidget {
  final String? redirectionOrigin;

  const LoadingPage({super.key, this.redirectionOrigin});

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    // configure the BLOC if not already done or in progress
    // note that this build() method can be called several time, but we only
    // want the bloc to be configured once.
    //
    // the only reason to call it here - instead of in the initState() method -
    // is to have a handle to the context object, which is to be used in the
    // pop-up windows from CARP
    var redirectTo = widget.redirectionOrigin ?? 'tasks';
    if (!bloc.isConfiguring) {
      bloc.configure(context).then((_) {
        // when the configure is done, the localizations should have been downloaded
        // and we can ask the app to reload the translations
        CarpStudyApp.reloadLocale(context);

        // navigate to the right screen
        context.go((bloc.shouldInformedConsentBeShown)
            ? '/ConsentPage'
            : '/$redirectTo');
      });
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (!bloc.isConfiguring) {
        // if the bloc is not configured after 5 seconds, we assume that something
        // went wrong and we show an error message
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Could not configure a study.'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        bloc.leaveStudyAndSignOut();

                        context.canPop()
                            ? context.pop()
                            : context.go('SetupPage');
                      },
                    )
                  ],
                ));
      }
    });

    // If the user has left the study it is still logged in and should be redirected to invitation screen

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [CircularProgressIndicator()],
        )));
  }
}
