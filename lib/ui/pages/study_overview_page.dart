import 'package:flutter/material.dart';

import '../carp_study_style.dart';

class StudyOverviewPage extends StatefulWidget {
  @override
  _StudyOverviewPageState createState() => _StudyOverviewPageState();
}

class _StudyOverviewPageState extends State<StudyOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: SafeArea(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: 400,
            height: 3 * height / 4,
            color: Color(0xFFF1F9FF),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed mattis augue vitae volutpat aliquam. Ut sed eros lobortis, efficitur metus vel, dignissim risus. Nam ac scelerisque lacus. Morbi non libero sed est placerat mattis in a diam. In at sem et odio suscipit efficitur nec quis lacus. Suspendisse arcu nisl, convallis ac est sit amet, tincidunt sagittis velit. Donec quis blandit turpis, non pulvinar mi. Fusce vel ante a nisl convallis consequat nec finibus purus. Pellentesque tortor ex, porta quis velit vel, hendrerit ornare nulla. Mauris eget nisl et urna ornare dignissim. Quisque varius id risus et vulputate. Praesent mattis volutpat tincidunt. Quisque convallis elementum finibus. Nunc et congue metus. Cras fermentum nisl velit.Integer fringilla iaculis quam vel malesuada. Vivamus lobortis nunc felis, in dignissim risus vehicula et. Quisque euismod, urna et rhoncus pellentesque, ante nisl aliquam elit, non aliquet nunc libero vel risus. Morbi odio lacus, pellentesque id bibendum at, vulputate nec mauris. Phasellus eget est dictum, pretium lectus at, vehicula tortor. Vestibulum malesuada in enim sed efficitur. Morbi aliquam tristique elit, at dapibus felis egestas sit amet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce rhoncus consequat magna, et facilisis leo scelerisque in. Praesent ut blandit mauris. Nunc feugiat aliquet odio, tincidunt sagittis mauris porttitor eu. Morbi volutpat, sapien vitae viverra feugiat, mi odio elementum turpis, nec interdum metus urna ac arcu. Proin vitae ex semper, rutrum nulla nec, vulputate ipsum. Curabitur blandit venenatis nisi eu dapibus. here',
                        style: aboutCardContentStyle,
                        textAlign: TextAlign.justify)),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Read less', style: readMoreStudyStyle),
                        Icon(Icons.keyboard_arrow_up_outlined, color: Color(0xff77A8C8))
                      ],
                    )),
                SizedBox(height: height * .05)
              ],
            ),
          )
        ])));
  }
}
