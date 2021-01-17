import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

ThemeData carpStudyTheme = ThemeData.light().copyWith(
  primaryColor: Color.fromRGBO(32, 111, 162, 1),
  accentColor: Color(0xFFF1F9FF),
  textTheme: ThemeData.light()
      .textTheme
      .apply(fontFamily: 'MuseoSans', bodyColor: Colors.grey[800]),
);

ThemeData carpStudyDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xff81C7F3),
  accentColor: Color(0xff4C4C4C),
  disabledColor: Color(0xffcce8fa),
  textTheme: ThemeData.dark()
      .textTheme
      .apply(fontFamily: 'MuseoSans', bodyColor: Color(0xff81C7F3)),
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

class AxisTheme {
  static charts.RenderSpec<num> axisThemeNum() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
    );
  }

  static charts.RenderSpec<DateTime> axisThemeDateTime() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
      ),
    );
  }
}

TextStyle studyTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle readMoreStudyStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

TextStyle scoreNumberStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle scoreTextStyle = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle aboutCardTitleStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

TextStyle aboutCardInfoStyle =
    TextStyle(fontSize: 12, fontStyle: FontStyle.italic);

TextStyle aboutCardSubtitleStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w300);

TextStyle aboutCardContentStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w300);

TextStyle sectionTitleStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

TextStyle inputFieldStyle = TextStyle(fontSize: 15, color: Color(0xff707070));

TextStyle welcomeMessageStyle = TextStyle(
    fontSize: 24, color: Color(0xff707070), fontWeight: FontWeight.bold);

TextStyle studyDescriptionStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
