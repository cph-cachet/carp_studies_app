part of carp_study_app;

class InvitationPage extends StatelessWidget {
  final String invitationId;

  const InvitationPage({
    super.key,
    required this.invitationId,
  });

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    icon: const Icon(Icons.close_rounded))
              ]),
              Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.public_outlined,
                              color: Theme.of(context).primaryColor),
                          Text(locale.translate('pages.about.study.website'),
                              style: aboutCardSubtitleStyle.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
