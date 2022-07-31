// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      appliedJobId: json['applied_job_id'] as int,
      accountId: json['account_id'] as int,
      id: json['id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      salary: (json['salary'] as num?)?.toDouble(),
      bonusPoint: json['bonus_point'] as int?,
      reason: json['reason'] as String?,
      status: json['status'] as int?,
      signature: json['signature'] as String?,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('salary', instance.salary);
  writeNotNull('bonus_point', instance.bonusPoint);
  writeNotNull('signature', instance.signature);
  writeNotNull('status', instance.status);
  val['applied_job_id'] = instance.appliedJobId;
  writeNotNull('reason', instance.reason);
  val['account_id'] = instance.accountId;
  return val;
}
