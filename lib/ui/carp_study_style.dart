import 'package:flutter/material.dart';

ThemeData carpStudyTheme = ThemeData.light().copyWith(
  primaryColor: Color.fromRGBO(32, 111, 162, 1),
  accentColor: Color.fromRGBO(113, 164, 218, 1),
  textTheme: ThemeData.light().textTheme.apply(fontFamily: 'MuseoSans', bodyColor: Colors.grey[800]),
);

ButtonTheme roundedFilledButtonTheme = ButtonTheme(
  height: 40,
  minWidth: 100,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  buttonColor: carpStudyTheme.accentColor,
);

ButtonTheme flatButtonTheme = ButtonTheme(
  height: 40,
  minWidth: 100,
);

TextStyle studyTitleStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle readMoreStudyStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle scoreNumberStyle =
    TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle scoreTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle aboutCardTitleStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle aboutCardInfoStyle =
    TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle aboutCardSubtitleStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color.fromRGBO(70, 70, 70, 1));

TextStyle aboutCardContentStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Color.fromRGBO(70, 70, 70, 0.7));

TextStyle sectionTitleStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color.fromRGBO(70, 70, 70, 1));
