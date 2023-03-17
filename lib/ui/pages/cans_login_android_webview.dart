part of carp_study_app;

class LoginPageAndroid extends StatefulWidget {
  final WebUri uri;

  const LoginPageAndroid({super.key, required this.uri});
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
              initialUrlRequest: URLRequest(url: widget.uri),
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
                if (url?.scheme == 'carp.studies') {
                  if (context.mounted) {
                    context.pop();
                  }
                  await bloc.webAuthOnComplete(url, null);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
