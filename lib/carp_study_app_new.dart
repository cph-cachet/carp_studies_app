part of carp_study_app;

class NewCarpStudyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
        Locale('es'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // App translations
        //  - the translations of app text is located in the 'assets/lang/' folder
        AssetLocalizations.delegate,

        // Research Package translations
        //  - the translations of informed consent and surveys are to be
        //    downloaded from CARP
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
        '/LoadingPage': (context) => LoadingPage(),
        '/ConsentPage': (context) => InformedConsentPage(),
        '/HomePage': (context) => HomePage(),
      },
      // initialRoute: '/LoadingPage',
    );
  }
}

class NewLoadingPage extends StatelessWidget {
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

    // this is done in order to test the entire onboarding flow
    // TODO - remove when done testing
    await bloc.leaveStudyAndSignOut();

    //  initialize the CARP backend, if needed
    if (bloc.deploymentMode != DeploymentMode.LOCAL) {
      await bloc.backend.initialize();
      await bloc.backend.authenticate(context);
      await bloc.backend.getStudyInvitation(context);
    }

    // TODO - at this point, the localization should be fetched before showing the informed consent

    // RPLocalizationsDelegate delegate =
    //     RPLocalizationsDelegate(loader: FileLocalizationLoader());

    // MaterialApp app = this.context.findAncestorWidgetOfExactType<MaterialApp>();
    // app.localizationsDelegates.any((element) => false)

    // find the right informed consent, if needed
    bloc.informedConsent = (!bloc.hasInformedConsentBeenAccepted)
        ? await bloc.resourceManager.getInformedConsent()
        : null;

    await bloc.messageManager.init();
    await bloc.getMessages();
    await Sensing().initialize();

    print(toJsonString(bloc.deployment));

    // initialize the data models
    bloc.data.init(Sensing().controller);

    debug('$runtimeType initializing done.');

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CircularProgressIndicator()],
                )));
          } else {
            Navigator.of(context).pushReplacementNamed(
                (bloc.shouldInformedConsentBeShown)
                    ? '/ConsentPage '
                    : '/HomePage');
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CircularProgressIndicator()],
                )));
          }
        });
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
