part of carp_study_app;

class CarpStudyApp extends StatefulWidget {
  CarpStudyApp({Key? key}) : super(key: key);

  static void reloadLocale(BuildContext context) async {
    _CarpStudyAppState? state =
        context.findAncestorStateOfType<_CarpStudyAppState>();
    state?.reloadLocale();
  }

  @override
  _CarpStudyAppState createState() => _CarpStudyAppState();
}

class _CarpStudyAppState extends State<CarpStudyApp> {
  reloadLocale() {
    setState(() {
      rpLocalizationsDelegate.reload();
    });
  }

  final LoadingPage loadingPage = LoadingPage();
  final HomePage homePage = HomePage();
  // final LocationUsageDialog locationUsagePage = LocationUsageDialog();

  final InformedConsentPage consentPage = InformedConsentPage();
  final FailedLoginPage failedLoginPage = FailedLoginPage();

  /// Research Package translations, incl. both local language assets plus
  /// translations of informed consent and surveys downloaded from CARP
  final RPLocalizationsDelegate rpLocalizationsDelegate =
      RPLocalizationsDelegate(loaders: [
    AssetLocalizationLoader(),
    bloc.localizationLoader,
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
        // TODO - need to update the es.json file, if we want to claim to support Spanish
        Locale('es'),
      ],
      // These delegates make sure that localization for the phone language is loaded
      localizationsDelegates: [
        // Research Package translations
        rpLocalizationsDelegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode
              // && supportedLocale.countryCode == locale?.countryCode
              ) {
            Intl.defaultLocale = supportedLocale.languageCode;
            return supportedLocale;
          }
        }
        return supportedLocales.first; // default to EN
      },
      theme: carpStudyTheme,
      darkTheme: carpStudyDarkTheme,
      // home: loadingPage,
      routes: {
        '/LoadingPage': (context) => loadingPage,
        '/HomePage': (context) => homePage,
        // '/LocationUsagePage': (context) => locationUsagePage,
        '/ConsentPage': (context) => consentPage,
        '/FailedLoginPage': (context) => failedLoginPage,
      },
      initialRoute: '/LoadingPage',
    );
  }
}

class LoadingPage extends StatefulWidget {
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
    if (!bloc.isConfiguring) {
      bloc.configure(context).then((_) {
        // when the configure is done, the localizations should have been downloaded
        // and we can ask the app to reload the translations
        CarpStudyApp.reloadLocale(context);

        // At this point, the study deployment AND the translations are loaded.
        // This means that we can translate the [AppTask]s in the protocol,
        // if we want the translated title and description to be in the notifications.
        // TODO - translate the app tasks in the deployment protocol.

        // check for permissions
        bloc.configurePermissions(context).then((_) {
          // then navigate to the right screen
          Navigator.of(context).pushReplacementNamed(
              (bloc.shouldInformedConsentBeShown)
                  ? '/ConsentPage'
                  : '/HomePage');
        });
      });
    }

    // If the user has left the study it is still logged in and should be redirected to invitation screen
    if (bloc.hasLeftStudy) {
      bloc.hasLeftStudy = false;
    }

    // If the user is loged out, redirect to authentication screen
    if (bloc.hasSignedOut) {
      bloc.hasSignedOut = false;
    }

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        )));
  }

  Widget get _splashImage => Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/splash_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Hero(
          tag: "tick",
          child: Image.asset('assets/images/splash_cachet.png',
              width: 150.0, height: 150.0, scale: 1.0),
        )),
      );
}
