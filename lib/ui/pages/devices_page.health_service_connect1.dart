part of carp_study_app;

class HealthServiceConnectPage1 extends StatelessWidget {
  const HealthServiceConnectPage1({super.key});

  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                child: const CarpAppBar(hasProfileIcon: true),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          Platform.isAndroid
                              ? 'assets/instructions/google_health_connect_icon.png'
                              : 'assets/instructions/apple_health_icon.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        Platform.isAndroid
                            ? locale.translate(
                                "pages.devices.type.health.instructions.page1.android")
                            : locale.translate(
                                "pages.devices.type.health.instructions.page1.ios"),
                        style: healthServiceConnectTitleStyle.copyWith(
                            color: Theme.of(context)
                                .extension<CarpColors>()!
                                .primary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${locale.translate("pages.devices.type.health.instructions.page1.part1")} "
                        "${Platform.isAndroid ? locale.translate("pages.devices.type.health.instructions.page1.android") : locale.translate("pages.devices.type.health.instructions.page1.ios")} "
                        "${locale.translate("pages.devices.type.health.instructions.page1.part2")}",
                        style: healthServiceConnectMessageStyle.copyWith(
                            color: Theme.of(context)
                                .extension<CarpColors>()!
                                .grey900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) =>
                                        HealthServiceConnectPage2()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .extension<CarpColors>()!
                                  .primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                            ),
                            child: Text(locale.translate("Next"),
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
