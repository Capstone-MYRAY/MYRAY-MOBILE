// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendance_by_date_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceByDateRequest _$GetAttendanceByDateRequestFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceByDateRequest(
      jobPostId: json['jobPostId'] as String,
      date: DateTime.parse(json['dateTime'] as String),
      status: $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$GetAttendanceByDateRequestToJson(
    GetAttendanceByDateRequest instance) {
  final val = <String, dynamic>{
    'jobPostId': instance.jobPostId,
    'dateTime': instance.date.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
