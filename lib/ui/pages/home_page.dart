part of carp_study_app;

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // at this point, the study deployment AND the translations are loaded
    // this means that we can translate the [AppTask]s in the protocol,
    // if we want the translated title and description to be in the notifications.
    var locale = RPLocalizations.of(context)!;
    Sensing().translateStudyProtocol(locale);
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        //unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.8),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.playlist_add_check),
            label: locale.translate('app_home.nav_bar_item.tasks'),
            activeIcon: const Icon(Icons.playlist_add_check),
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.announcement_outlined),
              label: locale.translate('app_home.nav_bar_item.about'),
              activeIcon: const Icon(Icons.announcement)),
          BottomNavigationBarItem(
              icon: const Icon(Icons.leaderboard_outlined),
              label: locale.translate('app_home.nav_bar_item.data'),
              activeIcon: const Icon(Icons.leaderboard)),
          BottomNavigationBarItem(
              icon: const Icon(Icons.devices_other_outlined),
              label: locale.translate('app_home.nav_bar_item.devices'),
              activeIcon: const Icon(Icons.devices_other)),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/tasks')) {
      return 0;
    }
    if (location.startsWith('/about')) {
      return 1;
    }
    if (location.startsWith('/data')) {
      return 2;
    }
    if (location.startsWith('/devices')) {
      return 2;
    }
    return -1;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/tasks');
        break;
      case 1:
        context.go('/about');
        break;
      case 2:
        context.go('/data');
        break;
      case 3:
        context.go('/devices');
        break;
      case -1:
        context.go('/');
        break;
    }
  }

  // void _restart() {
  //   setState(() {
  //     if (bloc.isRunning)
  //       bloc.pause();
  //     else
  //       bloc.resume();
  //   });
  // }
}
