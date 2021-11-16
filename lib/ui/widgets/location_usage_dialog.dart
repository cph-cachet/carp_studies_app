part of carp_study_app;

class LocationUsageDialog {
  Widget build(BuildContext context, String message) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    final AlertDialog locationUsageDialog = AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/location.png",
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(locale.translate("dialog.location.permission"),
              style: aboutCardTitleStyle),
        ],
      ),
      contentPadding: EdgeInsets.all(15),
      insetPadding: EdgeInsets.all(30),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            locale.translate(message),
            style: aboutCardContentStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, true);

            // // set up and initialize sensing
            // Sensing().askForPermissions().then(
            //       (_) => {
            //         bloc.start(),
            //         Navigator.of(context).pushReplacementNamed('/HomePage'),
            //       },
            //     ),
            // Popup dismiss
          },
          child: Text(locale.translate("dialog.location.allow")),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
        ),
      ],
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarpAppBar(),
          Expanded(
            child: locationUsageDialog,
          ),
        ],
      ),
    );
  }
}
