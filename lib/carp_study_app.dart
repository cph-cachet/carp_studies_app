part of carp_study_app;

class CarpStudyApp extends StatelessWidget {
  final LoadingPage loadingPage = LoadingPage();
  final HomePage homePage = HomePage();
  final InformedConsentPage consentPage = InformedConsentPage();
  final FailedLoginPage failedLoginPage = FailedLoginPage();

  /// Research Package translations, incl. the translations of informed consent
  /// and surveys are to be downloaded from CARP
  final RPLocalizationsDelegate rpLocalizationsDelegate =
      RPLocalizationsDelegate(loader: bloc.localizationLoader);

  CarpStudyApp();

  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
        Locale('es'),
      ],
      // These delegates make sure that localization for the phone language is loaded
      localizationsDelegates: [
        // app translations - located in the 'assets/lang/' folder
        AssetLocalizations.delegate,

        // Research Package translations
        //  - the translations of informed consent and surveys are to be
        //    downloaded from CARP
        rpLocalizationsDelegate,

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
      // home: loadingPage,
      routes: {
        '/LoadingPage': (context) => loadingPage,
        '/HomePage': (context) => homePage,
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
    //
    // HOWEVER - all of this seems broken - we should maybe have our own login
    // page for this app....
    //
    // TODO - make app-specific login page?
    if (!bloc.isConfiguring) {
      bloc.configure(context).then((_) {
        // when the setup is done, the localizations should have been downloaded
        // and we can ask the delegate to reload
        app.rpLocalizationsDelegate.reload();

        // TODO - here the app should somehow be told to reload the
        // localizations -- BUT simply cannot make this happen.....??????
        print(
            ' >> reload? - ${app.rpLocalizationsDelegate.shouldReload(app.rpLocalizationsDelegate)}');

        // then navigate to the right screen
        Navigator.of(context).pushReplacementNamed(
            (bloc.shouldInformedConsentBeShown) ? '/ConsentPage' : '/HomePage');
      });
    }

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        )));
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
