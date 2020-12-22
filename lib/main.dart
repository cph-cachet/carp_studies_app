library carp_study_app;

import 'dart:async';
import 'dart:math';

import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
import 'package:carp_backend/carp_backend.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_study_app/ui/carp_study_style.dart';
import 'package:carp_study_app/ui/widgets/carp_app_bar.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:research_package/research_package.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app.dart';
part 'blocs/app_bloc.dart';
part 'models/tasklist_page_model.dart';
part 'models/study_page_model.dart';
part 'sensing/sensing.dart';
part 'sensing/surveys.dart';
part 'ui/colors.dart';
part 'ui/pages/data_viz_page.dart';
part 'ui/pages/study_viz_page.dart';
part 'ui/pages/task_list_page.dart';
part 'ui/pages/study_overview_page.dart';
part 'ui/pages/contact_page.dart';
part 'ui/pages/profile_page.dart';
part 'ui/widgets/study_banner.dart';

void main() {
  runApp(CARPStudyApp());
}
