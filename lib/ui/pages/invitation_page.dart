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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                invitation.invitation.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Expanded(
                child: Scrollbar(
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
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    bloc.setStudyInvitation(invitation, context);
                    context.push(InformedConsentPage.route);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    locale.translate('invitation.accept_invite'),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
