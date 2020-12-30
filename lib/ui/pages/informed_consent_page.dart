part of carp_study_app;

class InformedConsentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Informed consent"),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return CARPStudyApp();
              })),
              child: Text('Accept'),
            )
          ],
        ),
      ),
    );
  }
}
