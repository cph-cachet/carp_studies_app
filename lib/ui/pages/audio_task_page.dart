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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35),
            _header(),
            SizedBox(height: 35),
            Image(
                image: AssetImage('assets/images/audio.png'),
                width: 220,
                height: 220),
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
            // TODO: cancelation confirmation?
          },
        ),
      ],
    );
  }

  Widget _title() {
    return StreamBuilder<UserTaskState>(
        stream: audioUserTask.stateEvents,
        initialData: UserTaskState.enqueued,
        builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
          print('snapshot :: $snapshot');
          switch (snapshot.data) {
            case UserTaskState.enqueued:
              return Text(audioUserTask.title, style: audioTitleStyle);
            case UserTaskState.started:
              return Text('Recording...', style: audioTitleStyle);
            case UserTaskState.done:
              return Text('Done!', style: audioTitleStyle);
            default:
              return SizedBox.shrink();
          }
        });
  }

  Widget _description() {
    return StreamBuilder<UserTaskState>(
        stream: audioUserTask.stateEvents,
        initialData: UserTaskState.enqueued,
        builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
          print('snapshot :: $snapshot');
          switch (snapshot.data) {
            case UserTaskState.enqueued:
              return Text(
                  '${audioUserTask.description}\n\nPlease press the button below when ready.',
                  style: audioDescriptionStyle);
            case UserTaskState.started:
              return Text(audioUserTask.instructions, style: audioContentStyle);
            case UserTaskState.done:
              return Text(
                  'Recording completed. Press the green button to save this recording.\n\n'
                  'If you want to redo the recording the press the button on the left.',
                  style: audioDescriptionStyle);
            default:
              return Text('');
          }
        });
  }

  Widget _button() {
    return StreamBuilder<UserTaskState>(
        stream: audioUserTask.stateEvents,
        initialData: UserTaskState.enqueued,
        builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
          print('snapshot :: $snapshot');
          switch (snapshot.data) {
            case UserTaskState.enqueued:
              return _record();
            case UserTaskState.started:
              return _recording();
            case UserTaskState.done:
              return _done();
            default:
              return SizedBox.shrink();
          }
        });
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
                audioUserTask.onRecordStart();
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
                    audioUserTask.onRecordStop();
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
                  audioUserTask.onRecordStart();
                },
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.replay, size: 25, color: CACHET.GREY_5),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: CACHET.GREEN_1,
                child: IconButton(
                  onPressed: () {
                    print("recording done");
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.check_circle_outline,
                      color: Colors.white, size: 40),
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
