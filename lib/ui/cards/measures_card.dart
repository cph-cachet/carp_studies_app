part of carp_study_app;

class MeasuresCardWidget extends StatefulWidget {
  final MeasuresCardDataModel model;
  MeasuresCardWidget(this.model);
  _MeasuresCardWidgetState createState() => _MeasuresCardWidgetState();
}

class _MeasuresCardWidgetState extends State<MeasuresCardWidget> {
  Widget build(BuildContext context) {
    print(widget.model.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: widget.model.measureEvents,
                builder: (context, AsyncSnapshot<Datum> snapshot) => CardHeader(
                    title: 'Measures',
                    iconAssetName: Icon(Icons.emoji_objects,
                        color: Theme.of(context).primaryColor),
                    heroTag: 'measures-card',
                    value: '${widget.model.samplingSize} measures'),
              ),
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
