import 'package:test/test.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import '../lib/main.dart';

void main() {
  // creating an empty protocol to initialize json serialization
  CAMSStudyProtocol protocol = CAMSStudyProtocol();

  setUp(() async {});

  group("Local Study Protocol Manager", () {
    setUp(() async {
      // Create a new study protocol.
      protocol = await LocalStudyProtocolManager().getStudyProtocol('1234');
    });

    /// A very simple script/test which generates and prints the study protocol
    test(
        'CAMSStudyProtocol -> JSON', () async => print(toJsonString(protocol)));
  });
}
