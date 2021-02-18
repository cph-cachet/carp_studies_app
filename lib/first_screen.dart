part of carp_study_app;

class CARPStudyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('da'),
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
      home: SplashScreen(),
      routes: {
        '/HomePage': (context) => CARPStudyAppHome(),
        '/ConsentPage': (context) => InformedConsentPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future load(BuildContext context) async => (bloc.hasInformedConsentBeenAccepted)
      ? Navigator.of(context).pushReplacementNamed('/HomePage')
      : Navigator.of(context).pushReplacementNamed('/ConsentPage');

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor, body: _initial()
        /* Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: load(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Column(children: [
                      CircularProgressIndicator(
                          //strokeWidth: 8,
                          )
                    ]),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ), */
        );
  }
}

Widget _initial() {
  if (bloc.hasInformedConsentBeenAccepted)
    return CARPStudyAppHome();
  else
    return InformedConsentPage();
}
