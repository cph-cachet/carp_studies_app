import 'package:carp_study_app/ui/carp_study_style.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 110,
      color: Color(0xFFF1F9FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('2', style: scoreNumberStyle),
                  Text('Days in study', style: scoreTextStyle),
                ],
              ),
              Container(
                  height: 66,
                  child: VerticalDivider(
                    color: Color(0xff77A8C8),
                    width: 80,
                  )),
              Column(
                children: [
                  Text('4', style: scoreNumberStyle),
                  Text('Task completed', style: scoreTextStyle),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
