part of carp_study_app;

class AudioTaskPage extends StatefulWidget {
  final AudioUserTask? audioUserTask;
  const AudioTaskPage({super.key, this.audioUserTask});

  @override
  AudioTaskPageState createState() => AudioTaskPageState();
}

class AudioTaskPageState extends State<AudioTaskPage> {
  List<int> steps = [0, 1, 2];

  int get _currentStep => switch (widget.audioUserTask!.state) {
        UserTaskState.started => 1,
        UserTaskState.done => 2,
        _ => 0
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: PopScope(
            canPop: true,
            child: Scaffold(
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _stepSelector(),
              ),
            ),
          ),
        ),
      );

  Widget _stepSelector() => StreamBuilder<UserTaskState>(
      stream: widget.audioUserTask!.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) =>
          switch (snapshot.data) {
            UserTaskState.enqueued => _stepOne(),
            UserTaskState.started => _stepTwo(),
            UserTaskState.done => _stepThree(),
            _ => const SizedBox.shrink(),
          });

  Widget _header() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.help_outline,
              color: Theme.of(context).primaryColor, size: 30),
          tooltip: locale.translate('Help'),
          onPressed: () {
            // TODO: show help
          },
        ),
        //Carousel
        Expanded(
            flex: 2,
            child: StreamBuilder<UserTaskState>(
              stream: widget.audioUserTask!.stateEvents,
              builder: (context, AsyncSnapshot<UserTaskState> snapshot) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: steps.asMap().entries.map(
                  (step) {
                    var index = step.value;
                    return Container(
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index <= _currentStep
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.5)),
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
            _showCancelConfirmationDialog();
          },
        ),
      ],
    );
  }

  Widget _stepOne() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StreamBuilder<UserTaskState>(
      stream: widget.audioUserTask!.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            _header(),
            const SizedBox(height: 35),
            const Image(
                image: AssetImage('assets/icons/audio.png'),
                width: 220,
                height: 220),
            const SizedBox(height: 40),
            Text(locale.translate(widget.audioUserTask!.title),
                style: audioTitleStyle),
            const SizedBox(height: 10),
            Text(
                '${locale.translate(widget.audioUserTask!.description)}\n\n${locale.translate('pages.audio_task.play')}',
                style: audioContentStyle),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 50),
                      const SizedBox(width: 30),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: CACHET.RED_1,
                        child: IconButton(
                          onPressed: () =>
                              widget.audioUserTask!.onRecordStart(),
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.mic,
                              color: Colors.white, size: 30),
                        ),
                      ),
                      InkWell(
                        child: Text(
                          locale.translate("pages.audio_task.skip"),
                          style: aboutCardTitleStyle.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                        onTap: () {
                          widget.audioUserTask?.onCancel();
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 30),
                    ],
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
    RPLocalizations locale = RPLocalizations.of(context)!;

    // TODO: split the instructions in the model instead of here
    return StreamBuilder<UserTaskState>(
      stream: widget.audioUserTask!.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 35),
            _header(),
            const SizedBox(height: 35),
            const Image(
                image: AssetImage('assets/icons/audio.png'),
                width: 220,
                height: 220),
            const SizedBox(height: 40),
            Text(locale.translate("pages.audio_task.recording"),
                style: audioTitleStyle),
            const SizedBox(height: 10),
            // If instructions are too long, create scrollable card for the extra instructions
            // TODO - the layout method below is prone to be creating problems / exceptions....
            //  - if, for example, the widget.audioUserTask.instructions is a key (with no \n\n)
            //  - or if there is no \n\n
            // IMO we need another solution, which does not rely on assuming \n\n to be in the text
            // Text(locale.translate(widget.audioUserTask!.instructions).split('\n\n')[0], style: audioContentStyle),
            // SizedBox(height: 10),
            // widget.audioUserTask!.instructions.split('\n\n').length >= 1
            //     ?
            Expanded(
              flex: 3,
              child: StudiesMaterial(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          locale.translate(widget.audioUserTask!.instructions),
                          style: audioInstructionStyle),
                    ),
                  ),
                ),
              ),
            )
            // : SizedBox.shrink(),
            ,
            const SizedBox(height: 5),
            Expanded(
              flex: 2,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const SizedBox(
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
                          onPressed: () => widget.audioUserTask!.onRecordStop(),
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.stop,
                              color: Colors.white, size: 30),
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
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StreamBuilder<UserTaskState>(
      stream: widget.audioUserTask!.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 35),
            _header(),
            const SizedBox(height: 35),
            const Image(
                image: AssetImage('assets/icons/audio.png'),
                width: 220,
                height: 220),
            const SizedBox(height: 40),
            Text(locale.translate('pages.audio_task.done'),
                style: audioTitleStyle),
            const SizedBox(height: 10),
            Text(locale.translate('pages.audio_task.recording_completed'),
                style: audioContentStyle),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 30),
                      IconButton(
                        onPressed: () => widget.audioUserTask?.onRecordStart(),
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.replay,
                            size: 25, color: CACHET.GREY_5),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: CACHET.GREEN_1,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 30),
                        ),
                      ),
                      const SizedBox(width: 50),
                      const SizedBox(width: 30),
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

  Future<void> _showCancelConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.translate("pages.audio_task.discard")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () {}, // Dismissing the pop-up
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                context.pushReplacement(CarpStudyAppState.homeRoute);
              },
            )
          ],
        );
      },
    );
  }
}
