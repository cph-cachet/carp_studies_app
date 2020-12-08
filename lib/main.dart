library carp_study_app;

import 'dart:async';

import 'package:carp_audio_package/audio.dart';
//import 'package:carp_health_package/health_package.dart';
import 'package:carp_backend/carp_backend.dart';
//import 'package:carp_connectivity_package/connectivity.dart';
//import 'package:carp_communication_package/communication.dart';
import 'package:carp_context_package/context.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:research_package/research_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'app.dart';
part 'blocs/sensing_bloc.dart';
part 'blocs/settings_bloc.dart';
part 'models/data_models.dart';
part 'models/probe_description.dart';
part 'models/study_model.dart';
part 'sensing/sensing.dart';
part 'sensing/surveys.dart';
part 'ui/cachet.dart';
part 'ui/data_viz_page.dart';
part 'ui/study_viz_page.dart';
part 'ui/task_list_page.dart';

void main() {
  runApp(CARPStudyApp());
}
