library carp_study_app;

import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:json_annotation/json_annotation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';

// the CARP packages
import 'package:carp_serializable/carp_serializable.dart';
import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_audio_package/media.dart';
//import 'package:carp_health_package/health_package.dart';
//import 'package:carp_connectivity_package/connectivity.dart' as carpcon;
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/carp_context_package.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:carp_esense_package/esense.dart';
import 'package:carp_polar_package/carp_polar_package.dart';
import 'package:research_package/research_package.dart';
import 'package:cognition_package/cognition_package.dart';

part 'blocs/app_bloc.dart';
part 'blocs/common.dart';

part 'data/local_settings.dart';
part 'data/carp_backend.dart';
part 'data/localization_loader.dart';
part 'data/local_resource_manager.dart';

part 'sensing/local_surveys.dart';
part 'sensing/local_study_protocol_manager.dart';
part 'sensing/sensing.dart';

part 'view_models/view_model.dart';
part 'view_models/tasklist_page_model.dart';
part 'view_models/study_page_model.dart';
part 'view_models/profile_page_model.dart';
part 'view_models/devices_page_model.dart';
part 'view_models/data_viz_page_model.dart';
part 'view_models/cards/activity_data_model.dart';
part 'view_models/cards/mobility_data_model.dart';
part 'view_models/cards/steps_data_model.dart';
part 'view_models/cards/heart_rate_data_model.dart';
part 'view_models/cards/measures_data_model.dart';
part 'view_models/cards/task_data_model.dart';
part 'view_models/cards/study_progress_data_model.dart';
part 'view_models/user_tasks.dart';

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
part 'ui/pages/camera_task_page.dart';
part 'ui/pages/display_picture_page.dart';
part 'ui/pages/camera_page.dart';
part 'ui/pages/devices_page.dart';

part 'ui/widgets/study_card.dart';
part 'ui/widgets/horizontal_bar.dart';
part 'ui/widgets/location_usage_dialog.dart';
part 'ui/widgets/charts_legend.dart';
part 'ui/widgets/details_banner.dart';

part 'ui/cards/steps_card.dart';
part 'ui/cards/heart_rate_card.dart';
part 'ui/cards/activity_card.dart';
part 'ui/cards/mobility_card.dart';
part 'ui/cards/measures_card.dart';
part 'ui/cards/task_card.dart';
part 'ui/cards/media_card.dart';
part 'ui/cards/scoreboard_card.dart';
part 'ui/cards/study_progress_card.dart';
part 'ui/pages/loading_page.dart';
part 'ui/pages/setup_page.dart';
part 'ui/pages/cans_login_android.dart';
part 'ui/pages/cans_login_ios.dart';

part 'main.g.dart';

late CarpStudyApp app;
void main() async {
  // initialize CAMS and Cognition Packages (loading json deserialization functions)
  CarpMobileSensing();
  CognitionPackage();

  // make sure to have an instance of the WidgetsBinding, which is required
  // to use platform channels to call native code
  // see also >> https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do/63873689
  WidgetsFlutterBinding.ensureInitialized();

  await bloc.initialize();

  app = const CarpStudyApp();
  runApp(app);
}

/// The singleton BLoC.
///
/// Configure the debug level and deployment mode here before running the app
/// or deploying it.
final bloc = StudyAppBLoC(
  debugLevel: DebugLevel.DEBUG,
  deploymentMode: DeploymentMode.local,
  forceSignOutAndStudyReload: false,
);
