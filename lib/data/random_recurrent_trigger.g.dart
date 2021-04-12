// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_recurrent_trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomRecurrentTrigger _$RandomRecurrentTriggerFromJson(
    Map<String, dynamic> json) {
  return RandomRecurrentTrigger(
    triggerId: json['triggerId'] as String,
    minNumberOfSampling: json['minNumberOfSampling'],
    maxNumberOfSampling: json['maxNumberOfSampling'],
    startTime: json['startTime'],
    endTime: json['endTime'],
  )
    ..$type = json[r'$type'] as String
    ..tasks = (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..period = json['period'] == null
        ? null
        : Duration(microseconds: json['period'] as int);
}

Map<String, dynamic> _$RandomRecurrentTriggerToJson(
        RandomRecurrentTrigger instance) =>
    <String, dynamic>{
      r'$type': instance.$type,
      'triggerId': instance.triggerId,
      'tasks': instance.tasks,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'maxNumberOfSampling': instance.maxNumberOfSampling,
      'minNumberOfSampling': instance.minNumberOfSampling,
      'period': instance.period?.inMicroseconds,
    };
