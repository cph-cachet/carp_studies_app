part of carp_study_app;

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  SetupPageState createState() => SetupPageState();
}

class SetupPageState extends State<SetupPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          width: 291,
          height: 56,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xff006398,
            ),
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TextButton(
                    onPressed: null,
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(
                          0xffffffff,
                        ),
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
