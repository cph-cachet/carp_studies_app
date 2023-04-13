part of carp_study_app;

class CameraPage extends StatefulWidget {
  final VideoUserTask videoUserTask;
  final List<CameraDescription> cameras;

  const CameraPage(
      {super.key, required this.videoUserTask, required this.cameras});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  int selectedCamera = 0; // 0 = external camera
  IconData flashIcon = Icons.flash_off;
  bool isFlashOff = true;
  late File capturedImages;
  bool isRecording = false;

  @override
  void initState() {
    initializeCamera(selectedCamera);
    super.initState();
  }

  void initializeCamera(int cameraIndex) {
    _cameraController = CameraController(
        widget.cameras[cameraIndex], ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: true);

    _initializeControllerFuture = _cameraController?.initialize();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _showCancelConfirmationDialog();
                  },
                  icon: const Icon(Icons.close, color: Colors.white, size: 30))
            ],
          ),
          const SizedBox(height: 35),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CameraPreview(_cameraController!))),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Spacer(),
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
                  icon: const Icon(Icons.flip_camera_android,
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () async {
                    await _initializeControllerFuture;
                    var picture = await _cameraController!.takePicture();
                    widget.videoUserTask.onPictureCapture(picture);
                    if (context.mounted) {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisplayPicturePage(
                                file: picture,
                                videoUserTask: widget.videoUserTask,
                              )));
                    }

                    setState(() {
                      capturedImages = File(picture.path);
                    });
                  },
                  onLongPress: () async {
                    await _initializeControllerFuture;

                    try {
                      await _cameraController!.startVideoRecording();
                      widget.videoUserTask.onRecordStart();
                      setState(() {
                        isRecording = true;
                      });
                    } on CameraException catch (e) {
                      warning(
                          '$runtimeType - error: ${e.code}\n${e.description}');
                    }
                  },
                  onLongPressEnd: (details) async {
                    try {
                      var video = await _cameraController!.stopVideoRecording();

                      widget.videoUserTask.onRecordStop(video);
                      if (context.mounted) {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DisplayPicturePage(
                                  file: video,
                                  isVideo: true,
                                  videoUserTask: widget.videoUserTask)),
                        );
                      }
                      setState(() {
                        capturedImages = File(video.path);
                        isRecording = false;
                      });
                    } on CameraException catch (e) {
                      warning(
                          '$runtimeType - error: ${e.code}\n${e.description}');
                    }
                  },
                  child: isRecording
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            const SizedBox(
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
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ],
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
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
                      _cameraController?.setFlashMode(FlashMode.always);
                    } else {
                      setState(() {
                        isFlashOff = true;
                        flashIcon = Icons.flash_off;
                      });
                      _cameraController?.setFlashMode(FlashMode.off);
                    }
                  },
                  icon: Icon(flashIcon, color: Colors.white),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

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
