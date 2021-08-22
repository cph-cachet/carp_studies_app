//import 'package:carp_backend/carp_backend.dart';
import 'package:test/test.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:research_package/research_package.dart';
import 'package:carp_core/carp_common/carp_core_common.dart';
import 'package:carp_core/carp_protocols/carp_core_protocols.dart';
// import 'package:carp_core/carp_deployment/carp_core_deployment.dart';
// import 'package:carp_core/carp_client/carp_core_client.dart';
// import 'package:carp_core/carp_data/carp_core_data.dart';

import '../lib/main.dart';

void main() {
  // creating an empty protocol to initialize json serialization
  StudyProtocol protocol;
  RPOrderedTask informedConsent;
  StudyDescription description;

  setUp(() async {
    Settings().saveAppTaskQueue = false;

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
      protocol = await LocalStudyProtocolManager().getStudyProtocol('1234')
          as StudyProtocol;
      print(toJsonString(protocol));
    });

    /// Generates and prints the local study description as json
    test('study description -> JSON', () async {
      description = await LocalResourceManager().getStudyDescription()
          as StudyDescription;
      print(toJsonString(description));
    });

    /// Generates and prints the local informed consent as json
    test('informed consent -> JSON', () async {
      informedConsent =
          await LocalResourceManager().getInformedConsent() as RPOrderedTask;
      print(toJsonString(informedConsent));
    });
  });
}
