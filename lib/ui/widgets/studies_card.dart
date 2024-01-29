part of carp_study_app;

/// A [Card] for this app that makes all cards looks the same.
class StudiesCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final ShapeBorder shape;
  final Clip? clipBehavior;

  const StudiesCard({
    super.key,
    required this.child,
    this.elevation = 2.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      shape: shape,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
