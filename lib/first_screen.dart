part of carp_study_app;

class CARPStudyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: carpStudyTheme,
      darkTheme: carpStudyDarkTheme,
      home: SplashScreen(),
      routes: {
        '/HomePage': (context) => CARPStudyAppHome(),
        '/ConsentPage': (context) => InformedConsentPage(),
        '/ProfilePage': (context) => ProfilePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  load(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool firstTime = sp.getBool('first_time');
    firstTime = false; // for testing purposes.

    if (firstTime != null && !firstTime) {
      // Not first time
      return Navigator.of(context).pushReplacementNamed('/HomePage');
    } else {
      // First time
      sp.setBool('first_time', false);
      return Navigator.of(context).pushReplacementNamed('/ConsentPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
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
                        strokeWidth: 8,
                      )
                    ]),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
