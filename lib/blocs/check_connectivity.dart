part of carp_study_app;

class ConnectivityPlus {
  Future<bool> checkConnectivity() async {
    final ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }
}
