part of carp_study_app;

class HomePage extends StatelessWidget {
  const HomePage({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    Sensing().translateStudyProtocol(locale);

    return Scaffold(
      body: child,
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
      return 3;
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
}
