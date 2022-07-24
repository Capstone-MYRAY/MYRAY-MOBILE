// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAttendanceRequest _$CheckAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    CheckAttendanceRequest(
      jobPostId: json['job_post_id'] as String,
      dateTime: DateTime.parse(json['date_attendance'] as String),
      accountId: json['account_id'] as String,
      signature: json['signature'] as String?,
      status: $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$CheckAttendanceRequestToJson(
    CheckAttendanceRequest instance) {
  final val = <String, dynamic>{
    'job_post_id': instance.jobPostId,
    'date_attendance': instance.dateTime.toIso8601String(),
    'account_id': instance.accountId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('signature', instance.signature);
  writeNotNull('status', _$AttendanceStatusEnumMap[instance.status]);
  return val;
}

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.absent: 'UnexcusedAbsent',
  AttendanceStatus.present: 'Present',
  AttendanceStatus.noAttendance: 'Future',
  AttendanceStatus.end: 'End',
  AttendanceStatus.dayOff: 'DayOff',
  AttendanceStatus.fired: 'Dismissed',
};
