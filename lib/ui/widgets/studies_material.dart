part of carp_study_app;

/// A [Card] for this app that makes all cards looks the same.
class StudiesMaterial extends StatelessWidget {
  final Widget child;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final ShapeBorder shape;
  final Clip? clipBehavior;
  final bool hasBorder;
  final Color backgroundColor;
  final Color borderColor;

  const StudiesMaterial({
    super.key,
    required this.child,
    this.elevation = 2.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    this.clipBehavior,
    this.hasBorder = false,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Material(
        color: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            border: hasBorder
                ? Border(
                    left: BorderSide(
                      color: borderColor,
                      width: 4.0,
                    ),
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
