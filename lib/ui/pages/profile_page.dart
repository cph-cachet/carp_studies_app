part of carp_study_app;

class ProfilePage extends StatefulWidget {
  final ProfilePageViewModel model;
  const ProfilePage(this.model);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle, color: Theme.of(context).primaryColor, size: 30),
                  label: Text(locale.translate("pages.profile.title"),
                      style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
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
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                padding: EdgeInsets.zero,
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.username').toUpperCase(),
                            style: profileSectionStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(widget.model.username, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.account_id').toUpperCase(),
                            style: profileSectionStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(widget.model.userid, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.name').toUpperCase(),
                            style: profileSectionStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(widget.model.firstname + ' ' + widget.model.lastname, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.study_name').toUpperCase(),
                            style: profileSectionStyle.copyWith(color: Theme.of(context).primaryColor)),
                        Text(locale.translate(widget.model.studyTitle), style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.mail_outline, color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.contact'),
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () {
                      print("contact researcher");
                      _contactResearcher(
                        widget.model.responsibleEmail,
                        'Support for study: ${widget.model.studyTitle} - User: ${widget.model.username}',
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.policy_outlined, color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.privacy'),
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(locale.translate('study.description.privacy')))) {
                        await launchUrl(Uri.parse(locale.translate('study.description.privacy')));
                      } else {
                        throw 'Could not launch privacy policy URL';
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.public_outlined, color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.about.study.website'),
                        style: profileActionStyle.copyWith(color: Theme.of(context).primaryColor)),
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(locale.translate('study.description.website')))) {
                        await launchUrl(Uri.parse(locale.translate('study.description.website')));
                      } else {
                        throw 'Could not launch Study URL';
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new, color: CACHET.RED_1),
                    title: Text(locale.translate('pages.profile.log_out'),
                        style: profileActionStyle.copyWith(color: CACHET.RED_1)),
                    onTap: () {
                      print("logging out");
                      _showLogoutConfirmationDialog();
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
                ]).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sends and email to the researcher with the name of the study + user id
  void _contactResearcher(String email, String subject) async {
    final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': subject});

    var url = _emailLaunchUri.toString().replaceAll("+", "%20");

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // TODO: Navigate to log in page
  Future _showLogoutConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.translate("pages.profile.log_out.confirmation")),
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

                // Remove the auth credentials
                bloc.signOut();
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
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locale.translate("pages.profile.leave_study.confirmation")),
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
