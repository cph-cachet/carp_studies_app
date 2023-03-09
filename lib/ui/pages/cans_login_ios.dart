part of carp_study_app;

class LoginPageiOS extends StatefulWidget {
  const LoginPageiOS({super.key});

  @override
  State<LoginPageiOS> createState() => _LoginPageiOSState();
}

class _LoginPageiOSState extends State<LoginPageiOS> {
  WebAuthenticationSession? session;
  final GlobalKey webViewKey = GlobalKey();
  WebUri uri = WebUri(
      'https://cans.cachet.dk/portal/playground/login?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/login?redirect=carp.studies://auth');

  @override
  void initState() {
    bloc.stateStream.sink.add(StudiesAppState.loginpage);
    if (Platform.isIOS) {
      bloc.createWebAuthenticationSession(session, uri).then((value) {
        session = value;
      });
      info("Initially created log in session");
    }

    bloc.stateStream.stream.listen((event) {
      if (event == StudiesAppState.accessTokenRetrieved && context.mounted) {
        context.go('/LoadingPage');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Web Authentication Session example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              if (session != null && await session!.canStart()) {
                session = await bloc.startWebAuthenticationSession(session!);
                info(
                    "Session is not null, starting session. Session is $session");
              } else if (session != null) {
                info("Session is $session. Recreating.");
                session = null;
                session =
                    await bloc.createWebAuthenticationSession(session, uri);
                session = await bloc.startWebAuthenticationSession(session!);
              }
              if (session == null) {
                info("Session is null, creating.");
                session =
                    await bloc.createWebAuthenticationSession(session, uri);
              }
            },
            child: const Text("Login"),
          ),
        ));
  }
}
