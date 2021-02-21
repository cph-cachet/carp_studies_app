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
    return WillPopScope(
      onWillPop: () async => _showCancelConfirmationDialog(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _stepSelector(),
        ),
      ),
    );
  }

  Widget _header() {
    RPLocalizations locale = RPLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.help_outline,
              color: Theme.of(context).primaryColor, size: 30),
          tooltip: locale.translate('Help'),
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
          tooltip: locale.translate('Close'),
          onPressed: () {
            print("close");
            _showCancelConfirmationDialog();
            // TODO: close confirmation
          },
        ),
      ],
    );
  }

  Widget _stepSelector() {
    return StreamBuilder<UserTaskState>(
        stream: audioUserTask.stateEvents,
        initialData: UserTaskState.enqueued,
        builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
          switch (snapshot.data) {
            case UserTaskState.enqueued:
              return _stepOne();
            case UserTaskState.started:
              return _stepTwo();
            case UserTaskState.done:
              return _stepThree();
            default:
              return SizedBox.shrink();
          }
        });
  }

  Widget _stepOne() {
    RPLocalizations locale = RPLocalizations.of(context);

    return StreamBuilder<UserTaskState>(
      stream: audioUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            _header(),
            SizedBox(height: 35),
            Image(
                image: AssetImage('assets/images/audio.png'),
                width: 220,
                height: 220),
            SizedBox(height: 40),
            Text(audioUserTask.title, style: audioTitleStyle),
            SizedBox(height: 10),
            Text(
                '${audioUserTask.description}\n\n' +
                    locale
                        .translate('Please press the button below when ready.'),
                style: audioDescriptionStyle),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: CACHET.RED_1,
                    child: IconButton(
                      onPressed: () => audioUserTask.onRecordStart(),
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.mic, color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _stepTwo() {
    RPLocalizations locale = RPLocalizations.of(context);

    // TODO: split the instructions in the model instead of here
    return StreamBuilder<UserTaskState>(
      stream: audioUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            _header(),
            SizedBox(height: 35),
            Image(
                image: AssetImage('assets/images/audio.png'),
                width: 220,
                height: 220),
            SizedBox(height: 40),
            Text(locale.translate("Recording..."), style: audioTitleStyle),
            SizedBox(height: 10),
            // If instructions are too long, create scrollable card for the extra instructions
            Text(audioUserTask.instructions.split('\n\n')[0],
                style: audioContentStyle),
            SizedBox(height: 10),
            audioUserTask.instructions.split('\n\n').length > 1
                ? Expanded(
                    flex: 3,
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
                            child: Text(
                                audioUserTask.instructions.split('\n\n')[1],
                                style: audioInstructionStyle),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 5),
            Expanded(
              flex: 2,
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
                          onPressed: () => audioUserTask.onRecordStop(),
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
      },
    );
  }

  Widget _stepThree() {
    RPLocalizations locale = RPLocalizations.of(context);

    return StreamBuilder<UserTaskState>(
      stream: audioUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            _header(),
            SizedBox(height: 35),
            Image(
                image: AssetImage('assets/images/audio.png'),
                width: 220,
                height: 220),
            SizedBox(height: 40),
            Text(locale.translate("Done!"), style: audioTitleStyle),
            SizedBox(height: 10),
            Text(
                locale.translate(
                    'Recording completed. Press the green button to save this recording.\n\nIf you want to redo the recording, then press the button on the left.'),
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
                        onPressed: () => audioUserTask.onRecordStart(),
                        padding: EdgeInsets.all(0),
                        icon:
                            Icon(Icons.replay, size: 25, color: CACHET.GREY_5),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: CACHET.GREEN_1,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 30),
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
      },
    );
  }

  // Taken from RP
  Future _showCancelConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.translate("Discard results and quit?")),
          actions: <Widget>[
            FlatButton(
              child: Text(locale.translate("NO")),
              onPressed: () =>
                  Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            FlatButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
