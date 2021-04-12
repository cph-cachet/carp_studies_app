import 'dart:math';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'random_recurrent_trigger.g.dart';

// TODO: missing triggering the times of _timesOfSampling

@JsonSerializable()

/// Triggers N times in a day in a defined period of time.
/// N is a random value between the min and max number specified.
/// The period of time is defined by a start time and and end time.
class RandomRecurrentTrigger extends Trigger {
  Time startTime;
  Time endTime;
  int maxNumberOfSampling;
  int minNumberOfSampling;

  // Daily
  Duration period = Duration(days: 1);

  /// Number of samples of the day
  int get numberOfSampling => Random().nextInt(maxNumberOfSampling) + minNumberOfSampling;

  /// List (of length = numberOfSampling) of the times of the sampling
  List<Time> get timesOfSampling => getTimesOfSampling();
  List<Time> _timesOfSampling;

  /// Generate N random times between startTime and endTime
  List<Time> getTimesOfSampling() {
    for (int i = 0; i <= numberOfSampling; i++) {
      int startMinutes = startTime.hour * 60 + startTime.minute;
      int endMinutes = endTime.hour * 60 + endTime.minute;
      int randomMinutes = Random().nextInt(endMinutes) + startMinutes;
      Time randomTime;
      randomTime.hour = randomMinutes ~/ 60;
      randomTime.minute = randomMinutes % 60;
      _timesOfSampling.add(randomTime);
    }
    return _timesOfSampling;
  }

  RandomRecurrentTrigger({
    String triggerId,
    @required minNumberOfSampling,
    @required maxNumberOfSampling,
    @required startTime,
    @required endTime,
  }) : super(triggerId: triggerId);

  Function get fromJsonFunction => _$RandomRecurrentTriggerFromJson;
  factory RandomRecurrentTrigger.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json[Serializable.CLASS_IDENTIFIER].toString(), json);
  Map<String, dynamic> toJson() => _$RandomRecurrentTriggerToJson(this);
}
