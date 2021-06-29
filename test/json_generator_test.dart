import 'package:test/test.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:research_package/research_package.dart';

import '../lib/main.dart';

void main() {
  // creating an empty protocol to initialize json serialization
  CAMSStudyProtocol protocol = CAMSStudyProtocol();
  RPOrderedTask informedConsent;

  setUp(() async {
    // create and register external sampling packages
    //SamplingPackageRegistry.register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    //SamplingPackageRegistry.register(CommunicationSamplingPackage());
    SamplingPackageRegistry().register(AudioSamplingPackage());
    SamplingPackageRegistry().register(SurveySamplingPackage());
    //SamplingPackageRegistry.register(HealthSamplingPackage());
  });

  group("JSON Generator Scripts", () {
    setUp(() async {});

    /// Generates and prints the local study protocol as json
    test('protocol -> JSON', () async {
      protocol = await LocalStudyProtocolManager().getStudyProtocol('1234');
      print(toJsonString(protocol));
    });

    test('informed consent -> JSON', () async {
      informedConsent = await LocalResourceManager().getInformedConsent();
      print(toJsonString(informedConsent));
    });
  });
}
