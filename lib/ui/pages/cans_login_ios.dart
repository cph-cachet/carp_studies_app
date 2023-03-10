part of carp_study_app;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        context.go('/Loading');
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          width: 291,
          height: 56,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xff006398,
            ),
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (Platform.isIOS) {
                        await iOSAuthentication();
                      }
                      if (Platform.isAndroid && context.mounted) {
                        context.push('/AndroidLogin');
                      }
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(
                          0xffffffff,
                        ),
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> iOSAuthentication() async {
    if (session != null && await session!.canStart()) {
      session = await bloc.startWebAuthenticationSession(session!);
      info("Session is not null, starting session. Session is $session");
    } else if (session != null) {
      info("Session is $session. Recreating.");
      session = null;
      session = await bloc.createWebAuthenticationSession(session, uri);
      session = await bloc.startWebAuthenticationSession(session!);
    }
    if (session == null) {
      info("Session is null, creating.");
      session = await bloc.createWebAuthenticationSession(session, uri);
    }
  }
}
