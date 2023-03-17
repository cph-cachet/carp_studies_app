part of carp_study_app;

class InvitationListPage extends StatelessWidget {
  final List<ActiveParticipationInvitation> invitations;

  const InvitationListPage({
    super.key,
    required this.invitations,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    var invitations = [
      ActiveParticipationInvitation(Participation('', 'asdjhkajskd'),
          StudyInvitation('This is not a valid study invitation id.', 'a')),
      ActiveParticipationInvitation(
          Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.',
              'bsaidugoiadsgoiuagdsuoiasdgiouadsgoiuadsguioasdguioadsgiouadsgiouasdiogu oisduiogu asdoiug iosadugio usadoig uoisdau goisduaoi guasdioug oisdauoi gusdaioug siodaugoi udsaoiug oisdug iusaiodu giosduagio usaoidug oiasu goiusda iogusoiad ugiosadu giosdu giousaoid uiaosdgu iousadiogu soaiu goisauoig usoiadug iosuda giousdao igusaodiu ')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
      ActiveParticipationInvitation(Participation('', 'dsfadsfadsf'),
          StudyInvitation('This is not a valid study invitation id.', 'b')),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  locale.translate('invitation.invitations'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: InvitationCard(
                        invitation: invitations[index],
                      ),
                    );
                  },
                  childCount: invitations.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvitationCard extends StatelessWidget {
  final ActiveParticipationInvitation invitation;

  const InvitationCard({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () {
            context.go('/invitation/${invitation.participation.id}');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  invitation.invitation.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  (invitation.invitation.description),
                  style: const TextStyle(fontSize: 16.0),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      );
}
