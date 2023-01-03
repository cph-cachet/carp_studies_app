part of carp_study_app;

ThemeData carpStudyTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFF206FA2),
  colorScheme: const ColorScheme.light().copyWith(
      secondary: const Color(0xFFFAFAFA),
      primary: const Color(0xFF206FA2),
      tertiary: const ui.Color.fromARGB(255, 230, 230, 230)),
  //accentColor: Color(0xFFFAFAFA), //Color(0xffcce8fa),
  hoverColor: const Color(0xFFF1F9FF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  textTheme: ThemeData.light()
      .textTheme
      .copyWith(
        caption: ThemeData.light().textTheme.caption!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
        bodyText1: ThemeData.light().textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
        bodyText2: ThemeData.light().textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
        subtitle1: ThemeData.light().textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: const Color(0xFF206FA2)),
        headline6: ThemeData.light().textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
        headline4: ThemeData.light().textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
        button: ThemeData.light().textTheme.button!.copyWith(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
      )
      .apply(
        fontFamily: 'MuseoSans',
        // bodyColor: Color.fromRGBO(112, 112, 112, 1),
      ),
);

ThemeData carpStudyDarkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff81C7F3),
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: const Color(0xff4C4C4C),
    primary: const Color(0xff81C7F3),
    tertiary: (const Color(0xff4C4C4C)),
  ),
  // accentColor: Color(0xff4C4C4C),
  disabledColor: const Color(0xffcce8fa),
  textTheme: ThemeData.dark()
      .textTheme
      .copyWith(
        caption: ThemeData.dark().textTheme.caption!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
        bodyText1: ThemeData.dark().textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
        bodyText2: ThemeData.dark().textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
        subtitle1: ThemeData.dark().textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: const Color(0xff81C7F3),
            ),
        headline6: ThemeData.dark().textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
        headline4: ThemeData.dark().textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
        button: ThemeData.dark().textTheme.button!.copyWith(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.grey.shade800),
      )
      .apply(
        fontFamily: 'MuseoSans',
        // bodyColor: Colors.grey.shade50,
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
      lineStyle: const charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
      ),
    );
  }

  static charts.RenderSpec<DateTime> axisThemeDateTime() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: const charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
      ),
    );
  }
}

TextStyle studyTitleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle readMoreStudyStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700);

TextStyle scoreNumberStyle = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: Color.fromRGBO(32, 111, 162, 1));

TextStyle scoreTextStyle = const TextStyle(
    fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff77A8C8));

TextStyle aboutCardTitleStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

TextStyle aboutCardInfoStyle =
    const TextStyle(fontSize: 14, fontStyle: FontStyle.italic);

TextStyle aboutCardSubtitleStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

TextStyle profileSectionStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 2);

TextStyle aboutCardContentStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle sectionTitleStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

TextStyle inputFieldStyle = const TextStyle(fontSize: 15, color: Color(0xff707070));

TextStyle welcomeMessageStyle = const TextStyle(
    fontSize: 24, color: Color(0xff707070), fontWeight: FontWeight.bold);

TextStyle studyDescriptionStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
TextStyle dataCardTitleStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1);
TextStyle measuresStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
TextStyle legendStyle = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

TextStyle audioTitleStyle =
    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
TextStyle audioContentStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
TextStyle audioDescriptionStyle =
    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
TextStyle audioInstructionStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle profileTitleStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
TextStyle profileActionStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

TextStyle timerStyle = const TextStyle(fontSize: 36, fontWeight: FontWeight.w600);

TextStyle studyNameStyle =
    const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800);
