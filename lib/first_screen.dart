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
        '/AudioTaskPage': (context) => AudioTaskPage(), // TODO: remove
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future load(BuildContext context) async =>
  //     (bloc.hasInformedConsentBeenAccepted)
  //         ? Navigator.of(context).pushReplacementNamed('/HomePage')
  //         : Navigator.of(context).pushReplacementNamed('/ConsentPage');

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: (bloc.hasInformedConsentBeenAccepted)
                  ? Navigator.of(context).pushReplacementNamed('/HomePage')
                  : Navigator.of(context).pushReplacementNamed('/ConsentPage'),
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
