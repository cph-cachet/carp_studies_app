part of carp_study_app;

class CameraTaskPage extends StatefulWidget {
  final VideoUserTask videoUserTask;
  final List<CameraDescription> cameras;

  CameraTaskPage({Key? key, required this.videoUserTask, required this.cameras}) : super(key: key);

  @override
  _CameraTaskPageState createState() => _CameraTaskPageState();
}

class _CameraTaskPageState extends State<CameraTaskPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: (() async => _showCancelConfirmationDialog() as FutureOr<bool>),
      child: Scaffold(
        body: Container(padding: EdgeInsets.symmetric(horizontal: 15), child: _stepSelector()),
      ),
    );
  }

  Widget _stepSelector() {
    return StreamBuilder<UserTaskState>(
        stream: widget.videoUserTask.stateEvents,
        initialData: UserTaskState.enqueued,
        builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
          switch (snapshot.data) {
            case UserTaskState.enqueued:
              return _stepOne();

            default:
              return SizedBox.shrink();
          }
        });
  }

  Widget _stepOne() {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return StreamBuilder<UserTaskState>(
      stream: widget.videoUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      _showCancelConfirmationDialog();
                    },
                    icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30))
              ],
            ),
            SizedBox(height: 35),
            Image(image: AssetImage('assets/icons/camera.png'), width: 220, height: 220),
            SizedBox(height: 40),
            Text(locale.translate(widget.videoUserTask.title), style: audioTitleStyle),
            SizedBox(height: 10),
            Text(locale.translate(widget.videoUserTask.description), style: audioContentStyle),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 50),
                      SizedBox(width: 30),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: CACHET.RED_1,
                        child: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CameraPage(videoUserTask: widget.videoUserTask, cameras: widget.cameras),
                            ),
                          ),
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                        ),
                      ),
                      InkWell(
                        child: Text(
                          locale.translate("pages.audio_task.skip"),
                          style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        onTap: () {
                          widget.videoUserTask.onDone(context);
                          //audioUserTask!.onCancel(context);
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 30),
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

// Taken from RP
  Future _showCancelConfirmationDialog() {
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
              onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            TextButton(
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
