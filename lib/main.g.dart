// GENERATED CODE - DO NOT MODIFY BY HAND

part of carp_study_app;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklySteps _$WeeklyStepsFromJson(Map<String, dynamic> json) => WeeklySteps()
  ..weeklySteps = (json['weekly_steps'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), e as int),
  );

Map<String, dynamic> _$WeeklyStepsToJson(WeeklySteps instance) =>
    <String, dynamic>{
      'weekly_steps':
          instance.weeklySteps.map((k, e) => MapEntry(k.toString(), e)),
    };
