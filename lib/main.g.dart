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
          _$ActivityTypeEnumMap[k],
          e.map((k, e) => MapEntry(k.toString(), e)))),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.IN_VEHICLE: 'IN_VEHICLE',
  ActivityType.ON_BICYCLE: 'ON_BICYCLE',
  ActivityType.ON_FOOT: 'ON_FOOT',
  ActivityType.RUNNING: 'RUNNING',
  ActivityType.STILL: 'STILL',
  ActivityType.TILTING: 'TILTING',
  ActivityType.UNKNOWN: 'UNKNOWN',
  ActivityType.WALKING: 'WALKING',
  ActivityType.INVALID: 'INVALID',
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
