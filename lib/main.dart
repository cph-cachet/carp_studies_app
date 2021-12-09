library carp_study_app;

import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart' hide TimeOfDay;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';

// the CARP packages
import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:carp_backend/carp_backend.dart';

import 'package:research_package/research_package.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

part 'blocs/app_bloc.dart';
part 'blocs/common.dart';

part 'data/local_settings.dart';
part 'data/carp_backend.dart';
part 'data/localization_loader.dart';

part 'sensing/local_surveys.dart';
part 'sensing/local_study_protocol_manager.dart';
part 'sensing/sensing.dart';

part 'models/data_model.dart';
part 'models/tasklist_page_model.dart';
part 'models/study_page_model.dart';
part 'models/profile_page_model.dart';
part 'models/data_viz_page_model.dart';
part 'models/cards/activity_data_model.dart';
part 'models/cards/mobility_data_model.dart';
part 'models/cards/steps_data_model.dart';
part 'models/cards/measures_data_model.dart';
part 'models/cards/task_data_model.dart';
part 'models/cards/study_progress_data_model.dart';

part 'models/audio_user_task.dart';
part 'data/local_resource_manager.dart';

part 'carp_study_app.dart';
part 'ui/pages/informed_consent_page.dart';
part 'ui/pages/home_page.dart';

part 'ui/widgets/carp_app_bar.dart';
part 'ui/carp_study_style.dart';
part 'ui/colors.dart';
part 'ui/pages/data_viz_page.dart';
part 'ui/pages/study_page.dart';
part 'ui/pages/task_list_page.dart';
part 'ui/pages/profile_page.dart';
part 'ui/pages/audio_task_page.dart';
part 'ui/pages/failed_login_page.dart';
part 'ui/pages/study_details_page.dart';
part 'ui/pages/message_details_page.dart';
part 'ui/pages/process_message_page.dart';

part 'ui/widgets/study_card.dart';
part 'ui/widgets/horizontal_bar.dart';
part 'ui/widgets/location_usage_dialog.dart';
part 'ui/widgets/charts_legend.dart';
part 'ui/widgets/carp_banner.dart';

part 'ui/cards/steps_card.dart';
part 'ui/cards/activity_card.dart';
part 'ui/cards/mobility_card.dart';
part 'ui/cards/measures_card.dart';
part 'ui/cards/task_card.dart';
part 'ui/cards/scoreboard_card.dart';
part 'ui/cards/study_progress_card.dart';

late CarpStudyApp app;
void main() async {
  // make sure that the json functions are loaded
  DomainJsonFactory();

  // make sure to have an instance of the WidgetsBinding, which is required
  // to use platform channels to call the native code
  // see also >> https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do/63873689
  WidgetsFlutterBinding.ensureInitialized();

  await bloc.initialize();

  app = CarpStudyApp();
  runApp(app);
}

/// The singleton BLoC.
///
/// Configure the debug level and deployment mode here before running the app
/// or deploying it.
final bloc = StudyAppBLoC(
  debugLevel: DebugLevel.DEBUG,
  deploymentMode: DeploymentMode.CARP_DEV,
  forceSignOutAndStudyReload: false,
);
