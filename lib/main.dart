library carp_study_app;

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
import 'package:carp_backend/carp_backend.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_study_app/research_package_objects/informed_consent_objects.dart';
import 'package:carp_study_app/ui/carp_study_style.dart';
import 'package:carp_study_app/ui/widgets/carp_app_bar.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:research_package/research_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:expandable/expandable.dart';
import 'package:charts_flutter/flutter.dart' as charts;

part 'app.dart';
part 'first_screen.dart';
part 'blocs/app_bloc.dart';
part 'data/sensing.dart';
part 'data/surveys.dart';
part 'data/messages.dart';
part 'models/data_model.dart';
part 'models/tasklist_page_model.dart';
part 'models/study_page_model.dart';
part 'models/data_page_model.dart';
part 'models/cards/activity_data_model.dart';
part 'models/cards/mobility_data_model.dart';
part 'models/cards/steps_data_model.dart';
part 'models/cards/measures_data_model.dart';
part 'ui/colors.dart';
part 'ui/pages/data_viz_page.dart';
part 'ui/pages/study_viz_page.dart';
//part 'ui/pages/study_overview_page.dart';
part 'ui/pages/task_list_page.dart';
part 'ui/pages/contact_page.dart';
part 'ui/pages/profile_page.dart';
part 'ui/pages/informed_consent_page.dart';
part 'ui/widgets/study_banner.dart';
part 'ui/widgets/card_header.dart';
part 'ui/cards/steps_card.dart';
part 'ui/cards/activity_card.dart';
part 'ui/cards/mobility_card.dart';
part 'ui/cards/measures_card.dart';

void main() {
  runApp(CARPStudyApp());
}
