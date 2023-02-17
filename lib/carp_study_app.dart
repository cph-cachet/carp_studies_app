part of carp_study_app;

class CarpStudyApp extends StatefulWidget {
  const CarpStudyApp({super.key});

  static void reloadLocale(BuildContext context) async {
    CarpStudyAppState? state =
        context.findAncestorStateOfType<CarpStudyAppState>();
    state?.reloadLocale();
  }

  @override
  CarpStudyAppState createState() => CarpStudyAppState();
}

class CarpStudyAppState extends State<CarpStudyApp> {
  reloadLocale() {
    setState(() {
      rpLocalizationsDelegate.reload();
    });
  }

  final LoadingPage loadingPage = const LoadingPage();
  final HomePage homePage = const HomePage();
  final InformedConsentPage consentPage = const InformedConsentPage();
  final FailedLoginPage failedLoginPage = const FailedLoginPage();
  final LoginPageAndroid loginPageAndroid = const LoginPageAndroid();
  final LoginPageiOS loginPageiOS = const LoginPageiOS();
  final SetupPage setupPage = const SetupPage();

  /// Research Package translations, incl. both local language assets plus
  /// translations of informed consent and surveys downloaded from CARP
  final RPLocalizationsDelegate rpLocalizationsDelegate =
      RPLocalizationsDelegate(loaders: [
    const AssetLocalizationLoader(),
    bloc.localizationLoader,
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
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
      home: const Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('LoadingPage'),
            child: LoadingPage(),
          ),
          MaterialPage(
            key: ValueKey('LoginPageAndroid'),
            child: LoginPageAndroid(),
          ),
          MaterialPage(
            key: ValueKey('LoginPageiOS'),
            child: LoginPageiOS(),
          ),
          MaterialPage(
            key: ValueKey('SetupPage'),
            child: SetupPage(),
          ),
          MaterialPage(
            key: ValueKey('HomePage'),
            child: HomePage(),
          ),
          MaterialPage(
            key: ValueKey('ConsentPage'),
            child: InformedConsentPage(),
          ),
          MaterialPage(
            key: ValueKey('FailedLoginPage'),
            child: FailedLoginPage(),
          ),
        ],
      ),
      routes: {
        '/LoginPage': (context) =>
            Platform.isIOS ? loginPageiOS : loginPageAndroid,
        '/SetupPage': (context) => setupPage,
        '/LoadingPage': (context) => loadingPage,
        '/HomePage': (context) => homePage,
        '/ConsentPage': (context) => consentPage,
        '/FailedLoginPage': (context) => failedLoginPage,
      },
      initialRoute: '/LoginPage',
    );
  }
}
