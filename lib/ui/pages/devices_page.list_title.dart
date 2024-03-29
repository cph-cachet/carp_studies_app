part of carp_study_app;

enum DevicesPageTypes {
  phone,
  services,
  devices,
}

class DevicesPageListTitle extends StatelessWidget {
  const DevicesPageListTitle({
    super.key,
    required this.locale,
    required this.type,
  });

  final RPLocalizations locale;
  final DevicesPageTypes type;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Text(
            locale.translate("pages.devices.${type.name}.title").toUpperCase(),
            style: dataCardTitleStyle.copyWith(
                color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
