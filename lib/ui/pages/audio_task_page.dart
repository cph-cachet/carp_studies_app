part of carp_study_app;

class AudioTaskPage extends StatefulWidget {
  final AudioUserTask audioUserTask;
  AudioTaskPage({Key key, this.audioUserTask}) : super(key: key);

  @override
  _AudioTaskPageState createState() => _AudioTaskPageState(audioUserTask);
}

class _AudioTaskPageState extends State<AudioTaskPage> {
  final AudioUserTask audioUserTask;

  int get _currentStep {
    switch (audioUserTask.state) {
      case UserTaskState.started:
        return 1;
      case UserTaskState.done:
        return 2;
      default:
        return 0;
    }
  }

  List<int> steps = [0, 1, 2];

  _AudioTaskPageState(this.audioUserTask) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: _stepSelector(),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.help_outline,
              color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Help',
          onPressed: () {
            print("Help");
            // TODO: show help
          },
        ),
        //Carousel
        Expanded(
            flex: 2,
            child: StreamBuilder<UserTaskState>(
              stream: audioUserTask.stateEvents,
              builder: (context, AsyncSnapshot<UserTaskState> snapshot) => Row(
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
                              : Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)),
                    );
                  },
                ).toList(),
              ),
            )),
        IconButton(
          icon: Icon(Icons.close,
              color: Theme.of(context).primaryColor, size: 30),
          tooltip: 'Close',
          onPressed: () {
            print("close");
            // TODO: close confirmation
          },
        ),
      ],
    );
  }

  Widget _stepSelector() {
    if (_currentStep == 0)
      return _stepOne(); //task description
    else if (_currentStep == 1)
      return _stepTwo(); // task instructions
    else if (_currentStep == 2)
      return _stepThree();
    else
      return (SizedBox.shrink());
  }

  Widget _stepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 35),
        _header(),
        SizedBox(height: 35),
        Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
        SizedBox(height: 40),
        Text("This is the title", style: audioTitleStyle),
        SizedBox(height: 10),
        Text("This is the description", style: audioDescriptionStyle),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
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
                  icon: Icon(Icons.mic, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _stepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 35),
        _header(),
        SizedBox(height: 35),
        Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
        SizedBox(height: 40),
        Text("Recording...", style: audioTitleStyle),
        SizedBox(height: 10),
        // TODO: put here instruccions
        Text("This are the instructions", style: audioContentStyle),
        SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // TODO: put here extra instruccions
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac pellentesque nibh. Nam eget libero sit amet ex tempus ultrices. Maecenas nisi ligula, aliquam a ullamcorper id, auctor eu ipsum. Sed tristique sapien sed nisl bibendum facilisis. Suspendisse ut elit lobortis, commodo sem in, molestie augue. Donec non magna eu odio accumsan tincidunt. Quisque a tellus ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac pellentesque nibh. Nam eget libero sit amet ex tempus ultrices. Maecenas nisi ligula, aliquam a ullamcorper id, auctor eu ipsum. Sed tristique sapien sed nisl bibendum facilisis. Suspendisse ut elit lobortis, commodo sem in, molestie augue. Donec non magna eu odio accumsan tincidunt. Quisque a tellus ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ac pellentesque nibh. Nam eget libero sit amet ex tempus ultrices. Maecenas nisi ligula, aliquam a ullamcorper id, auctor eu ipsum. Sed tristique sapien sed nisl bibendum facilisis. Suspendisse ut elit lobortis, commodo sem in, molestie augue. Donec non magna eu odio accumsan tincidunt. Quisque a tellus ligula. ",
                      style: audioInstructionStyle),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      backgroundColor: CACHET.RED_3,
                      valueColor: AlwaysStoppedAnimation(CACHET.RED_2),
                      strokeWidth: 10,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
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
                      icon: Icon(Icons.stop, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _stepThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 35),
        _header(),
        SizedBox(height: 35),
        Image(image: AssetImage('assets/images/audio.png'), width: 220, height: 220),
        SizedBox(height: 40),
        Text("Done!", style: audioTitleStyle),
        SizedBox(height: 10),
        Text(
            "Recording completed. Press the green button to save this recording.\nIf you want to start over the recording press the button in the left.",
            style: audioDescriptionStyle),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
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
                      icon: Icon(Icons.check_circle_outline, color: Colors.white, size: 30),
                    ),
                  ),
                  SizedBox(width: 50),
                  SizedBox(width: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
