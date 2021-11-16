part of carp_study_app;

class HomePage extends StatefulWidget {
  final HomePageState state = HomePageState();
  HomePage({Key? key}) : super(key: key);
  HomePageState createState() => state;
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pages = [];

  @override
  void initState() {
    super.initState();

    print('$runtimeType - initState()');

    // check for permissions and start sensing - with a small delay
    bloc.configurePermissions(context).then(
        (_) => Future.delayed(const Duration(seconds: 3), () => bloc.start()));

    _pages.add(TaskListPage(bloc.data.taskListPageModel));
    _pages.add(StudyPage(bloc.data.studyPageModel));
    _pages.add(DataVisualizationPage(bloc.data.dataPageModel));
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_outlined),
            label: locale.translate('app_home.nav_bar_item.tasks'),
            activeIcon: Icon(Icons.playlist_add_check),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement_outlined),
              label: locale.translate('app_home.nav_bar_item.about'),
              activeIcon: Icon(Icons.announcement)),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: locale.translate('app_home.nav_bar_item.data'),
              activeIcon: Icon(Icons.leaderboard)),
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

  void _restart() {
    setState(() {
      if (bloc.isRunning)
        bloc.pause();
      else
        bloc.resume();
    });
  }
}
