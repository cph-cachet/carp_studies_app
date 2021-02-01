part of carp_study_app;

class AudioDonePage extends StatefulWidget {
  @override
  _AudioDonePageState createState() => _AudioDonePageState();
}

class _AudioDonePageState extends State<AudioDonePage> {
  int _currentStep = 3;
  List<int> steps = [0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            AudioTaskHeader(_currentStep, steps),
            Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
            Text("Done!", style: aboutCardTitleStyle),
            SizedBox(height: 10),
            Text(
                "Recording completed. Press the green button to save this recording.\nIf you want to start over the recording press the button in the left.",
                style: aboutCardContentStyle),
            _done(),
          ],
        ),
      ),
    );
  }

  Widget _done() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  print('restart recording');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AudioRecordingPage();
                    }),
                  );
                },
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.replay, size: 25),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: CACHET.GREEN_1,
                child: IconButton(
                  onPressed: () {
                    print("done");
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
                ),
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
