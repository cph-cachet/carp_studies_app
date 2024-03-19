part of carp_study_app;

class CameraPage extends StatefulWidget {
  final VideoUserTask videoUserTask;
  const CameraPage({super.key, required this.videoUserTask});
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  List<CameraDescription>? cameras;

  IconData flashIcon = Icons.flash_off;
  bool isFlashOff = true;
  late File capturedImages;
  bool isRecording = false;
  late CameraController _cameraController;
  late Future<void> cameraInit;
  bool isFrontCamera = false;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: true);
    cameraInit = _cameraController.initialize();
    setState(() {});
  }

  void toggleCamera() async {
    int newCameraIndex = isFrontCamera ? 0 : 1;
    _cameraController = CameraController(
        cameras![newCameraIndex], ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420, enableAudio: true);
    await _cameraController.initialize();
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
  }

  void toggleFlash() {
    if (isFlashOn) {
      _cameraController.setFlashMode(FlashMode.off);
    } else {
      _cameraController.setFlashMode(FlashMode.torch);
    }
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  void takePicture() async {
    try {
      await cameraInit;
      final image = await _cameraController.takePicture();
      // Do something with the captured image, like saving it to gallery
      print('Image saved to ${image.path}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30))
              ],
            ),
            const SizedBox(height: 35),
            FutureBuilder<void>(
              future: cameraInit,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CameraPreview(_cameraController))),
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
                    onPressed: toggleCamera,
                    icon: const Icon(Icons.flip_camera_android,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var picture = await _cameraController.takePicture();
                      widget.videoUserTask.onPictureCapture(picture);
                      if (context.mounted) {
                        await Navigator.of(context)
                            .push(MaterialPageRoute<void>(
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
                      try {
                        await _cameraController.startVideoRecording();
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
                        var video =
                            await _cameraController.stopVideoRecording();

                        widget.videoUserTask.onRecordStop(video);
                        if (context.mounted) {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
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
                                    shape: BoxShape.circle,
                                    color: Colors.white),
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
                    onPressed: toggleFlash,
                    icon: Icon(flashIcon, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
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
