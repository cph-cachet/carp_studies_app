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
      appBar: AppBar(
        title: Text(
          locale.translate('invitation.invited_to_study'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Adjust the radius as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 24.0,
                      left: 24.0,
                      top: 16.0,
                      bottom: 16.0, // Adjust the bottom padding
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
    );
  }
}
