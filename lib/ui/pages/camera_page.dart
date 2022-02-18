part of carp_study_app;

class CameraPage extends StatefulWidget {
  final VideoUserTask videoUserTask;
  final List<CameraDescription> cameras;

  CameraPage({Key? key, required this.videoUserTask, required this.cameras}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    initializeCamera(selectedCamera); //Initially selectedCamera = 0 (external camera)
    super.initState();
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int selectedCamera = 0;
  IconData flashIcon = Icons.flash_off;
  bool isFlashOff = true;
  List<File> capturedImages = [];
  bool isRecording = false;

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(widget.cameras[cameraIndex], ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: true);

    _initializeControllerFuture = _controller.initialize();
    _controller.setFocusMode(FocusMode.auto);
  }

  @override
  void dispose() {
    _controller.dispose();
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
                    // TODO: exit video task
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, color: Colors.white))
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
                    child: CameraPreview(_controller),
                  ),
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
                    var xFile = await _controller.takePicture();
                    widget.videoUserTask.onPictureCapture(xFile);
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DisplayPicturePage(file: xFile, videoUserTask: widget.videoUserTask),
                      ),
                    );

                    setState(() {
                      capturedImages.add(File(xFile.path));
                    });
                  },
                  onLongPress: () async {
                    await _initializeControllerFuture;

                    try {
                      await _controller.startVideoRecording();
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
                      var xFile = await _controller.stopVideoRecording();

                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DisplayPicturePage(
                                file: xFile, isVideo: true, videoUserTask: widget.videoUserTask)),
                      );
                      widget.videoUserTask.onRecordStop(xFile);
                      setState(() {
                        capturedImages.add(File(xFile.path));
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
                                  valueColor: AlwaysStoppedAnimation(Colors.black54),
                                  strokeWidth: 5),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                            ),
                          ],
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    if (isFlashOff) {
                      setState(() {
                        isFlashOff = false;
                        flashIcon = Icons.flash_on;
                      });
                      _controller.setFlashMode(FlashMode.always);
                    } else {
                      setState(() {
                        isFlashOff = true;
                        flashIcon = Icons.flash_off;
                      });
                      _controller.setFlashMode(FlashMode.off);
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
}
