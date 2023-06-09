part of carp_study_app;

class LoginPage extends StatefulWidget {
  final LoginPageViewModel model;
  const LoginPage(this.model, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    bloc.stateStream.sink.add(StudiesAppState.loginpage);
    if (Platform.isIOS) {
      widget.model
          .createWebAuthenticationSession(
              widget.model.loginSession, bloc.backend.loginUri)
          .then((value) {
        widget.model.loginSession = value;
      });
      widget.model
          .createWebAuthenticationSession(
              widget.model.registerSession, bloc.backend.registerUri)
          .then((value) {
        widget.model.registerSession = value;
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
    widget.model.loginSession?.dispose();
    widget.model.registerSession?.dispose();
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
                      await widget.model
                          .iOSAuthentication(widget.model.loginSession);
                    }
                    if (Platform.isAndroid && context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LoginPageAndroid(widget.model)));
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
                      await widget.model
                          .iOSAuthentication(widget.model.registerSession);
                    }
                    if (Platform.isAndroid && context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LoginPageAndroid(widget.model)));
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
}
