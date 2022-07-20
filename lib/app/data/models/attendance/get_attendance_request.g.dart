// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceRequest _$GetAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceRequest(
      accountId: json['accountId'] as String?,
      jobPostId: json['jobPostId'] as String?,
    );

Map<String, dynamic> _$GetAttendanceRequestToJson(
    GetAttendanceRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('jobPostId', instance.jobPostId);
  writeNotNull('accountId', instance.accountId);
  return val;
}
