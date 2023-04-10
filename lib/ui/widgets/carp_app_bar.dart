part of carp_study_app;

class CarpAppBar extends StatelessWidget {
  const CarpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Image.asset(
                      'assets/carp_logo.png',
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    icon: Icon(Icons.account_circle_outlined,
                        color: Theme.of(context).primaryColor, size: 30),
                    tooltip: 'Profile',
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) =>
                              ProfilePage(bloc.data.profilePageViewModel),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
