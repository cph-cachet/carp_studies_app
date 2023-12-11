part of '../../main.dart';

class CameraTaskPage extends StatefulWidget {
  final VideoUserTask mediaUserTask;

  const CameraTaskPage({
    super.key,
    required this.mediaUserTask,
  });

  @override
  CameraTaskPageState createState() => CameraTaskPageState();
}

class CameraTaskPageState extends State<CameraTaskPage> {
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: (() async =>
            _showCancelConfirmationDialog() as FutureOr<bool>),
        child: Scaffold(
          body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _stepSelector()),
        ),
      );

  Widget _stepSelector() => StreamBuilder<UserTaskState>(
      stream: widget.mediaUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        switch (snapshot.data) {
          case UserTaskState.enqueued:
            return _stepOne();
          default:
            return const SizedBox.shrink();
        }
      });

  Widget _stepOne() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return StreamBuilder<UserTaskState>(
      stream: widget.mediaUserTask.stateEvents,
      initialData: UserTaskState.enqueued,
      builder: (context, AsyncSnapshot<UserTaskState> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      _showCancelConfirmationDialog();
                    },
                    icon: Icon(Icons.close,
                        color: Theme.of(context).primaryColor, size: 30))
              ],
            ),
            const SizedBox(height: 35),
            const Image(
                image: AssetImage('assets/icons/camera.png'),
                width: 220,
                height: 220),
            const SizedBox(height: 40),
            Text(locale.translate(widget.mediaUserTask.title),
                style: audioTitleStyle),
            const SizedBox(height: 10),
            Text(locale.translate(widget.mediaUserTask.description),
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraPage(
                                videoUserTask: widget.mediaUserTask,
                                // cameras: widget.mediaUserTask.cameras,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.camera_alt,
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
                          widget.mediaUserTask.onDone();
                          context.pop();
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
              onPressed: () => context.pop(), // Dismissing the pop-up
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                // Popup dismiss
                context.pop();
                // Exit the Ordered Task
                context.canPop() ? context.pop() : null;
              },
            )
          ],
        );
      },
    );
  }
}
