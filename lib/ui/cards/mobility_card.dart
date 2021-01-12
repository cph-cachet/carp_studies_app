part of carp_study_app;

class MobilityCard extends StatefulWidget {
  @override
  _MobilityCardState createState() => _MobilityCardState();
}

class _MobilityCardState extends State<MobilityCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CardHeader(
                  title: 'Mobility',
                  iconAssetName: Icon(Icons.emoji_transportation, color: Theme.of(context).primaryColor),
                  heroTag: 'mobility-card',
                  value: '54% home stay'),
              Container(
                height: 160,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
