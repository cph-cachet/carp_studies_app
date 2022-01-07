part of carp_study_app;

class DevicesPage extends StatefulWidget {
  final DevicesPageViewModel model;
  const DevicesPage(this.model);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView(children: [
            ListTile(
              leading: FlutterLogo(),
              title: Text('One-line with leading widget'),
            ),
          ])
        ],
      ),
    );
  }
}
