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
          child: (() {
            switch (OpenSettingsPlus.shared) {
              case OpenSettingsPlusAndroid():
                return enableInternetConnectionInstructionsAndroid(context);
              case OpenSettingsPlusIOS():
                return enableInternetConnectionInstructionsIOS(context);
            }
          }()),
        ));
  }

  Widget enableInternetConnectionInstructionsAndroid(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  locale.translate(
                      "pages.login.internet_connection.enable_internet_connections.general_message"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      locale.translate(
                          "pages.login.internet_connection.enable_internet_connections.wifi_message"),
                      style: aboutCardContentStyle,
                      textAlign: TextAlign.justify,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/instructions/enable_wifi_android.png'),
                  ),
                ),

                /// TODO: Localise this image, take a screenshot of the settings page in Danish
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    locale.translate(
                        "pages.login.internet_connection.enable_internet_connections.mobile_data_message_android"),
                    style: aboutCardContentStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/instructions/enable_mobile_data_android.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              TextButton(
                onPressed: () => OpenSettingsPlusAndroid().wifi(),
                child: Text('Wi-Fi'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget enableInternetConnectionInstructionsIOS(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  locale.translate(
                      "pages.login.internet_connection.enable_internet_connections.general_message"),
                  style: aboutCardContentStyle,
                  textAlign: TextAlign.justify,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      locale.translate(
                          "pages.login.internet_connection.enable_internet_connections.wifi_message"),
                      style: aboutCardContentStyle,
                      textAlign: TextAlign.justify,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image:
                        AssetImage('assets/instructions/enable_wifi_ios.png'),
                  ),
                ),

                /// TODO: Localise this image, take a screenshot of the settings page in Danish
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(children: [
                    Text(
                      locale.translate(
                          "pages.login.internet_connection.enable_internet_connections.mobile_data_message_ios"),
                      style: aboutCardContentStyle,
                      textAlign: TextAlign.justify,
                    ),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/instructions/enable_mobile_data_ios.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.canPop() ? context.pop() : null;
                  OpenSettingsPlusIOS().wifi();
                },
                child: Text('Wi-Fi'),
              ),
              TextButton(
                onPressed: () {
                  context.canPop() ? context.pop() : null;
                  OpenSettingsPlusIOS().cellular();
                },
                child: Text('Data'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
