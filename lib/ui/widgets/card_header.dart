part of carp_study_app;

class CardHeader extends StatelessWidget {
  final Icon iconAssetName;
  final String title;
  final String value;
  final String heroTag;
  final String routeName;

  CardHeader({this.heroTag, this.iconAssetName, this.title, this.value, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(padding: const EdgeInsets.only(right: 8.0), child: iconAssetName),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: aboutCardSubtitleStyle.copyWith(color: Theme.of(context).primaryColor)),
                Text(value, style: aboutCardTitleStyle.copyWith(color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
