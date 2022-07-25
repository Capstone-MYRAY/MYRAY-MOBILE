// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceResponse _$AttendanceResponseFromJson(Map<String, dynamic> json) =>
    AttendanceResponse(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      salary: (json['salary'] as num).toDouble(),
      bonusPoint: json['bonus_point'] as int,
      appliedJobId: json['applied_job_id'] as int,
      status: json['status'] as int,
      accountId: json['account_id'] as int,
      fullName: json['fullname'] as String,
      phoneNumber: json['phone_number'] as String,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$AttendanceResponseToJson(AttendanceResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'date': instance.date.toIso8601String(),
    'salary': instance.salary,
    'bonus_point': instance.bonusPoint,
    'status': instance.status,
    'applied_job_id': instance.appliedJobId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reason', instance.reason);
  val['account_id'] = instance.accountId;
  val['fullname'] = instance.fullName;
  val['phone_number'] = instance.phoneNumber;
  return val;
}
