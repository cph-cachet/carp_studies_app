part of carp_study_app;

class MobilityCardWidget extends StatefulWidget {
  final MobilityCardDataModel model;
  MobilityCardWidget(this.model);
  _MobilityCardWidgetState createState() => _MobilityCardWidgetState();
}

class _MobilityCardWidgetState extends State<MobilityCardWidget> {
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
                  iconAssetName: Icon(Icons.emoji_transportation,
                      color: Theme.of(context).primaryColor),
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
