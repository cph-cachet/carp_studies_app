part of carp_study_app;

class LoginPageAndroid extends StatefulWidget {
  final LoginPageViewModel model;

  const LoginPageAndroid(this.model, {super.key});
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
              initialUrlRequest: URLRequest(url: widget.model.getLoginUri),
              initialSettings: InAppWebViewSettings(
                domStorageEnabled: true,
                databaseEnabled: true,
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {},
              onUpdateVisitedHistory:
                  (InAppWebViewController controller, Uri? url, ok) {},
              onLoadStop: (controller, url) async {
                if (url?.scheme == 'carp.studies') {
                  await widget.model.webAuthOnComplete(url, null);
                  if (context.mounted) {
                    context.pop(); // TODO: go to tasks page or whatever
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
