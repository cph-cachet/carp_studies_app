part of carp_study_app;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.keyboard_backspace, color: Theme.of(context).primaryColor, size: 30),
                      tooltip: 'Back',
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  SizedBox(width: 2),
                  Text(locale.translate('MY PROFILE'),
                      style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Username',
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc._backend.username, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account id',
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc._backend.clientID, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Full name',
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text('name', style: profileTitleStyle), // TODO add full name
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Study id',
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc._backend.studyId, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Upload backend',
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text('Something here', style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(),
                ]).toList(),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  Divider(indent: 0.1, endIndent: 0.1),
                  ListTile(
                    title: Text('Leave study',
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () {
                      print("leaving study");
                      _showLeaveStudyConfirmationDialog();
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Log out',
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () {
                      print("log out");
                      _showLogoutConfirmationDialog();
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Navigate to log in page
  Future _showLogoutConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You are about to log out. Are you sure?"),
          actions: <Widget>[
            FlatButton(
              child: Text(locale.translate("NO")),
              onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            FlatButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/AuthScreen', (Route<dynamic> route) => false);
              },
            )
          ],
        );
      },
    );
  }

  // TODO: Leave study
  Future _showLeaveStudyConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You are about to leave the study. Are you sure?"),
          actions: <Widget>[
            FlatButton(
              child: Text(locale.translate("NO")),
              onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            FlatButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
