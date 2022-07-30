// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_off.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayOff _$DayOffFromJson(Map<String, dynamic> json) => DayOff(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      salary: json['salary'] as num,
      bonusPoint: json['bonus_point'] as int,
      status: json['status'] as int,
      appliedJobId: json['applied_job_id'] as int,
      appliedJobTitle: json['applied_job_title'] as String,
      reason: json['reason'] as String?,
      createdDateJob: json['created_date_job'] == null
          ? null
          : DateTime.parse(json['created_date_job'] as String),
      accountId: json['account_id'] as int,
      fullname: json['fullname'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$DayOffToJson(DayOff instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'date': instance.date.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_date_job', instance.createdDateJob?.toIso8601String());
  val['salary'] = instance.salary;
  val['bonus_point'] = instance.bonusPoint;
  val['status'] = instance.status;
  val['applied_job_id'] = instance.appliedJobId;
  val['applied_job_title'] = instance.appliedJobTitle;
  writeNotNull('reason', instance.reason);
  val['account_id'] = instance.accountId;
  val['fullname'] = instance.fullname;
  val['phone_number'] = instance.phoneNumber;
  return val;
}
