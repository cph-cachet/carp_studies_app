part of carp_study_app;

class DialogTitle extends StatelessWidget {
  final String title;
  final String? deviceName;

  const DialogTitle({super.key, required this.title, this.deviceName});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return _buildDialogTitle(locale, title, context);
  }

  Widget _buildDialogTitle(
      RPLocalizations locale, String title, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).canPop() ? Navigator.of(context).pop() : null,
              icon: const Icon(Icons.close),
              padding: const EdgeInsets.only(right: 8),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    (deviceName != null
                            ? "${locale.translate(deviceName!)} "
                            : "") +
                        locale.translate(
                          title,
                        ),
                    style: sectionTitleStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
