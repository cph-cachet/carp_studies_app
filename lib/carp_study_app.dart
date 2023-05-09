part of carp_study_app;

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
    navigatorKey: _rootNavigatorKey,
    errorBuilder: (context, state) => const ErrorPage(),
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) =>
            HomePage(child: child),
        routes: [
          GoRoute(
            path: '/',
            parentNavigatorKey: _shellNavigatorKey,
            redirect: (context, state) =>
                bloc.hasInformedConsentBeenAccepted ? '/tasks' : '/consent',
          ),
          GoRoute(
            path: '/tasks',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: TaskListPage(
                bloc.data.taskListPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/about',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: StudyPage(
                bloc.data.studyPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/data',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: DataVisualizationPage(
                  bloc.data.dataVisualizationPageViewModel),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/devices',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => const CustomTransitionPage(
              child: DevicesPage(),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/profile',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: ProfilePage(bloc.data.profilePageViewModel),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/studyDetails',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => StudyDetailsPage(),
      ),
      GoRoute(
        path: '/task/:taskId',
        builder: (context, state) {
          String taskId = state.params['taskId'] ?? '';
          var task = bloc.tasks.firstWhere((task) => task.id == taskId);
          var type = task.runtimeType;
          if (type == AudioUserTask) {
            return AudioTaskPage(
              audioUserTask: task as AudioUserTask,
            );
          } else if (type == VideoUserTask) {
            return CameraTaskPage(mediaUserTask: task as VideoUserTask);
          }
          return Scaffold(body: Container());
        },
      ),
      GoRoute(
        path: '/consent',
        parentNavigatorKey: _rootNavigatorKey,
        redirect: (context, state) =>
            bloc.studyId == null ? '/invitations' : null,
        builder: (context, state) => InformedConsentPage(
          bloc.data.informedConsentViewModel,
        ),
      ),
      GoRoute(
        path: '/failedLogin',
        builder: (context, state) => const FailedLoginPage(),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => LoginPage(
          bloc.data.loginPageViewModel,
        ),
      ),
      GoRoute(
        path: '/message/:messageId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            MessageDetailsPage(messageId: state.params['messageId'] ?? ''),
      ),
      GoRoute(
        path: '/invitation/:invitationId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => InvitationDetailsPage(
          invitationId: state.params['invitationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/invitations',
        parentNavigatorKey: _rootNavigatorKey,
        redirect: (context, state) => bloc.user == null ? '/login' : null,
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
      RPLocalizationsDelegate(
    loaders: [
      const AssetLocalizationLoader(),
      bloc.localizationLoader,
    ],
  );

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
