part of carp_study_app;

extension StringExtension on String {
  String truncateTo(int maxLength) =>
      (length <= maxLength) ? this : '${substring(0, maxLength)}...';
}

extension Humanize on Duration {
  String humanize(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;

    // Convert the difference into a human-readable format
    if (inSeconds < 60) {
      return _pluralize(inSeconds, locale, 'seconds');
    } else if (inMinutes < 60) {
      return _pluralize(inMinutes, locale, 'minutes');
    } else if (inHours < 24) {
        return _pluralize(inHours, locale, 'hours');
    } else {
        return _pluralize(inDays, locale, 'days');
    }
  }

  String _pluralize(int n, RPLocalizations locale, String unit) {
    String translationKey = "pages.task_list.task.${unit}_remaining";

    if (n != 1) {
      translationKey += "_plural";
    }

    return "$n ${locale.translate(translationKey)}";
  }
}
