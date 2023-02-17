part of carp_study_app;

class LoginPageAndroid extends StatefulWidget {
  const LoginPageAndroid({super.key});

  @override
  State<LoginPageAndroid> createState() => _LoginPageAndroidState();
}

class _LoginPageAndroidState extends State<LoginPageAndroid> {
  InAppWebViewController? webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri("https://cans.cachet.dk/portal/dev/login")),
              initialSettings: InAppWebViewSettings(
                domStorageEnabled: true,
                databaseEnabled: true,
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {},
              onUpdateVisitedHistory:
                  (InAppWebViewController controller, Uri? url, ok) async {
                if (url
                        ?.toString()
                        .startsWith("https://cans.cachet.dk/portal/dev/") ??
                    false) {
                  String? tokenFromJSEvaluation =
                      await controller.evaluateJavascript(
                          source:
                              "localStorage.getItem('study_portal_dev.sessionToken')");
                  info(tokenFromJSEvaluation ?? 'Token is empty');

                  if (tokenFromJSEvaluation != null) {
                    // do something with your token
                    // ...
                    // then close the webview
                    Future.microtask(() {
                      Navigator.pop(context, tokenFromJSEvaluation);
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
