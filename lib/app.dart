part of carp_study_app;

class CARPStudyAppHome extends StatefulWidget {
  CARPStudyAppHome({Key key}) : super(key: key);
  CARPStudyAppState createState() => CARPStudyAppState();
}

class CARPStudyAppState extends State<CARPStudyAppHome> {
  int _selectedIndex = 0;
  final _pages = [];

  void initState() {
    super.initState();
    bloc.init();

    _pages.add(TaskList(bloc.data.taskListPageModel));
    _pages.add(StudyVisualization(bloc.data.studyPageModel));
    _pages.add(DataVisualization(bloc.data.dataPageModel));
  }

  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_outlined),
            label: 'Tasks',
            activeIcon: Icon(Icons.playlist_add_check),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement_outlined),
              label: 'About',
              activeIcon: Icon(Icons.announcement)),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: 'Data',
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
