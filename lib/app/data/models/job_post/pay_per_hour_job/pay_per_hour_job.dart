
import 'package:json_annotation/json_annotation.dart';
part 'pay_per_hour_job.g.dart';

@JsonSerializable(includeIfNull: false)
class PayPerHourJob{

  @JsonKey(name: 'estimated_total_task')
  int estimatedTotalTask;

  @JsonKey(name: 'min_farmer')
  int minFarmer;

  @JsonKey(name: 'max_farmer')
  int maxFarmer;

  @JsonKey(name: 'salary')
  double salary;

  @JsonKey(name: 'start_time') 
  String startTime;

  @JsonKey(name: 'finish_time')
  String finishTime;

  PayPerHourJob({
    required this.estimatedTotalTask,
    required this.minFarmer,
    required this.maxFarmer,
    required this.salary,
    required this.startTime,
    required this.finishTime
  });

  factory PayPerHourJob.fromJson(Map<String, dynamic> json) => _$PayPerHourJobFromJson(json);

  Map<String, dynamic> toJson() => _$PayPerHourJobToJson(this);
}