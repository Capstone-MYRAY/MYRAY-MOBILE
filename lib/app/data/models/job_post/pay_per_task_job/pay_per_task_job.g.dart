// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_per_task_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPerTaskJob _$PayPerTaskJobFromJson(Map<String, dynamic> json) =>
    PayPerTaskJob(
      finishTime: DateTime.parse(json['finish_time'] as String),
      salary: (json['salary'] as num).toDouble(),
      isFarmToolsAvaiable: json['is_farm_tools_avaiable'] as bool?,
    );

Map<String, dynamic> _$PayPerTaskJobToJson(PayPerTaskJob instance) {
  final val = <String, dynamic>{
    'finish_time': instance.finishTime.toIso8601String(),
    'salary': instance.salary,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('is_farm_tools_avaiable', instance.isFarmToolsAvaiable);
  return val;
}
