part of carp_study_app;

ThemeData carpStudyTheme = ThemeData.light().copyWith(
  primaryColor: Color(0xFF206FA2),
  accentColor: Color(0xffcce8fa),
  hoverColor: Color(0xFFF1F9FF),
  textTheme: ThemeData.light()
      .textTheme
      .copyWith(
        caption: ThemeData.light().textTheme.caption!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 30.0,
            ),
        bodyText1: ThemeData.light().textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
        bodyText2: ThemeData.light().textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
      )
      .apply(
        fontFamily: 'MuseoSans',
        bodyColor: Color.fromRGBO(112, 112, 112, 1),
      ),
);

ThemeData carpStudyDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xff81C7F3),
  accentColor: Color(0xff4C4C4C),
  disabledColor: Color(0xffcce8fa),
  textTheme: ThemeData.dark()
      .textTheme
      .copyWith(
        caption: ThemeData.dark().textTheme.caption!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
            ),
        bodyText1: ThemeData.dark().textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
        bodyText2: ThemeData.dark().textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
      )
      .apply(
        fontFamily: 'MuseoSans',
        bodyColor: Colors.grey.shade50,
      ),
);

// ButtonTheme roundedFilledButtonTheme = ButtonTheme(
//   height: 40,
//   minWidth: 100,
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   buttonColor: carpStudyTheme.primaryColor,
// );

// ButtonTheme flatButtonTheme = ButtonTheme(
//   height: 40,
//   minWidth: 100,
//   buttonColor: carpStudyTheme.primaryColor,
// );

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

  static charts.RenderSpec<String> axisThemeOrdinal() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
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

TextStyle studyTitleStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle readMoreStudyStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

TextStyle scoreNumberStyle =
    TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Color.fromRGBO(32, 111, 162, 1));

TextStyle scoreTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle aboutCardTitleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

TextStyle aboutCardInfoStyle = TextStyle(fontSize: 14, fontStyle: FontStyle.italic);

TextStyle aboutCardSubtitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

TextStyle aboutCardContentStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle sectionTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

TextStyle inputFieldStyle = TextStyle(fontSize: 15, color: Color(0xff707070));

TextStyle welcomeMessageStyle =
    TextStyle(fontSize: 24, color: Color(0xff707070), fontWeight: FontWeight.bold);

TextStyle studyDescriptionStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
TextStyle dataCardTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1);
TextStyle measuresStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
TextStyle legendStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

TextStyle audioTitleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
TextStyle audioContentStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
TextStyle audioDescriptionStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
TextStyle audioInstructionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle profileTitleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
TextStyle profileActionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

TextStyle timerStyle = TextStyle(fontSize: 36, fontWeight: FontWeight.w600);
