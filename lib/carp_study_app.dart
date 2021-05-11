part of carp_study_app;

class CarpStudyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
        Locale('es'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        RPLocalizations.delegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        return null;
      },
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Work around for:
        // https://github.com/flutter/flutter/issues/39032
        if (locale == null) {
          Intl.defaultLocale = supportedLocales.first.languageCode;
          return supportedLocales.first;
        }

        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode
              /* && supportedLocale.countryCode == locale.countryCode */
              ) {
            Intl.defaultLocale = supportedLocale.languageCode;
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        Intl.defaultLocale = supportedLocales.first.languageCode;
        return supportedLocales.first;
      },
      theme: carpStudyTheme,
      darkTheme: carpStudyDarkTheme,
      home: LoadingPage(),
      routes: {
        '/HomePage': (context) => CarpStudyAppHome(),
        '/ConsentPage': (context) => InformedConsentPage(),
      },
    );
  }
}

class LoadingPage extends StatefulWidget {
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  /// This methods is used to set up the entire app, including:
  ///  * initialize the bloc
  ///  * authenticate the user
  ///  * get the invitation
  ///  * get the informed consent
  ///  * get the study
  ///  * initialize sensing
  ///  * start sensing
  Future<bool> initialize(BuildContext context) async {
    // initialize the bloc, setting the deployment mode:
    //  * LOCAL
    //  * CARP_STAGGING
    //  * CARP_PRODUCTION
    await bloc.initialize(DeploymentMode.LOCAL);

    // only initialize the CARP backend, if needed
    if (bloc.deploymentMode != DeploymentMode.LOCAL) {
      await bloc.backend.initialize();
      await bloc.backend.authenticate(context);
      await bloc.backend.getStudyInvitation(context);
      await CarpResourceManager().initialize();
    }

    // find the right informed consent (if needed)
    if (!bloc.hasInformedConsentBeenAccepted) {
      if (bloc.deploymentMode == DeploymentMode.LOCAL) {
        bloc.informedConsent = LocalResourceManager().getInformedConsent();
      } else {
        bloc.informedConsent = await CarpResourceManager().getInformedConsent();
      }
    }

    await bloc.messageManager.init();
    await bloc.getMessages();
    await Sensing().initialize();

    // initialize thee data models
    bloc.data.init(Sensing().controller);

    // wait 10 sec and the start sampling
    // TODO - legally, we should not start sensing before informed consent is accepted...
    Timer(Duration(seconds: 10), () => bloc.start());

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(context),
        builder: (context, snapshot) => (!snapshot.hasData)
            ? Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CircularProgressIndicator()],
                )))
            : Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: (bloc.hasInformedConsentBeenAccepted)
                    ? CarpStudyAppHome()
                    : InformedConsentPage(),
              ));
  }

  // TODO - Not used right now - should we?
  Widget get _splashImage => Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/splash_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Center(
            child: new Hero(
          tag: "tick",
          child: new Image.asset('assets/images/splash_cachet.png',
              width: 150.0, height: 150.0, scale: 1.0),
        )),
      );
}
