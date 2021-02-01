part of carp_study_app;

class AudioRecordingPage extends StatefulWidget {
  @override
  _AudioRecordingPageState createState() => _AudioRecordingPageState();
}

class _AudioRecordingPageState extends State<AudioRecordingPage> {
  int _currentStep = 1;
  List<int> steps = [0, 1, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            AudioTaskHeader(_currentStep, steps),
            Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
            Text("Recording...", style: aboutCardTitleStyle),
            _recording(),
          ],
        ),
      ),
    );
  }

  Widget _recording() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  backgroundColor: CACHET.RED_3,
                  valueColor: AlwaysStoppedAnimation(CACHET.RED_2),
                  strokeWidth: 10,
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: CACHET.RED_1,
                child: IconButton(
                  onPressed: () {
                    print("stop recording");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AudioDonePage();
                      }),
                    );
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.graphic_eq, color: Colors.white, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
