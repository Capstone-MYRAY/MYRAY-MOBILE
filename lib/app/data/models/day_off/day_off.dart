import 'package:json_annotation/json_annotation.dart';
part 'day_off.g.dart';

@JsonSerializable(includeIfNull: false)
class DayOff{
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'date')
  DateTime date;

  @JsonKey(name: 'salary')
  num salary;

  @JsonKey(name: 'bonus_point')
  int bonusPoint;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'applied_job_id')
  int appliedJobId;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'account_id')
  int accountId;

  @JsonKey(name: 'fullname')
  String fullname;

  @JsonKey(name: 'phone_number')
  String phoneNumber;

  DayOff({
    required this.id,
    required this.date,
    required this.salary,
    required this.bonusPoint,
    required this.status,
    required this.appliedJobId,
    this.reason,
    required this.accountId,
    required this.fullname,
    required this.phoneNumber
  });

  factory DayOff.fromJson(Map<String, dynamic> json) => _$DayOffFromJson(json);
  Map<String, dynamic> toJson() => _$DayOffToJson(this);
}
