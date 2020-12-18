part of carp_study_app;

class CARPStudyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: carpStudyTheme,
      home: CARPStudyAppHome(key: key),
    );
  }
}

class CARPStudyAppHome extends StatefulWidget {
  CARPStudyAppHome({Key key}) : super(key: key);

  CARPStudyAppState createState() => CARPStudyAppState();
}

class CARPStudyAppState extends State<CARPStudyAppHome> {
  int _selectedIndex = 0;

  final _pages = [
    TaskList(),
    StudyVisualization(),
    DataVisualization(),
  ];

  void initState() {
    super.initState();
    settings.init();
    bloc.init();
  }

  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.new_releases_outlined), label: 'Tasks', activeIcon: Icon(Icons.new_releases)),
          BottomNavigationBarItem(icon: Icon(Icons.announcement_outlined), label: 'About', activeIcon: Icon(Icons.announcement)),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), label: 'Data', activeIcon: Icon(Icons.leaderboard)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _restart,
        tooltip: 'Restart study',
        child: bloc.isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
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
