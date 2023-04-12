part of carp_study_app;

FadeTransition bottomNavigationBarAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) =>
    FadeTransition(
      opacity: animation,
      child: child,
    );

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
    initialLocation: '/',
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) =>
            HomePage(child: child),
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) =>
                bloc.hasInformedConsentBeenAccepted ? '/tasks' : '/Consent',
          ),
          GoRoute(
            path: '/tasks',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: TaskListPage(
                bloc.data.taskListPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/about',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: StudyPage(
                bloc.data.studyPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/data',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: DataVisualizationPage(
                  bloc.data.dataVisualizationPageViewModel),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/devices',
            pageBuilder: (context, state) => const CustomTransitionPage(
              child: DevicesPage(),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/Consent',
        redirect: (context, state) =>
            bloc.studyId == null ? '/Invitations' : null,
        builder: (context, state) => InformedConsentPage(
          bloc.data.informedConsentViewModel,
        ),
      ),
      GoRoute(
        path: '/FailedLogin',
        builder: (context, state) => const FailedLoginPage(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => LoginPage(
          bloc.data.loginPageViewModel,
        ),
      ),
      GoRoute(
        path: '/Message/:messageId',
        builder: (context, state) =>
            MessageDetailsPage(messageId: state.params['messageId'] ?? ''),
      ),
      GoRoute(
        path: '/Invitation/:invitationId',
        builder: (context, state) => InvitationDetailsPage(
          invitationId: state.params['invitationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const FailedLoginPage(),
      ),
      GoRoute(
        path: '/Invitations',
        redirect: (context, state) => bloc.user == null ? '/Login' : null,
        builder: (context, state) =>
            InvitationListPage(bloc.data.invitationsListViewModel),
      ),
      GoRoute(
        path: '/test',
        builder: (context, state) => TaskListPage(
          bloc.data.taskListPageViewModel,
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
      scaffoldMessengerKey: bloc.scaffoldKey,
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
