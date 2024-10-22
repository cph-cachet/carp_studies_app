part of carp_study_app;

class ProfilePage extends StatefulWidget {
  static const String route = '/profile';
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
                    Navigator.of(context).pop();
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
                        Text(locale.translate('pages.profile.username'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(widget.model.username, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.account_id'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                          widget.model.userId,
                          style: profileTitleStyle,
                          maxLines: 1,
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.full_name'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(widget.model.fullName, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.email'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(widget.model.email, style: profileTitleStyle),
                      ],
                    ),
                  ),
                  //
                  //  BIG DIVIDER
                  // 
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            locale
                                .translate('pages.profile.study_deployment_id'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                          widget.model.studyDeploymentId,
                          style: profileTitleStyle,
                          maxLines: 1,
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.study_name'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                            locale.translate(widget.model.studyDeploymentTitle),
                            style: profileTitleStyle),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.participant_id'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                          widget.model.participantId,
                          style: profileTitleStyle,
                          maxLines: 1,
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.participant_role'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                          widget.model.participantRole,
                          style: profileTitleStyle,
                          maxLines: 1,
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.translate('pages.profile.device_role'),
                            style: profileSectionStyle.copyWith(
                                color: CACHET.GREY_6)),
                        Text(
                          widget.model.deviceRole,
                          style: profileTitleStyle,
                          maxLines: 1,
                          textScaler: TextScaler.linear(1),
                        ),
                      ],
                    ),
                  ),
                  //
                  //  BIG DIVIDER
                  // 
                  ListTile(
                    leading: Icon(Icons.mail_outline,
                        color: Theme.of(context).primaryColor),
                    title: Text(locale.translate('pages.profile.contact'),
                        style: profileActionStyle.copyWith(
                            color: CACHET.PROFILE_SECTION_TEXT)),
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
                            color: CACHET.PROFILE_SECTION_TEXT)),
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
                            color: CACHET.PROFILE_SECTION_TEXT)),
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
                    onTap: () async {
                      bool isConnected = await bloc.checkConnectivity();
                      if (isConnected) {
                        _showLogoutConfirmationDialog();
                      } else {
                        _showEnableInternetConnectionDialog();
                      }
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

  Future<void> _showLogoutConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog<bool>(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title: Text(locale.translate("pages.profile.log_out.confirmation")),
          actions: <Widget>[
            TextButton(
                child: Text(locale.translate("NO")),
                onPressed: () async {
                  if (builderContext.mounted) {
                    Navigator.of(builderContext).pop();
                  }
                }),
            TextButton(
                child: Text(locale.translate("YES")),
                onPressed: () async {
                  if (builderContext.mounted) {
                    await bloc.signOutAndLeaveStudy();
                    builderContext.pop();
                    builderContext.go(CarpStudyAppState.homeRoute);
                  }
                }),
          ],
        );
      },
    );
  }

  Future<void> _showLeaveStudyConfirmationDialog() {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return showDialog<bool>(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title:
              Text(locale.translate("pages.profile.leave_study.confirmation")),
          actions: <Widget>[
            TextButton(
              child: Text(locale.translate("NO")),
              onPressed: () {
                if (builderContext.mounted) {
                  Navigator.of(builderContext).pop();
                }
              },
            ),
            TextButton(
                child: Text(locale.translate("YES")),
                onPressed: () async {
                  if (builderContext.mounted) {
                    await bloc.leaveStudy();
                    builderContext.pop();
                    builderContext.go(InvitationListPage.route);
                  }
                }),
          ],
        );
      },
    );
  }

  Future<void> _showEnableInternetConnectionDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext builderContext) {
        return EnableInternetConnectionDialog();
      },
    );
  }
}

class SlidePageRoute extends PageRouteBuilder<Widget> {
  final Widget page;
  SlidePageRoute(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
