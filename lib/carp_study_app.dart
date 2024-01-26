part of 'main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
const String firstRoute = '/about';

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
            redirect: (context, state) => !CarpService().authenticated
                ? '/login'
                : (bloc.hasInformedConsentBeenAccepted
                    ? firstRoute
                    : '/consent'),
          ),
          GoRoute(
            path: '/tasks',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: TaskListPage(
                bloc.appViewModel.taskListPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/about',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: StudyPage(
                bloc.appViewModel.studyPageViewModel,
              ),
              transitionsBuilder: bottomNavigationBarAnimation,
            ),
          ),
          GoRoute(
            path: '/data',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: DataVisualizationPage(
                  bloc.appViewModel.dataVisualizationPageViewModel),
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
              child: ProfilePage(bloc.appViewModel.profilePageViewModel),
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
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final taskId = state.pathParameters['taskId'] ?? '';
          final task = AppTaskController().getUserTask(taskId);
          return task?.widget ?? const ErrorPage();
        },
      ),
      GoRoute(
        path: '/consent',
        parentNavigatorKey: _rootNavigatorKey,
        redirect: (context, state) => bloc.hasInformedConsentBeenAccepted
            ? firstRoute
            : (bloc.studyId == null ? '/invitations' : null),
        builder: (context, state) => InformedConsentPage(
          bloc.appViewModel.informedConsentViewModel,
        ),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/message/:messageId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => MessageDetailsPage(
            messageId: state.pathParameters['messageId'] ?? ''),
      ),
      GoRoute(
        path: '/invitation/:invitationId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => InvitationDetailsPage(
          invitationId: state.pathParameters['invitationId'] ?? '',
        ),
      ),
      GoRoute(
        path: '/invitations',
        parentNavigatorKey: _rootNavigatorKey,
        redirect: (context, state) => bloc.studyId != null
            ? '/consent'
            : (bloc.user == null ? '/login' : null),
        builder: (context, state) =>
            InvitationListPage(bloc.appViewModel.invitationsListViewModel),
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
