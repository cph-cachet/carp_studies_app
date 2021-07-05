// part of carp_study_app;

// class CarpStudyMainPage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       supportedLocales: const [
//         Locale('en'),
//         Locale('da'),
//         Locale('es'),
//       ],
//       // These delegates make sure that the localization data for the proper language is loaded
//       localizationsDelegates: [
//         // App translations
//         //  - the translations of app text is located in the 'assets/lang/' folder
//         AssetLocalizations.delegate,

//         // Research Package translations
//         //  - the translations of informed consent and surveys are to be
//         //    downloaded from CARP
//         RPLocalizations.delegate,

//         // Built-in localization of basic text for Cupertino widgets
//         GlobalCupertinoLocalizations.delegate,
//         // Built-in localization of basic text for Material widgets
//         GlobalMaterialLocalizations.delegate,
//         // Built-in localization for text direction LTR/RTL
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       localeListResolutionCallback: (locales, supportedLocales) {
//         return null;
//       },
//       // Returns a locale which will be used by the app
//       localeResolutionCallback: (locale, supportedLocales) {
//         // Work around for:
//         // https://github.com/flutter/flutter/issues/39032
//         if (locale == null) {
//           Intl.defaultLocale = supportedLocales.first.languageCode;
//           return supportedLocales.first;
//         }

//         // Check if the current device locale is supported
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale.languageCode
//               /* && supportedLocale.countryCode == locale.countryCode */
//               ) {
//             Intl.defaultLocale = supportedLocale.languageCode;
//             return supportedLocale;
//           }
//         }
//         // If the locale of the device is not supported, use the first one
//         // from the list (English, in this case).
//         Intl.defaultLocale = supportedLocales.first.languageCode;
//         return supportedLocales.first;
//       },
//       theme: carpStudyTheme,
//       darkTheme: carpStudyDarkTheme,
//       routes: {
//         '/HomePage': (context) => CarpStudyAppHome(),
//         '/ConsentPage': (context) => InformedConsentPage(),
//       },
//       initialRoute:
//           (bloc.shouldInformedConsentBeShown) ? '/ConsentPage' : '/HomePage',
//     );
//   }
// }

// class CarpStudyAppHome extends StatefulWidget {
//   CarpStudyAppHome({Key key}) : super(key: key);
//   CarpStudyAppHomeState createState() => CarpStudyAppHomeState();
// }

// class CarpStudyAppHomeState extends State<CarpStudyAppHome> {
//   int _selectedIndex = 0;
//   final _pages = [];

//   void initState() {
//     super.initState();

//     // start the sensing
//     // TODO - move this
//     bloc.start();

//     _pages.add(TaskListPage(bloc.data.taskListPageModel));
//     _pages.add(StudyPage(bloc.data.studyPageModel));
//     //_pages.add(TimerTaskPage());
//     _pages.add(DataVisualizationPage(bloc.data.dataPageModel));
//   }

//   void dispose() {
//     bloc.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     AssetLocalizations locale = AssetLocalizations.of(context);

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Theme.of(context).primaryColor,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.playlist_add_check_outlined),
//             label: locale.translate('app_home.nav_bar_item.tasks'),
//             activeIcon: Icon(Icons.playlist_add_check),
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.announcement_outlined),
//               label: locale.translate('app_home.nav_bar_item.about'),
//               activeIcon: Icon(Icons.announcement)),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.leaderboard_outlined),
//               label: locale.translate('app_home.nav_bar_item.data'),
//               activeIcon: Icon(Icons.leaderboard)),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _restart,
//       //   tooltip: 'Restart study & probes',
//       //   child: bloc.isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
//       // ),
//     );
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _restart() {
//     setState(() {
//       if (bloc.isRunning)
//         bloc.pause();
//       else
//         bloc.resume();
//     });
//   }
// }
