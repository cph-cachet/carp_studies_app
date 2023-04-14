part of carp_study_app;

class LoginPageViewModel extends ViewModel {
  WebAuthenticationSession? loginSession;
  WebAuthenticationSession? registerSession;

  LoginPageViewModel();

  Future<void> iOSAuthentication(WebAuthenticationSession? session) async {
    if (session != null && await session.canStart()) {
      session = await startWebAuthenticationSession(session);
      info("Session is not null, starting session. Session is $session");
    } else if (session != null) {
      info("Session is $session. Recreating.");
      session = null;
      session =
          await createWebAuthenticationSession(session, bloc.backend.loginUri);
      session = await startWebAuthenticationSession(session!);
    }
    if (session == null) {
      info("Session is null, creating.");
      session =
          await createWebAuthenticationSession(session, bloc.backend.loginUri);
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
}
