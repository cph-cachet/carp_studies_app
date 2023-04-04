part of carp_study_app;

class InvitationDetailsPage extends StatelessWidget {
  final String invitationId;

  const InvitationDetailsPage({
    super.key,
    required this.invitationId,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    // ActiveParticipationInvitation invitation = bloc.invitations
    //     .firstWhere((element) => element.participation.id == invitationId);

    var invitation = ActiveParticipationInvitation(
      Participation('abcd1234', '5678', AssignedTo.all()),
      StudyInvitation('My Study',
          'Welcome to the Episodic Future Thinking study (DTU-EFT). In this study we look at motivation to engage in healthy behaviors, and the tendency to prefer immediate gratification over long term health. This concept, called “Delay Discounting”, is also a measure of how future rewards are perceived to drop in value over time. As a participant in this study you will be asked to choose one health or wellness goal to work with throughout the 3-week study period. This could, for example, be a desire to increase physical activity, eat healthier, reduce alcohol consumption, reduce smoking, or establish better sleeping habits. As part of the study, you will be working with educational & motivational materials aiming to help you achieve your chosen goal. In the application you will be able to find links to the materials. We encourage you to use these as a starting point but also as inspiration to find other materials online. As part of the study we ask you to download the study app to your phone (available both for iOS and Android). Links and a QR code to download the app can be found here: https://docs.google.com/document/d/1IG4IJocZnZWNDUwAf9d2rpxzU1N1ErX9TbKE_X-PRv4/edit?usp=sharing When first starting the application, it will prompt you to provide consent to participate in the study (please note you are not enrolled in the study until you have completed this form). In addition to the educational/motivational links the app also contains study surveys that will appear immediately after consent and subsequently every 7 days until the end of the study period.'),
    ); //TODO:

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.translate('invitation.invited_to_study'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Text(
                invitation.invitation.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
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
              onPressed: () {},
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
    );
  }
}
