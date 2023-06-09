part of carp_study_app;

class FailedLoginPage extends StatefulWidget {
  const FailedLoginPage({super.key});
  @override
  FailedLoginPageState createState() => FailedLoginPageState();
}

class FailedLoginPageState extends State<FailedLoginPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
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
            child: const Icon(
              Icons.assignment_late,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            locale.translate('login.failed_login'),
            style: aboutCardSubtitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
