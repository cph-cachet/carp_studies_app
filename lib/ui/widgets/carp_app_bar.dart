part of carp_study_app;

class CarpAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: Image.asset(
                'assets/carp_logo.png',
                height: 30,
              ),
            ),
            SizedBox(width: 3),
            IconButton(
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).primaryColor, size: 30),
              tooltip: 'Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) =>
                        ProfilePage(bloc.data.profilePageModel),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 200),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
