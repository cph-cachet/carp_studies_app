part of carp_study_app;

class FailedLoginPage extends StatefulWidget {
  final FailedLoginPageState state = FailedLoginPageState();
  FailedLoginPageState createState() => state;
}

class FailedLoginPageState extends State<FailedLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Ink(
            width: 60,
            height: 60,
            decoration: const ShapeDecoration(
              color: CACHET.GREY_1,
              shape: CircleBorder(),
            ),
            child: Icon(
              Icons.assignment_late,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'It seems like you are not invited to any ongoing study',
                style: aboutCardSubtitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          TextButton(onPressed: () => print("go back"), child: Text('Back'))
        ],
      ),
    );
  }
}
