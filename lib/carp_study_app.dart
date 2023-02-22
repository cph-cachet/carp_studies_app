part of carp_study_app;

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

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

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/SetupPage',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: HomePage(child: child),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const LoginPageiOS(),
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: 'tasks',
                builder: (context, state) =>
                    TaskListPage(bloc.data.taskListPageViewModel),
              ),
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: 'about',
                builder: (context, state) =>
                    StudyPage(bloc.data.studyPageViewModel),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'data',
                builder: (context, state) => DataVisualizationPage(
                    bloc.data.dataVisualizationPageViewModel),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'devices',
                builder: (context, state) => const DevicesPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/LoadingPage',
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: '/ConsentPage',
        builder: (context, state) => const InformedConsentPage(),
      ),
      GoRoute(
        path: '/FailedLoginPage',
        builder: (context, state) => const FailedLoginPage(),
      ),
      GoRoute(
        path: '/LoginPage',
        builder: (context, state) =>
            Platform.isIOS ? const LoginPageiOS() : const LoginPageAndroid(),
      ),
      GoRoute(
        path: '/SetupPage',
        builder: (context, state) => const SetupPage(),
      ),
      GoRoute(
        path: '/message/:messageId',
        builder: (context, state) =>
            MessageDetailsPage(messageId: state.params['messageId'] ?? ''),
      ),
      GoRoute(
        path: '/invitation/:invitationId',
        builder: (context, state) => InvitationPage(
          invitationId: state.params['invitationId'] ?? '',
        ),
      ),
    ],
    debugLogDiagnostics: true,
  );

  /// Research Package translations, incl. both local language assets plus
  /// translations of informed consent and surveys downloaded from CARP
  final RPLocalizationsDelegate rpLocalizationsDelegate =
      RPLocalizationsDelegate(loaders: [
    const AssetLocalizationLoader(),
    bloc.localizationLoader,
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _router,
    );
  }
}
