// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_per_task_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPerTaskJob _$PayPerTaskJobFromJson(Map<String, dynamic> json) =>
    PayPerTaskJob(
      finishTime: DateTime.parse(json['finish_time'] as String),
      salary: (json['salary'] as num).toDouble(),
    );

Map<String, dynamic> _$PayPerTaskJobToJson(PayPerTaskJob instance) =>
    <String, dynamic>{
      'finish_time': instance.finishTime.toIso8601String(),
      'salary': instance.salary,
    };
