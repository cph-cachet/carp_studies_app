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
          session != null
              ? Container()
              : Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (session == null &&
                            Platform.isIOS &&
                            await WebAuthenticationSession.isAvailable()) {
                          session = await WebAuthenticationSession.create(
                              url: WebUri(
                                  "https://cans.cachet.dk/portal/dev/login"),
                              callbackURLScheme: "carp.studies",
                              onComplete: (url, error) async {
                                if (url != null) {
                                  setState(() {
                                    token = url.queryParameters["token"];
                                  });
                                }
                              });
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Cannot create Web Authentication Session!'),
                          ));
                        }
                      },
                      child: const Text("Create Web Auth Session")),
                ),
          session == null
              ? Container()
              : Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        var started = false;
                        if (await session?.canStart() ?? false) {
                          started = await session?.start() ?? false;
                        }
                        if (!started) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Cannot start Web Authentication Session!'),
                          ));
                        }
                      },
                      child: const Text("Start Web Auth Session")),
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
}
