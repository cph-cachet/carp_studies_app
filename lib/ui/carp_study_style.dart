part of '../../main.dart';

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
        bodySmall: ThemeData.light().textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
        bodyLarge: ThemeData.light().textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
        bodyMedium: ThemeData.light().textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
        titleMedium: ThemeData.light().textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: const Color(0xFF206FA2)),
        titleLarge: ThemeData.light().textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
        headlineMedium: ThemeData.light().textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
        labelLarge: ThemeData.light().textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.white),
      )
      .apply(
        fontFamily: 'MuseoSans',
        // bodyColor: Color.fromRGBO(112, 112, 112, 1),
      ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
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
        bodySmall: ThemeData.dark().textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
        bodyLarge: ThemeData.dark().textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
        bodyMedium: ThemeData.dark().textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
        titleMedium: ThemeData.dark().textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: const Color(0xff81C7F3),
            ),
        titleLarge: ThemeData.dark().textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
        headlineMedium: ThemeData.dark().textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
        labelLarge: ThemeData.dark().textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.grey.shade800),
      )
      .apply(
        fontFamily: 'MuseoSans',
        // bodyColor: Colors.grey.shade50,
      ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

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

TextStyle scoreNumberStyleSmall = const TextStyle(
    fontSize: 20,
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

TextStyle profileSectionStyle = const TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 2);

TextStyle aboutCardContentStyle =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle sectionTitleStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

TextStyle inputFieldStyle =
    const TextStyle(fontSize: 15, color: Color(0xff707070));

TextStyle welcomeMessageStyle = const TextStyle(
    fontSize: 24, color: Color(0xff707070), fontWeight: FontWeight.bold);

TextStyle studyDescriptionStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
TextStyle dataCardTitleStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1);
TextStyle measuresStyle =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
TextStyle legendStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

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

TextStyle timerStyle =
    const TextStyle(fontSize: 36, fontWeight: FontWeight.w600);

TextStyle studyNameStyle =
    const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800);
