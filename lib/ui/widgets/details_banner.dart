part of carp_study_app;

class DetailsBanner extends StatelessWidget {
  const DetailsBanner(this.title, this.image, {this.isCarpBanner = false});
  final String title;
  final String? image;
  final bool isCarpBanner;

  @override
  Widget build(
    BuildContext context,
  ) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return SliverAppBar(
      expandedHeight: 150.0,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(top: 15),
        background: image != null
            ? ClipRRect(
                child: ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Image.asset(image!, fit: BoxFit.fitHeight)),
              )
            : const SizedBox.shrink(),
        title: Container(
          child: InkWell(
            onTap: () {
              isCarpBanner == true
                  ? Navigator.push(context, MaterialPageRoute(builder: (context) => StudyDetailsPage()))
                  : print("no");
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Stack(
                    children: [
                      Text(
                        locale.translate(title),
                        style: studyNameStyle.copyWith(
                            // color: Theme.of(context).primaryColor,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                        locale.translate(title),
                        style: studyNameStyle.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  isCarpBanner
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.touch_app, color: Theme.of(context).primaryColor, size: 15),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
