part of carp_study_app;

class AudioTaskPage extends StatefulWidget {
  @override
  _AudioTaskPageState createState() => _AudioTaskPageState();
}

class _AudioTaskPageState extends State<AudioTaskPage> {
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
            _header(),
            SizedBox(height: 35),
            Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
            SizedBox(height: 55),
            _title(),
            SizedBox(height: 10),
            _description(),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    // TODO: Change header depending on the task state instead of the step
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Help',
          onPressed: () {
            print("Help");
            // TODO: show help
          },
        ),
        //Carousel
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: steps.asMap().entries.map(
              (step) {
                var index = step.value;
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= _currentStep
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.5)),
                );
              },
            ).toList(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Close',
          onPressed: () {
            print("close");
            // TODO: cancelation confirmation?
          },
        ),
      ],
    );
  }

  Widget _title() {
    // TODO: Change title depending on the task state instead of the step
    if (_currentStep == 0)
      return Text("This is the title", style: audioTitleStyle); //task title
    else if (_currentStep == 1)
      return Text("Recording...", style: audioTitleStyle);
    else if (_currentStep == 2)
      return Text("Done!", style: audioTitleStyle);
    else
      return (SizedBox.shrink());
  }

  Widget _description() {
    // TODO: Change title depending on the task state instead of the step
    if (_currentStep == 0)
      return Text("This is the description", style: audioDescriptionStyle); //task description
    else if (_currentStep == 1)
      return Text("This are the instructions", style: audioContentStyle); // task instructions
    else if (_currentStep == 2)
      return Text(
          "Recording completed. Press the green button to save this recording.\nIf you want to start over the recording press the button in the left.",
          style: audioDescriptionStyle);
    else
      return (SizedBox.shrink());
  }

  Widget _button() {
    if (_currentStep == 0)
      return _record(); //task description
    else if (_currentStep == 1)
      return _recording(); // task instructions
    else if (_currentStep == 2)
      return _done();
    else
      return (SizedBox.shrink());
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
                // TODO: change task state to start
                setState(() {
                  _currentStep = 1;
                });
              },
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.mic, color: Colors.white, size: 40),
            ),
          ),
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
                    // TODO: change task state to done
                    setState(() {
                      _currentStep = 2;
                    });
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

  Widget _done() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  print('restart recording');
                  // TODO: change task state to start
                  setState(() {
                    _currentStep = 1;
                  });
                },
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.replay, size: 25, color: CACHET.GREY_5),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: CACHET.GREEN_1,
                child: IconButton(
                  onPressed: () {
                    print("done");
                    // TODO: save
                    // TODO: change task state to done
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
                ),
              ),
              SizedBox(width: 30),
              SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
