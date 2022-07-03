import 'package:json_annotation/json_annotation.dart';

part 'pay_per_task_job.g.dart';

@JsonSerializable(includeIfNull: false)
class PayPerTaskJob {
  @JsonKey(name: 'finish_time')
  DateTime? finishTime;

  @JsonKey(name: 'salary')
  double salary;

  @JsonKey(name: 'is_farm_tools_avaiable')
  bool? isFarmToolsAvaiable;

  PayPerTaskJob(
      {required this.salary, this.finishTime, this.isFarmToolsAvaiable});

  factory PayPerTaskJob.fromJson(Map<String, dynamic> json) =>
      _$PayPerTaskJobFromJson(json);
  Map<String, dynamic> toJson() => _$PayPerTaskJobToJson(this);
}
