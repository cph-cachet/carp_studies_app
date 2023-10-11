part of carp_study_app;

class LogoutMessage extends StatelessWidget {
  const LogoutMessage({super.key});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return AlertDialog(
      title:  Text(locale.translate("widgets.logoutmessage.title")),
      content:  Text(
          locale.translate("widgets.logoutmessage.message")),
      actions: <Widget>[
        TextButton(
          child:  Text(locale.translate("widgets.logoutmessage.cancel")),
          onPressed: () {
            context.pop(false);
          },
        ),
        TextButton(
          child:  Text(locale.translate("widgets.logoutmessage.okay")),
          onPressed: () {
            context.pop(true);
          },
        ),
      ],
    );
  }
}
