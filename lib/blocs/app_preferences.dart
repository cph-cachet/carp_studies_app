part of carp_study_app;

class AppPreferences {
  static Future<bool> hasSeenBluetoothConnectionInstructions() async {
    final prefs = await SharedPreferences.getInstance();
    print("PREFSINSTRUCTIONS ${prefs.getBool('hasSeenBluetoothConnectionInstructions') ?? false}" );
    return prefs.getBool('hasSeenBluetoothConnectionInstructions') ?? false;
  }

  static Future<void> setHasSeenBluetoothConnectionInstructions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenBluetoothConnectionInstructions', true);
  }

  static Future<bool> hasFilledExpectedParticipantData() async {
    final prefs = await SharedPreferences.getInstance();
    print("PREFSPARTICIPANT ${prefs.getBool('hasFilledExpectedParticipantData') ?? false}");
    return prefs.getBool('hasFilledExpectedParticipantData') ?? false;
  }

  static Future<void> setHasFilledExpectedParticipantData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasFilledExpectedParticipantData', true);
  }
}
