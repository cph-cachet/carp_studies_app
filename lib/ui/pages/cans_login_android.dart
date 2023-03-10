part of carp_study_app;

class LoginPageAndroid extends StatefulWidget {
  const LoginPageAndroid({super.key});

  @override
  State<LoginPageAndroid> createState() => _LoginPageAndroidState();
}

class _LoginPageAndroidState extends State<LoginPageAndroid> {
  InAppWebViewController? webView;

  WebUri uri = WebUri(
      'https://cans.cachet.dk/portal/playground/login?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/login?redirect=carp.studies://auth');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: uri),
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
