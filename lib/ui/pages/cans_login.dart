part of carp_study_app;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 56),
                  child: Image.asset(
                    'assets/carp_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(
                    0xff006398,
                  ),
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    await bloc.backend.authenticate();
                    if (bloc.backend.isAuthenticated) {
                      if (context.mounted) {
                        context.go('/invitations');
                      }
                    }
                  },
                  child: const Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
