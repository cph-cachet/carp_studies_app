part of carp_study_app;

class DisplayPicturePage extends StatefulWidget {
  final XFile file;
  final bool isVideo;
  final VideoUserTask videoUserTask;

  const DisplayPicturePage({Key? key, required this.file, required this.videoUserTask, this.isVideo = false})
      : super(key: key);

  @override
  State<DisplayPicturePage> createState() => _DisplayPicturePageState();
}

class _DisplayPicturePageState extends State<DisplayPicturePage> {
  late VideoPlayerController _videoPlayerController; // To control video player
  // @override
  // void initState() async {
  //   super.initState();
  //   await _videoPlayerController.initialize();
  // }

  initializeVideoPLayer(String path) async {
    _videoPlayerController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
      });
  }

  @override
  void initState() {
    super.initState();
    initializeVideoPLayer(widget.file.path);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
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
          //SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                child: widget.isVideo
                    ? _videoPlayerController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController))
                        : CircularProgressIndicator()
                    : Image.file(File(widget.file.path)),
              ),
            ),
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // Text(locale.translate("Done!"), style: audioTitleStyle),
                // SizedBox(height: 10),
                //Text(locale.translate('pages.audio_task.recording_completed'), style: audioContentStyle),
                Text("Recording completed"),
                SizedBox(height: 20),

                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 30),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.replay, size: 25, color: CACHET.GREY_5),
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: CACHET.GREEN_1,
                          child: IconButton(
                            onPressed: () {
                              widget.videoUserTask.onSave();

                              widget.videoUserTask.onDone(context);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
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
              ])
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     TextButton.icon(
              //       icon: Icon(Icons.replay, color: Colors.white),
              //       label: Text("RETAKE"),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       style: TextButton.styleFrom(
              //         primary: Colors.white,
              //         side: BorderSide(color: Colors.white),
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     TextButton(
              //       child: Text("SAVE"),
              //       onPressed: () {
              //         widget.videoUserTask.onSave();

              //         widget.videoUserTask.onDone(context);
              //         Navigator.of(context).pop();
              //         Navigator.of(context).pop();
              //         Navigator.of(context).pop();

              //         // TODO: connect with video task
              //         //widget.videoUserTask.file = widget.file;
              //       },
              //       style: TextButton.styleFrom(
              //         primary: Theme.of(context).primaryColor,
              //         backgroundColor: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              ),
        ],
      ),
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
                // widget.videoUserTask.(context);
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
