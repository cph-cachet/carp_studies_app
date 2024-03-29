part of carp_study_app;

class DisplayPicturePage extends StatefulWidget {
  final XFile file;
  final bool isVideo;
  final VideoUserTask videoUserTask;

  const DisplayPicturePage(
      {super.key,
      required this.file,
      required this.videoUserTask,
      this.isVideo = false});

  @override
  State<DisplayPicturePage> createState() => DisplayPicturePageState();
}

class DisplayPicturePageState extends State<DisplayPicturePage> {
  VideoPlayerController? _videoPlayerController;

  /// The path of the video file which has been recorded in the [CameraPage].
  String get videoFilePath => widget.file.path;

  @override
  void initState() {
    super.initState();

    // initialize video player controller
    _videoPlayerController = VideoPlayerController.file(File(videoFilePath))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController?.setLooping(true);
        _videoPlayerController?.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            //SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: (widget.isVideo && _videoPlayerController != null)
                      ? _videoPlayerController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!))
                          : const CircularProgressIndicator()
                      : Image.file(File(videoFilePath)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(locale.translate('pages.audio_task.done'),
                          style: audioTitleStyle),
                      const SizedBox(height: 40),
                      Text(
                          locale.translate(
                              'pages.audio_task.recording_completed'),
                          style: audioContentStyle),
                      const SizedBox(height: 20),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 30),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                padding: const EdgeInsets.all(0),
                                icon: const Icon(Icons.replay,
                                    size: 25, color: CACHET.GREY_5),
                              ),
                              const SizedBox(width: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: CACHET.GREEN_1,
                                child: IconButton(
                                  onPressed: () {
                                    widget.videoUserTask.onSave();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
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
      ),
    );
  }

  // Taken from RP
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
              onPressed: () => Navigator.of(context).pop(),
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
