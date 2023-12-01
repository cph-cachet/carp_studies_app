part of carp_study_app;

class ProfilePage extends StatefulWidget {
  final ProfilePageViewModel model;
  const ProfilePage(this.model, {super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle,
                      color: Theme.of(context).primaryColor, size: 30),
                  label: Text(locale.translate("pages.profile.title"),
                      style: aboutCardTitleStyle.copyWith(
                          color: Theme.of(context).primaryColor)),
                ),
                IconButton(
                  icon: Icon(Icons.close,
                      color: Theme.of(context).primaryColor, size: 30),
                  tooltip: locale.translate('Back'),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                padding: EdgeInsets.zero,
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.account_id')
                                .toUpperCase(),
                            style: profileSectionStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          widget.model.userid,
                          style: profileTitleStyle,
                          textScaleFactor: 0.75,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.username')
                                .toUpperCase(),
                            style: profileSectionStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(widget.model.username, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.name')
                                .toUpperCase(),
                            style: profileSectionStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(widget.model.name, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.study_deployment_id')
                                .toUpperCase(),
                            style: profileSectionStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(
                          widget.model.studyDeploymentId,
                          style: profileTitleStyle,
                          textScaleFactor: 0.75,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.study_name')
                                .toUpperCase(),
                            style: profileSectionStyle.copyWith(
                                color: Theme.of(context).primaryColor)),
                        Text(
                            locale.translate(widget.model.studyDeploymentTitle),
                            style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.mail_outline,
                        color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.contact'),
                        style: profileActionStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    onTap: () async {
                      _sendEmailToContactResearcher(
                        locale.translate(widget.model.responsibleEmail),
                        'Support for study: ${locale.translate(widget.model.studyDeploymentTitle)} - User: ${widget.model.username}',
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.policy_outlined,
                        color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.privacy'),
                        style: profileActionStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    onTap: () async {
                      try {
                        launchUrl(Uri.parse(CarpBackend.carpPrivacyUrl));
                      } finally {}
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.public_outlined,
                        color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.about.study.website'),
                        style: profileActionStyle.copyWith(
                            color: Theme.of(context).primaryColor)),
                    onTap: () async {
                      try {
                        launchUrl(Uri.parse(CarpBackend.carpWebsiteUrl));
                      } finally {}
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: CACHET.RED_1),
                    title: Text(locale.translate('pages.profile.leave_study'),
                        style:
                            profileActionStyle.copyWith(color: CACHET.RED_1)),
                    onTap: () {
                      _showLeaveStudyConfirmationDialog();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.power_settings_new,
                        color: CACHET.RED_1),
                    title: Text(locale.translate('pages.profile.log_out'),
                        style:
                            profileActionStyle.copyWith(color: CACHET.RED_1)),
                    onTap: () {
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

  /// Sends and email to the researcher with the name of the study + user id
  void _sendEmailToContactResearcher(String email, String subject) async {
    final url = Uri(
            scheme: 'mailto',
            path: email,
            queryParameters: {'subject': subject})
        .toString()
        .replaceAll("+", "%20");
    try {
      await launchUrl(Uri.parse(url));
    } finally {}
  }

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
              onPressed: () => context.pop(false),
            ),
            TextButton(
              child: Text(locale.translate("YES")),
              onPressed: () {
                context.pop(true);
              },
            )
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        bloc.leaveStudyAndSignOut().then((_) => context.go('/'));
      }
    });
  }

  Future _showLeaveStudyConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(locale.translate("pages.profile.leave_study.confirmation")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () => context.pop(false),
            ),
            TextButton(
                child: Text(locale.translate("YES")),
                onPressed: () => context.pop(true))
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        bloc.leaveStudy().then((_) => context.go('/invitations'));
      }
    });
  }
}
