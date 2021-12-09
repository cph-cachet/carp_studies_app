part of carp_study_app;

class ProcessMessagePage extends StatelessWidget {
  // Type of message to display (e.g Error, Succes, Informative)
  final ProcessStatus statusType;

  // Message title
  final String title;

  // Message description
  final String description;

  // Button text
  final String actionText;

  // Button action on pressed. Function called by pressing the button.
  final Function actionFunction;

  // Display cancel button. If true the button is displayed.
  final bool canCancel;

  ProcessMessagePage(
      {required this.statusType,
      required this.title,
      required this.description,
      required this.actionFunction,
      required this.actionText,
      this.canCancel = true});

  @override
  Widget build(BuildContext context) {
    print("in message page");
    Image messageImage() {
      final Image image;
      switch (this.statusType) {
        case ProcessStatus.DONE:
          image = Image(
              image: AssetImage('assets/icons/done.png'), height: MediaQuery.of(context).size.height * 0.35);
          break;
        case ProcessStatus.ERROR:
          image = Image(
              image: AssetImage('assets/icons/error.png'), height: MediaQuery.of(context).size.height * 0.35);
          break;
        case ProcessStatus.OTHER:
        default:
          image = Image(
              image: AssetImage('assets/icons/audio.png'), height: MediaQuery.of(context).size.height * 0.35);
          break;
      }

      return image;
    }

    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                messageImage(),
                SizedBox(height: 20),
                Center(child: Text(locale.translate(this.title), style: audioTitleStyle)),
                SizedBox(height: 10),
                Text(locale.translate(this.description), style: audioContentStyle),
              ]),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            canCancel == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 15),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(locale.translate('cancel').toUpperCase(),
                              style: TextStyle(color: Theme.of(context).primaryColor))),
                      SizedBox(width: 10),
                    ],
                  )
                : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                  onPressed: () {
                    this.actionFunction();
                  },
                  child: Text(locale.translate(this.actionText).toUpperCase()),
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ));
  }
}
