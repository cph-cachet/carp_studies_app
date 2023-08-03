part of carp_study_app;

class DetailsBanner extends StatelessWidget {
  const DetailsBanner(this.title, this.imagePath, {super.key});
  final String title;
  final String? imagePath;

  @override
  Widget build(
    BuildContext context,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // only show this widget if there is an image = imagePath is not null and not empty
        if (imagePath != null && imagePath!.isNotEmpty)
          SizedBox(
            height: 300,
            child: bloc.data.studyPageViewModel.getMessageImage(imagePath),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Stack(
                children: [
                  Text(
                    locale.translate(title),
                    style: studyNameStyle.copyWith(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
