// GENERATED CODE - DO NOT MODIFY BY HAND

part of carp_study_app;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyActivities _$WeeklyActivitiesFromJson(Map<String, dynamic> json) =>
    WeeklyActivities()
      ..activities = (json['activities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$ActivityTypeEnumMap, k),
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(int.parse(k), e as int),
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
      ..weeklyHomeStay = (json['weekly_home_stay'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      )
      ..weeklyPlaces = (json['weekly_places'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      )
      ..weeklyDistanceTraveled =
          (json['weekly_distance_traveled'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
      );

Map<String, dynamic> _$WeeklyMobilityToJson(WeeklyMobility instance) =>
    <String, dynamic>{
      'weekly_home_stay':
          instance.weeklyHomeStay.map((k, e) => MapEntry(k.toString(), e)),
      'weekly_places':
          instance.weeklyPlaces.map((k, e) => MapEntry(k.toString(), e)),
      'weekly_distance_traveled': instance.weeklyDistanceTraveled
          .map((k, e) => MapEntry(k.toString(), e)),
    };

WeeklySteps _$WeeklyStepsFromJson(Map<String, dynamic> json) => WeeklySteps()
  ..weeklySteps = (json['weekly_steps'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), e as int),
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
      ..currentHeartRate = (json['current_heart_rate'] as num?)?.toDouble()
      ..maxHeartRate = (json['max_heart_rate'] as num).toDouble()
      ..minHeartRate = (json['min_heart_rate'] as num).toDouble();

Map<String, dynamic> _$HourlyHeartRateToJson(HourlyHeartRate instance) {
  final val = <String, dynamic>{
    'hourly_heart_rate':
        instance.hourlyHeartRate.map((k, e) => MapEntry(k.toString(), e)),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('current_heart_rate', instance.currentHeartRate);
  val['max_heart_rate'] = instance.maxHeartRate;
  val['min_heart_rate'] = instance.minHeartRate;
  return val;
}

HeartRateMinMaxPrHour _$HeartRateMinMaxPrHourFromJson(
        Map<String, dynamic> json) =>
    HeartRateMinMaxPrHour(
      (json['min'] as num).toDouble(),
      (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$HeartRateMinMaxPrHourToJson(
        HeartRateMinMaxPrHour instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
