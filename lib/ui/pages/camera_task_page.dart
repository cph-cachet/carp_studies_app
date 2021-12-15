part of carp_study_app;

// TODO Missing to obtain a list of the available cameras on the device (normal & selfie)
// final cameras = await availableCameras();

class CameraTaskPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraTaskPage({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraTaskPageState createState() => _CameraTaskPageState();
}

class _CameraTaskPageState extends State<CameraTaskPage> {
  @override
  void initState() {
    initializeCamera(selectedCamera); // O - normal camera, 1 - selfie camera
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

  void startRecording() async {
    await _initializeControllerFuture;

    try {
      await _controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } on CameraException catch (e) {
      print('Error: ${e.code}\n${e.description}');
    }
  }

  void stopRecording() async {
    try {
      var xFile = await _controller.stopVideoRecording();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(filePath: xFile.path, isVideo: true),
        ),
      );
      setState(() {
        capturedImages.add(File(xFile.path));
        isRecording = false;
      });
    } on CameraException catch (e) {
      print('Error: ${e.code}\n${e.description}');
    }
  }

  void takePicture() async {
    await _initializeControllerFuture;
    var xFile = await _controller.takePicture();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(filePath: xFile.path),
      ),
    );

    setState(() {
      capturedImages.add(File(xFile.path));
    });
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
                    takePicture();
                  },
                  onLongPress: () async {
                    startRecording();
                  },
                  onLongPressEnd: (details) async {
                    stopRecording();
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

class DisplayPictureScreen extends StatefulWidget {
  final String filePath;
  final bool isVideo;

  const DisplayPictureScreen({Key? key, required this.filePath, this.isVideo = false}) : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late VideoPlayerController _videoPlayerController;

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
    initializeVideoPLayer(widget.filePath);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: widget.isVideo
                  ? _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController))
                      : CircularProgressIndicator()
                  : Image.file(File(widget.filePath)),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.replay, color: Colors.white),
                  label: Text("RETAKE"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  child: Text("SAVE"),
                  onPressed: () {
                    // TODO: connect with video task
                  },
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
