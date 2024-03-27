part of carp_study_app;

class EnableInternetConnectionDialog extends StatelessWidget {
  const EnableInternetConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 4),
        insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        title: const DialogTitle(
            title:
                "pages.login.internet_connection.enable_internet_connections.title"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: enableInternetConnectionInstructions(context),
        ));
  }

  Widget enableInternetConnectionInstructions(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  locale.translate(
                      "pages.login.internet_connection.enable_internet_connections.message1"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      locale.translate(
                          "pages.login.internet_connection.enable_internet_connections.message2"),
                      style: aboutCardContentStyle,
                      textAlign: TextAlign.justify,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage('assets/instructions/enable_wifi.png'),
                  ),
                ),

                /// TODO: Localise this image, take a screenshot of the settings page in Danish
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    locale.translate(
                        "pages.login.internet_connection.enable_internet_connections.message3"),
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/instructions/enable_mobile_data.jpg'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.canPop() ? context.pop() : null,
                      child: Text(
                        locale.translate("pages.devices.connection.ok"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        switch(OpenSettingsPlus.shared) {
                          case OpenSettingsPlusAndroid(): OpenSettingsPlusAndroid().wifi();
                          case OpenSettingsPlusIOS(): OpenSettingsPlusIOS().wifi();
                        }
                      },
                      child: Text('Wi-Fi'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
