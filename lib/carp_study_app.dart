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
    // initialLocation: '/invitation/asdsa',
    initialLocation: (bloc.deploymentMode == DeploymentMode.local)
        ? '/LoadingPage'
        : '/Login',
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) =>
            HomePage(child: child),
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/tasks',
          ),
          GoRoute(
            path: '/tasks',
            redirect: (context, state) =>
                !bloc.isConfigured ? '/Loading/tasks' : null,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: TaskListPage(
                bloc.data.taskListPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/about',
            redirect: (context, state) =>
                !bloc.isConfigured ? '/Loading/about' : null,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: StudyPage(
                bloc.data.studyPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/data',
            redirect: (context, state) =>
                !bloc.isConfigured ? '/Loading/data' : null,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: DataVisualizationPage(
                  bloc.data.dataVisualizationPageViewModel),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/devices',
            redirect: (context, state) =>
                !bloc.isConfigured ? '/Loading/devices' : null,
            pageBuilder: (context, state) => const CustomTransitionPage(
              child: DevicesPage(),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          //   ],
          // ),
        ],
      ),
      GoRoute(
        path: '/Loading/:redirectionOrigin',
        builder: (context, state) =>
            LoadingPage(redirectionOrigin: state.params['redirectionOrigin']),
      ),
      GoRoute(
        path: '/Loading',
        builder: (context, state) => const LoadingPage(redirectionOrigin: ''),
      ),
      GoRoute(
        path: '/Consent',
        builder: (context, state) => const InformedConsentPage(
          bloc.data.informedConsentPageViewModelz
        ),
      ),
      GoRoute(
        path: '/FailedLogin',
        builder: (context, state) => const FailedLoginPage(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => const LoginPage(),
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
