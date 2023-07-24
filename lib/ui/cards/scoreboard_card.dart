part of carp_study_app;

class ScoreboardCard extends StatefulWidget {
  final TaskListPageViewModel model;
  const ScoreboardCard(this.model, {super.key});
  @override
  ScoreboardCardState createState() => ScoreboardCardState();
}

class ScoreboardCardState extends State<ScoreboardCard> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return SliverPersistentHeader(
      pinned: true,
      delegate: ScoreboardPersistentHeaderDelegate(
        model: widget.model,
        locale: locale,
        minExtent: 30,
        maxExtent: 110,
      ),
    );
  }
}

/// Make a [SliverPersistentHeaderDelegate] to use in a [SliverPersistentHeader] widget, that can be used in a [CustomScrollView].
/// This is used in the [StudyPage] to make the header of the page.
/// The delegate should retract from 110px to 60px when scrolling down.
/// The animation should be simple and linear. A stretched header does not do anything.
class ScoreboardPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  TaskListPageViewModel model;
  RPLocalizations locale;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  ScoreboardPersistentHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.model,
    required this.locale,
  });

  /// The header should should be 110px when not scrolling, and 60px when scrolling.
  /// The numbers should become smaller when scrolling down, by using the scoreNumberStyleSmall instead of scoreNumberStyle.
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double height = 110;

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      height: height,
      child: StreamBuilder<UserTask>(
        stream: model.userTaskEvents,
        builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.daysInStudy.toString(),
                        style: scoreNumberStyle.copyWith(
                            fontSize: calculateSize(
                                shrinkOffset,
                                scoreNumberStyleSmall.fontSize!,
                                scoreNumberStyle.fontSize!),
                            color: Theme.of(context).primaryColor)),
                    if (shrinkOffset < 60)
                      Text(locale.translate('cards.scoreboard.days'),
                          style: scoreTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
              // a vertical divider line with rounded corners that spans from 10% to 90% of the height
              Expanded(
                flex: 0,
                child: Container(
                  height: calculateSize(
                      shrinkOffset, minExtent * 0.6, maxExtent * 0.6),
                  width: 2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.taskCompleted.toString(),
                        style: scoreNumberStyle.copyWith(
                            fontSize: calculateSize(
                                shrinkOffset,
                                scoreNumberStyleSmall.fontSize!,
                                scoreNumberStyle.fontSize!),
                            color: Theme.of(context).primaryColor)),
                    if (shrinkOffset < 60)
                      Text(locale.translate('cards.scoreboard.tasks'),
                          style: scoreTextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  // A simple function that returns the font size from the scoreNumberStyle, but increasingly smaller when scrolling down.
  double calculateSize(double shrinkOffset, double minSize, double maxSize) {
    // Calculate the normalized shrinkOffset value in the range [0, 1]
    double normalizedShrinkOffset = shrinkOffset / maxExtent;

    // Calculate the font size using linear interpolation
    double size = maxSize - normalizedShrinkOffset * (maxSize - minSize);

    // Return the calculated font size
    return size;
  }

  @override
  bool shouldRebuild(ScoreboardPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
      );

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}
