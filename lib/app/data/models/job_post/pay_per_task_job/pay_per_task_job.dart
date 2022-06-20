

import 'package:json_annotation/json_annotation.dart';
part 'pay_per_task_job.g.dart';

@JsonSerializable(includeIfNull: false)
class PayPerTaskJob{

  @JsonKey(name: 'finish_time')
  DateTime finishTime;

  @JsonKey(name: 'salary')
  double salary;

  PayPerTaskJob({
    required this.finishTime,
    required this.salary
  });

  factory PayPerTaskJob.fromJson(Map<String, dynamic> json) => _$PayPerTaskJobFromJson(json);
  Map<String, dynamic> toJson() => _$PayPerTaskJobToJson(this);
}