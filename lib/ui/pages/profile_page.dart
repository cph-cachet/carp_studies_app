part of carp_study_app;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AssetLocalizations locale = AssetLocalizations.of(context)!;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.account_circle, color: Theme.of(context).primaryColor, size: 30),
                          onPressed: () {}),
                      Text(locale.translate('pages.profile.title'),
                          style: sectionTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30),
                      tooltip: locale.translate('Back'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
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
                        Text(locale.translate('pages.profile.username'),
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc.user!.username, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.name'),
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc.user!.firstName! + ' ' + bloc.user!.lastName!,
                            style: profileTitleStyle), // TODO add full name
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.account_id'),
                            style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(bloc.user!.id.toString(), style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent, color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.contact'),
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () {
                      print("contact researcher");
                      _contactResearcher();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: CACHET.RED_1),
                    title: Text(locale.translate('pages.profile.leave_study'),
                        style: profileActionStyle.copyWith(color: CACHET.RED_1)),
                    onTap: () {
                      print("leaving study");
                      _showLeaveStudyConfirmationDialog();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new, color: CACHET.RED_1),
                    title: Text(locale.translate('pages.profile.log_out'),
                        style: profileActionStyle.copyWith(color: CACHET.RED_1)),
                    onTap: () {
                      print("log out");
                      _showLogoutConfirmationDialog();
                    },
                  ),
                ]).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sends and email to the researcher with the name of the study + user id
  void _contactResearcher() async {
    final Uri _emailLaunchUri =
        Uri(scheme: 'mailto', path: bloc.deployment!.responsible!.email, queryParameters: {
      'subject':
          'Support for study: ${bloc.deployment!.protocolDescription!.title} - User: ${bloc.user!.id.toString()}'
    });

    var url = _emailLaunchUri.toString().replaceAll("+", "%20");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // TODO: Navigate to log in page
  Future _showLogoutConfirmationDialog() {
    AssetLocalizations? locale = AssetLocalizations.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale!.translate("pages.profile.log_out.confirmation")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);

                bloc.leaveStudyAndSignOut();
                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
                // TODO - not sure this works - test
                Navigator.of(context).pushReplacementNamed('/LoadingPage');
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => LoadingPage()),
                // );
              },
            )
          ],
        );
      },
    );
  }

  // TODO: Leave study
  Future _showLeaveStudyConfirmationDialog() {
    AssetLocalizations? locale = AssetLocalizations.of(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale!.translate("pages.profile.leave_study.confirmation")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                // Calling the onCancel method with which the developer can for e.g. save the result on the device.
                // Only call it if it's not null
                //widget.onCancel?.call(_taskResult);
                bloc.leaveStudy();

                // Popup dismiss
                Navigator.of(context).pop();
                // Exit the Ordered Task
                Navigator.of(context).pop();
                // TODO - not sure this works - test
                Navigator.of(context).pushReplacementNamed('/LoadingPage');
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => LoadingPage()),
                // );
              },
            )
          ],
        );
      },
    );
  }
}
