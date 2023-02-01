part of carp_study_app;

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
                  print(tokenFromJSEvaluation);

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
