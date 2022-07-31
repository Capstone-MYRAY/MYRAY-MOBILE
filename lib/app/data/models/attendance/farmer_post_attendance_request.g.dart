// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_post_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerPostAttendanceRequest _$FarmerPostAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    FarmerPostAttendanceRequest(
      jobPostId: json['job_post_id'] as int,
      dayOff: DateTime.parse(json['day_off'] as String),
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$FarmerPostAttendanceRequestToJson(
        FarmerPostAttendanceRequest instance) =>
    <String, dynamic>{
      'job_post_id': instance.jobPostId,
      'day_off': instance.dayOff.toIso8601String(),
      'reason': instance.reason,
    };
