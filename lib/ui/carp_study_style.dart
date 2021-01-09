import 'package:flutter/material.dart';

ThemeData carpStudyTheme = ThemeData.light().copyWith(
      primaryColor: Color.fromRGBO(32, 111, 162, 1),
      accentColor: Color(0xFFF1F9FF),
      textTheme: ThemeData
          .light()
          .textTheme
          .apply(fontFamily: 'MuseoSans', bodyColor: Colors.grey[800]),
    );

ThemeData carpStudyDarkTheme = ThemeData.dark().copyWith(
      primaryColor: Color(0xff81C7F3),
      accentColor: Color(0xff4C4C4C),
      textTheme: ThemeData
          .dark()
          .textTheme
          .apply(fontFamily: 'MuseoSans', bodyColor: Colors.grey[800]),
    );

ButtonTheme roundedFilledButtonTheme = ButtonTheme(
  height: 40,
  minWidth: 100,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  buttonColor: carpStudyTheme.primaryColor,
);

ButtonTheme flatButtonTheme = ButtonTheme(
  height: 40,
  minWidth: 100,
  buttonColor: carpStudyTheme.primaryColor,
);

TextStyle studyTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle readMoreStudyStyle = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle scoreNumberStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle scoreTextStyle = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle aboutCardTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle aboutCardInfoStyle = TextStyle(
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle aboutCardSubtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Color.fromRGBO(70, 70, 70, 1));

TextStyle aboutCardContentStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Color.fromRGBO(70, 70, 70, 0.7));

TextStyle sectionTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(70, 70, 70, 1));

TextStyle inputFieldStyle = TextStyle(fontSize: 15, color: Color(0xff707070));

TextStyle welcomeMessageStyle = TextStyle(
    fontSize: 24, color: Color(0xff707070), fontWeight: FontWeight.bold);

TextStyle studyDescriptionStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
