import 'dart:convert';
import 'dart:io';
import 'package:cognition_package/model.dart';

import 'package:carp_serializable/carp_serializable.dart';
import 'package:carp_connectivity_package/connectivity.dart';
import 'package:carp_esense_package/esense.dart';
import 'package:carp_context_package/carp_context_package.dart';
import 'package:carp_audio_package/media.dart';
// import 'package:carp_communication_package/communication.dart';
// import 'package:carp_apps_package/apps.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:research_package/model.dart';
// import 'package:carp_webservices/carp_auth/carp_auth.dart';
// import 'package:carp_webservices/carp_services/carp_services.dart';

import 'exports.dart';
// import 'credentials.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  StudyProtocol? protocol;

  setUp(() async {
    // Initialization of serialization
    CarpMobileSensing.ensureInitialized();
    ResearchPackage.ensureInitialized();
    CognitionPackage.ensureInitialized();
    CarpDataManager();

    // register the different sampling package since we're using measures from them
    SamplingPackageRegistry().register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    SamplingPackageRegistry().register(MediaSamplingPackage());
    // SamplingPackageRegistry().register(CommunicationSamplingPackage());
    // SamplingPackageRegistry().register(AppsSamplingPackage());
    SamplingPackageRegistry().register(ESenseSamplingPackage());
    SamplingPackageRegistry().register(PolarSamplingPackage());

    // generate the protocol to be used in testing below
    protocol ??= await LocalStudyProtocolManager()
        .getStudyProtocol('CARP Study App Demo v 1.1.0');
  });

  group("Local Study Protocol Manager", () {
    setUp(() async {});

    test('CAMSStudyProtocol -> JSON', () async {
      expect(toJsonString(protocol), isNotEmpty);
    });

    test('StudyProtocol -> JSON -> StudyProtocol :: deep assert', () async {
      final studyJson = toJsonString(protocol);

      SmartphoneStudyProtocol protocolFromJson =
          SmartphoneStudyProtocol.fromJson(
              json.decode(studyJson) as Map<String, dynamic>);
      expect(toJsonString(protocolFromJson), equals(studyJson));
    });

    test('JSON File -> StudyProtocol', () async {
      final plainJson =
          File('test/json/study_protocol.json').readAsStringSync();

      final p = SmartphoneStudyProtocol.fromJson(
          json.decode(plainJson) as Map<String, dynamic>);

      // need to set the id and date, since it is auto-generated each time.
      p.id = protocol!.id;
      p.createdOn = protocol!.createdOn;

      expect(toJsonString(protocol), toJsonString(p));
    });
  });

  group("Resource Generator Scripts", () {
    setUp(() async {});

    /// Generates and prints the local study protocol as json
    test('protocol -> JSON', () async {
      StudyProtocol? protocol =
          await LocalStudyProtocolManager().getStudyProtocol('1234');
      expect(toJsonString(protocol), isNotEmpty);
    });
  });
}
