part of carp_study_app;

class DataVisualization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(height: height * .08),
                  CarpAppBar(),
                ])))
      ]
          //child: CircularProgressIndicator(),
          ),
    ));
  }
}
