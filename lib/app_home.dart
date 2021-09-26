part of carp_study_app;

class CarpStudyAppHome extends StatefulWidget {
  CarpStudyAppHome({Key? key}) : super(key: key);
  CARPStudyAppState createState() => CARPStudyAppState();
}

class CARPStudyAppState extends State<CarpStudyAppHome> {
  // when the app starts, show the task list (index =0) since the app may have
  // been started due to the user selecting a notification
  int _selectedIndex = 0;
  final _pages = [];

  void initState() {
    super.initState();

    // start the sensing
    bloc.start();

    _pages.add(TaskListPage(bloc.data.taskListPageModel));
    _pages.add(StudyPage(bloc.data.studyPageModel));
    //_pages.add(TimerTaskPage());
    _pages.add(DataVisualizationPage(bloc.data.dataPageModel));
  }

  void dispose() {
    bloc.dispose();
    super.dispose();
  }

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
