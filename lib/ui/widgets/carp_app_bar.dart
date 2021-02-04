import 'package:carp_study_app/main.dart';
import 'package:flutter/material.dart';

class CarpAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Image.asset(
                'assets/cachet_logo.png',
                height: 20,
              ),
            ),
            SizedBox(width: 3),
            IconButton(
              icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).primaryColor, size: 30),
              tooltip: 'Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => ProfilePage(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
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
