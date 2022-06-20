// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_per_hour_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPerHourJob _$PayPerHourJobFromJson(Map<String, dynamic> json) =>
    PayPerHourJob(
      estimatedTotalTask: json['estimated_total_task'] as int,
      minFarmer: json['min_farmer'] as int,
      maxFarmer: json['max_farmer'] as int,
      salary: (json['salary'] as num).toDouble(),
      startTime: json['start_time'] as String,
      finishTime: json['finish_time'] as String,
    );

Map<String, dynamic> _$PayPerHourJobToJson(PayPerHourJob instance) =>
    <String, dynamic>{
      'estimated_total_task': instance.estimatedTotalTask,
      'min_farmer': instance.minFarmer,
      'max_farmer': instance.maxFarmer,
      'salary': instance.salary,
      'start_time': instance.startTime,
      'finish_time': instance.finishTime,
    };
