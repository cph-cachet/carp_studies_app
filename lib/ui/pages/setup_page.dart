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
          child: ElevatedButton(
            child: const Text('Setup'),
            onPressed: () {
              context.go('/LoginPage');
            },
          ),
        ));
  }
}
