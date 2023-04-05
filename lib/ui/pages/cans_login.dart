part of carp_study_app;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  WebAuthenticationSession? loginSession;
  WebAuthenticationSession? registerSession;
  final GlobalKey webViewKey = GlobalKey();
  WebUri loginUri = WebUri(
      'https://cans.cachet.dk/portal/playground/login?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/login?redirect=carp.studies://auth');
  WebUri registerUri = WebUri(
      'https://cans.cachet.dk/portal/playground/register?redirect=carp.studies://auth');

  @override
  void initState() {
    bloc.stateStream.sink.add(StudiesAppState.loginpage);
    if (Platform.isIOS) {
      bloc.createWebAuthenticationSession(loginSession, loginUri).then((value) {
        loginSession = value;
      });
      bloc
          .createWebAuthenticationSession(registerSession, registerUri)
          .then((value) {
        registerSession = value;
      });
      info("Initially created log in session");
    }

    bloc.stateStream.stream.listen((event) {
      if (event == StudiesAppState.accessTokenRetrieved && context.mounted) {
        context.go('/Invitations');
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 56),
                  child: Image.asset(
                    'assets/carp_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                width: width,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(
                    0xff006398,
                  ),
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (Platform.isIOS) {
                      await iOSAuthentication(loginSession);
                    }
                    if (Platform.isAndroid && context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LoginPageAndroid(uri: loginUri)));
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
              ),
              Container(
                margin: EdgeInsets.fromLTRB(64, 0, 64, height * 0.1),
                width: width,
                height: 56,
                child: TextButton(
                  onPressed: () async {
                    if (Platform.isIOS) {
                      await iOSAuthentication(registerSession);
                    }
                    if (Platform.isAndroid && context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LoginPageAndroid(uri: registerUri)));
                    }
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> iOSAuthentication(WebAuthenticationSession? session) async {
    if (session != null && await session.canStart()) {
      session = await bloc.startWebAuthenticationSession(session);
      info("Session is not null, starting session. Session is $session");
    } else if (session != null) {
      info("Session is $session. Recreating.");
      session = null;
      session = await bloc.createWebAuthenticationSession(session, loginUri);
      session = await bloc.startWebAuthenticationSession(session!);
    }
    if (session == null) {
      info("Session is null, creating.");
      session = await bloc.createWebAuthenticationSession(session, loginUri);
    }
  }
}
