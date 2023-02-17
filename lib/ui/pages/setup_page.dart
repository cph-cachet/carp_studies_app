part of carp_study_app;

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  SetupPageState createState() => SetupPageState();
}

class SetupPageState extends State<SetupPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // configure the BLOC if not already done or in progress
    // note that this build() method can be called several time, but we only
    // want the bloc to be configured once.
    //
    // the only reason to call it here - instead of in the initState() method -
    // is to have a handle to the context object, which is to be used in the
    // pop-up windows from CARP
    // if (!bloc.isConfiguring) {
    //   bloc.configure(context).then((_) {
    //     // when the configure is done, the localizations should have been downloaded
    //     // and we can ask the app to reload the translations
    //     CarpStudyApp.reloadLocale(context);

    //     // navigate to the right screen
    //     // Navigator.of(context).pushReplacementNamed(
    //     //     (bloc.shouldInformedConsentBeShown) ? '/ConsentPage' : '/HomePage');
    //   });
    // }

    // // If the user has left the study it is still logged in and should be redirected to invitation screen
    // if (bloc.hasLeftStudy) {
    //   bloc.hasLeftStudy = false;
    // }

    // // If the user is loged out, redirect to authentication screen
    // if (bloc.hasSignedOut) {
    //   bloc.hasSignedOut = false;
    // }

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: ElevatedButton(
            child: const Text('Setup'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/LoginPage');
            },
          ),
        ));
  }
}
