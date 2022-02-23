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
                    widget.videoUserTask.onSave();

                    widget.videoUserTask.onDone(context);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    // TODO: connect with video task
                    //widget.videoUserTask.file = widget.file;
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
