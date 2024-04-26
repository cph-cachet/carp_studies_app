part of carp_study_app;

class InvitationListPage extends StatelessWidget {
  static const String route = '/invitations';
  final InvitationsViewModel model;
  const InvitationListPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      body: FutureBuilder<List<ActiveParticipationInvitation>>(
        future: bloc.backend.getInvitations(),
        builder: (context, snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = SliverFixedExtentList(
              itemExtent: 150,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: InvitationMaterial(
                      invitation: snapshot.data![index],
                    ),
                  );
                },
                childCount: snapshot.data!.length,
              ),
            );
          } else {
            child = const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    locale.translate('invitation.invitations'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  centerTitle: true,
                  pinned: true,
                  stretch: true,
                  stretchTriggerOffset: 20,
                  onStretchTrigger: () async => bloc.backend.getInvitations(),
                  leading: IconButton(
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
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      locale.translate('invitation.subtitle'),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                child,
              ],
            ),
          );
        },
      ),
    );
  }
}

class InvitationMaterial extends StatelessWidget {
  final ActiveParticipationInvitation invitation;

  const InvitationMaterial({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) => Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12.0), // Adjust the radius as needed
        ),
        child: InkWell(
          onTap: () {
            context.push(
                '${InvitationDetailsPage.route}/${invitation.participation.participantId}');
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
                Text(
                  (invitation.invitation.description ?? ''),
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
