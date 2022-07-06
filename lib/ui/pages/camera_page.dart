part of carp_study_app;

class CameraPage extends StatefulWidget {
  final VideoUserTask videoUserTask;
  final List<CameraDescription> cameras;

  CameraPage({Key? key, required this.videoUserTask, required this.cameras})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    // initially selectedCamera = 0 (external camera)
    initializeCamera(selectedCamera);
    super.initState();
  }

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  int selectedCamera = 0;
  IconData flashIcon = Icons.flash_off;
  bool isFlashOff = true;
  late File capturedImages;
  bool isRecording = false;
  // bool _imageEnabled = videoUserTask;
  // late bool _videoEnabled;

  initializeCamera(int cameraIndex) async {
    _cameraController = CameraController(
        widget.cameras[cameraIndex], ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: true);

    _initializeControllerFuture = _cameraController.initialize();
    _cameraController.setFocusMode(FocusMode.auto);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  icon: Icon(Icons.close, color: Colors.white, size: 30))
            ],
          ),
          SizedBox(height: 35),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                          child: CameraPreview(_cameraController),
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9)),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    if (widget.cameras.length > 1) {
                      setState(() {
                        selectedCamera = selectedCamera == 0 ? 1 : 0;
                        initializeCamera(selectedCamera);
                      });
                    }
                  },
                  icon: Icon(Icons.flip_camera_android, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () async {
                    await _initializeControllerFuture;
                    var xFile = await _cameraController.takePicture();
                    widget.videoUserTask.onPictureCapture(xFile);
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPicturePage(
                            file: xFile, videoUserTask: widget.videoUserTask),
                      ),
                    );

                    setState(() {
                      capturedImages = File(xFile.path);
                    });
                  },
                  onLongPress: () async {
                    await _initializeControllerFuture;

                    try {
                      await _cameraController.startVideoRecording();
                      widget.videoUserTask.onRecordStart();
                      setState(() {
                        isRecording = true;
                      });
                    } on CameraException catch (e) {
                      print('Error: ${e.code}\n${e.description}');
                    }
                  },
                  onLongPressEnd: (details) async {
                    try {
                      var xFile = await _cameraController.stopVideoRecording();

                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DisplayPicturePage(
                                file: xFile,
                                isVideo: true,
                                videoUserTask: widget.videoUserTask)),
                      );
                      widget.videoUserTask.onRecordStop(xFile);
                      setState(() {
                        capturedImages = File(xFile.path);
                        isRecording = false;
                      });
                    } on CameraException catch (e) {
                      print('Error: ${e.code}\n${e.description}');
                    }
                  },
                  child: isRecording
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 65,
                              height: 65,
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white54,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.black54),
                                  strokeWidth: 5),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ],
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    if (isFlashOff) {
                      setState(() {
                        isFlashOff = false;
                        flashIcon = Icons.flash_on;
                      });
                      _cameraController.setFlashMode(FlashMode.always);
                    } else {
                      setState(() {
                        isFlashOff = true;
                        flashIcon = Icons.flash_off;
                      });
                      _cameraController.setFlashMode(FlashMode.off);
                    }
                  },
                  icon: Icon(flashIcon, color: Colors.white),
                ),
              ],
            ),
          ),
          Spacer(),
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
              onPressed: () =>
                  Navigator.of(context).pop(), // Dismissing the pop-up
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
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
