part of carp_study_app;

class LoginPageiOS extends StatefulWidget {
  const LoginPageiOS({super.key});

  @override
  State<LoginPageiOS> createState() => _LoginPageiOSState();
}

class _LoginPageiOSState extends State<LoginPageiOS> {
  final GlobalKey webViewKey = GlobalKey();

  WebAuthenticationSession? session;
  String? token;

  @override
  void initState() {
    createWebAuthenticationSession();

    super.initState();
  }

  @override
  void dispose() {
    session?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Web Authentication Session example')),
        body: Column(children: <Widget>[
          Center(
              child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text("Token: $token"),
          )),
          // session != null
          //     ? Container()
          //     : Center(
          //         child: ElevatedButton(
          //           child: const Text("Create Web Auth Session"),
          //           onPressed: () async {
          //             createWebAuthenticationSession();
          //           },
          //         ),
          //       ),
          // session == null
          //     ? Container()
          //     :
              Center(
                  child: ElevatedButton(
                    onPressed: startWebAuthenticationSession,
                    child: const Text("Start Web Auth Session"),
                  ),
                ),
          session == null
              ? Container()
              : Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await session?.dispose();
                        setState(() {
                          token = null;
                          session = null;
                        });
                      },
                      child: const Text("Dispose Web Auth Session")),
                )
        ]));
  }

  void startWebAuthenticationSession() {
    session ?? createWebAuthenticationSession();
    session?.canStart().then((canStart) {
      if (canStart) {
        session?.start().then((started) {
          if (!started) {
            session?.dispose();
            createWebAuthenticationSession();
          }
        });
      } else {
        createWebAuthenticationSession();
      }
    });
  }

  void createWebAuthenticationSession() {
    WebAuthenticationSession.isAvailable().then((isAvailable) async {
      if (session == null && isAvailable) {
        session = await WebAuthenticationSession.create(
          url: WebUri("https://cans.cachet.dk/portal/dev/login"),
          callbackURLScheme: "https",
          onComplete: (url, error) async {
            if (url != null) {
              setState(() {
                token = url.queryParameters["token"];
              });
            }
          },
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot create Web Authentication Session!'),
        ));
      }
    });
  }
}
