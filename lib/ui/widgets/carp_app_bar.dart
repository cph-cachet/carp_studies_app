import 'package:carp_study_app/main.dart';
import 'package:flutter/material.dart';

class CarpAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        child: Image.asset(
          'assets/cachet_logo.png',
          height: 50,
        ),
      ),
      SizedBox(width: 3),
      IconButton(
        icon: const Icon(Icons.help_outline, color: Color.fromRGBO(32, 111, 162, 1), size: 30),
        tooltip: 'Help',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactPage();
          }));
        },
      ),
    ]);
  }
}
