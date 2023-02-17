part of carp_study_app;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = [];

  @override
  void initState() {
    super.initState();

    // check for permissions and start sensing - with a small delay
    bloc.configurePermissions(context).then(
        (_) => Future.delayed(const Duration(seconds: 10), () => bloc.start()));

    _pages.add(TaskListPage(bloc.data.taskListPageViewModel));
    _pages.add(StudyPage(bloc.data.studyPageViewModel));
    _pages.add(DataVisualizationPage(bloc.data.dataVisualizationPageViewModel));
    _pages.add(const DevicesPage());
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/LoginPage'),
      ),
      body: _pages[_selectedIndex],
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _restart,
      //   tooltip: 'Restart study & probes',
      //   child: bloc.isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      // ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
