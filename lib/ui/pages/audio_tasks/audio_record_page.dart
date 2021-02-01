part of carp_study_app;

class AudioRecordPage extends StatefulWidget {
  @override
  _AudioRecordPageState createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  int _currentStep = 0;
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
            Text("Cough recording", style: aboutCardTitleStyle),
            SizedBox(height: 10),
            Text(
                "In this small exercise we would like to collect sound samples of coughing.\nFor a correct recording hold your phone close to your mouth and press the red button. Once the recording has started, please cough five times.",
                style: aboutCardContentStyle),
            _record(),
          ],
        ),
      ),
    );
  }

  Widget _record() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: CACHET.RED_1,
            child: IconButton(
              onPressed: () {
                print("start recording");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AudioRecordingPage();
                  }),
                );
              },
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.mic, color: Colors.white, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
