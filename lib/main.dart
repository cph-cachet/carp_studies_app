library carp_study_app;

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_study_app/data/random_recurrent_trigger.dart';
import 'package:carp_webservices/carp_service/carp_service.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:carp_webservices/carp_domain/carp_domain.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:carp_study_app/ui/carp_study_style.dart';
import 'package:carp_study_app/ui/widgets/carp_app_bar.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:research_package/research_package.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:expandable/expandable.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

//import 'package:json_annotation/json_annotation.dart';

part 'app.dart';
part 'first_screen.dart';
part 'blocs/app_bloc.dart';

part 'data/carp_backend.dart';
part 'data/study_manager.dart';
part 'data/surveys.dart';
part 'data/message_manager.dart';

part 'models/data_model.dart';
part 'models/tasklist_page_model.dart';
part 'models/study_page_model.dart';
part 'models/data_viz_page_model.dart';
part 'models/cards/activity_data_model.dart';
part 'models/cards/mobility_data_model.dart';
part 'models/cards/steps_data_model.dart';
part 'models/cards/measures_data_model.dart';
part 'models/cards/surveys_data_model.dart';
part 'models/cards/audio_data_model.dart';
part 'models/cards/study_progress_data_model.dart';

part 'models/audio_user_task.dart';
part 'research_package_objects/informed_consent_objects.dart';

part 'ui/colors.dart';
part 'ui/pages/data_viz_page.dart';
part 'ui/pages/study_page.dart';
part 'ui/pages/task_list_page.dart';
part 'ui/pages/contact_page.dart';
part 'ui/pages/profile_page.dart';
part 'ui/pages/informed_consent_page.dart';
part 'ui/pages/audio_task_page.dart';
part 'ui/pages/timer_task_page.dart';
part 'ui/pages/question.dart';

part 'ui/widgets/study_banner.dart';
part 'ui/widgets/card_header.dart';
part 'ui/widgets/study_card.dart';

part 'ui/cards/steps_card.dart';
part 'ui/cards/activity_card.dart';
part 'ui/cards/mobility_card.dart';
part 'ui/cards/measures_card.dart';
part 'ui/cards/surveys_card.dart';
part 'ui/cards/audio_card.dart';
part 'ui/cards/scoreboard_card.dart';
part 'ui/cards/study_progress_card.dart';

void main() async {
  runApp(CARPStudyApp());
}
