part of carp_study_app;

class InvitationDetailsPage extends StatelessWidget {
  static const String route = '/invitation';
  final String invitationId;
  final InvitationsViewModel model;

  const InvitationDetailsPage({
    super.key,
    required this.invitationId,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    var invitation = model.getInvitation(invitationId);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const CarpAppBar(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(LoginPage.route);
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        locale.translate('invitation.invited_to_study'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: StudiesCard(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 24.0,
                        left: 24.0,
                        top: 16.0,
                        bottom: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            invitation.invitation.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                          Scrollbar(
                            thumbVisibility: true,
                            radius: const Radius.circular(100),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                invitation.invitation.description ?? '',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xff006398),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextButton(
                  onPressed: () {
                    bloc.setStudyInvitation(invitation, context);
                    context.push(InformedConsentPage.route);
                  },
                  child: Text(
                    locale.translate("invitation.accept_invite"),
                    style:
                        const TextStyle(color: Color(0xffffffff), fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
