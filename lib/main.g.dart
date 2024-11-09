// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      studyId: json['study_id'] as String?,
      studyDeploymentId: json['study_deployment_id'] as String?,
      deviceRoleName: json['device_role_name'] as String?,
      participantId: json['participant_id'] as String?,
      participantRoleName: json['participant_role_name'] as String?,
      hasInformedConsentBeenAccepted:
          json['has_informed_consent_been_accepted'] as bool? ?? false,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('study_id', instance.studyId);
  writeNotNull('study_deployment_id', instance.studyDeploymentId);
  writeNotNull('device_role_name', instance.deviceRoleName);
  writeNotNull('participant_id', instance.participantId);
  writeNotNull('participant_role_name', instance.participantRoleName);
  val['has_informed_consent_been_accepted'] =
      instance.hasInformedConsentBeenAccepted;
  return val;
}

WeeklyActivities _$WeeklyActivitiesFromJson(Map<String, dynamic> json) =>
    WeeklyActivities()
      ..activities = (json['activities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$ActivityTypeEnumMap, k),
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
            )),
      );

Map<String, dynamic> _$WeeklyActivitiesToJson(WeeklyActivities instance) =>
    <String, dynamic>{
      'activities': instance.activities.map((k, e) => MapEntry(
          _$ActivityTypeEnumMap[k]!,
          e.map((k, e) => MapEntry(k.toString(), e)))),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.IN_VEHICLE: 'IN_VEHICLE',
  ActivityType.ON_BICYCLE: 'ON_BICYCLE',
  ActivityType.RUNNING: 'RUNNING',
  ActivityType.STILL: 'STILL',
  ActivityType.WALKING: 'WALKING',
  ActivityType.UNKNOWN: 'UNKNOWN',
};

WeeklyMobility _$WeeklyMobilityFromJson(Map<String, dynamic> json) =>
    WeeklyMobility()
      ..weekMobility = (json['week_mobility'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k), DailyMobility.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$WeeklyMobilityToJson(WeeklyMobility instance) =>
    <String, dynamic>{
      'week_mobility':
          instance.weekMobility.map((k, e) => MapEntry(k.toString(), e)),
    };

DailyMobility _$DailyMobilityFromJson(Map<String, dynamic> json) =>
    DailyMobility(
      (json['weekday'] as num).toInt(),
      (json['places'] as num).toInt(),
      (json['home_stay'] as num).toInt(),
      (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyMobilityToJson(DailyMobility instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'places': instance.places,
      'home_stay': instance.homeStay,
      'distance': instance.distance,
    };

WeeklySteps _$WeeklyStepsFromJson(Map<String, dynamic> json) => WeeklySteps()
  ..weeklySteps = (json['weekly_steps'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
  );

Map<String, dynamic> _$WeeklyStepsToJson(WeeklySteps instance) =>
    <String, dynamic>{
      'weekly_steps':
          instance.weeklySteps.map((k, e) => MapEntry(k.toString(), e)),
    };

HourlyHeartRate _$HourlyHeartRateFromJson(Map<String, dynamic> json) =>
    HourlyHeartRate()
      ..hourlyHeartRate =
          (json['hourly_heart_rate'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k),
            HeartRateMinMaxPrHour.fromJson(e as Map<String, dynamic>)),
      )
      ..lastUpdated = DateTime.parse(json['last_updated'] as String)
      ..maxHeartRate = (json['max_heart_rate'] as num?)?.toDouble()
      ..minHeartRate = (json['min_heart_rate'] as num?)?.toDouble();

Map<String, dynamic> _$HourlyHeartRateToJson(HourlyHeartRate instance) {
  final val = <String, dynamic>{
    'hourly_heart_rate':
        instance.hourlyHeartRate.map((k, e) => MapEntry(k.toString(), e)),
    'last_updated': instance.lastUpdated.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('max_heart_rate', instance.maxHeartRate);
  writeNotNull('min_heart_rate', instance.minHeartRate);
  return val;
}

HeartRateMinMaxPrHour _$HeartRateMinMaxPrHourFromJson(
        Map<String, dynamic> json) =>
    HeartRateMinMaxPrHour(
      (json['min'] as num?)?.toDouble(),
      (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HeartRateMinMaxPrHourToJson(
    HeartRateMinMaxPrHour instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('min', instance.min);
  writeNotNull('max', instance.max);
  return val;
}
