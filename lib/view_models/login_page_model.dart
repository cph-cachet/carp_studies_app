part of carp_study_app;

class LoginPageViewModel extends ViewModel {
  WebAuthenticationSession? loginSession;
  WebAuthenticationSession? registerSession;

  final WebUri _loginUri = WebUri(
      'https://cans.cachet.dk/portal/playground/?redirect=carp.studies://auth');
  get getLoginUri => _loginUri;

  final WebUri _registerUri = WebUri(
      'https://cans.cachet.dk/portal/playground/register?redirect=carp.studies://auth');
  // 'https://cans.cachet.dk/portal/${bloc.deploymentMode.name}/register?redirect=carp.studies://auth');
  get getRegisterUri => _registerUri;

  Future<void> iOSAuthentication(WebAuthenticationSession? session) async {
    if (session != null && await session.canStart()) {
      session = await startWebAuthenticationSession(session);
      info("Session is not null, starting session. Session is $session");
    } else if (session != null) {
      info("Session is $session. Recreating.");
      session = null;
      session = await createWebAuthenticationSession(session, _loginUri);
      session = await startWebAuthenticationSession(session!);
    }
    if (session == null) {
      info("Session is null, creating.");
      session = await createWebAuthenticationSession(session, _loginUri);
    }
  }

  Future<WebAuthenticationSession> startWebAuthenticationSession(
    WebAuthenticationSession session,
  ) async {
    await session.start();
    bloc.stateStream.sink.add(StudiesAppState.authenticating);

    return session;
  }

  Future<WebAuthenticationSession?> createWebAuthenticationSession(
    WebAuthenticationSession? session,
    WebUri url,
  ) async {
    if (session == null &&
        Platform.isIOS &&
        await WebAuthenticationSession.isAvailable()) {
      session = await WebAuthenticationSession.create(
          url: url,
          callbackURLScheme: 'carp.studies',
          onComplete: webAuthOnComplete);
      return session;
    }
    return session;
  }

  Future<void> webAuthOnComplete(url, error) async {
    if (error != null) {
      warning('Error: $error');
      return;
    } else if (url == null) {
      warning('No url returned');
      return;
    } else if (!url.toString().contains('token')) {
      warning('No access token in url: $url');
      return;
    }
    info('Got url: $url');
    String? refreshToken = url.queryParameters['token'];

    if (refreshToken == null) {
      warning('Missing parameters in url: $url');
      return;
    }

    await bloc.backend.authenticateWithRefreshToken(refreshToken);
  }

  LoginPageViewModel();
}
