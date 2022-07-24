// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendance_by_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceByDateResponse _$GetAttendanceByDateResponseFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceByDateResponse(
      farmer: Account.fromJson(json['account'] as Map<String, dynamic>),
      id: json['job_post_id'] as int,
      attendance: (json['attendances'] as List<dynamic>)
          .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      appliedFarmerStatus: json['status'] as int,
    );

Map<String, dynamic> _$GetAttendanceByDateResponseToJson(
        GetAttendanceByDateResponse instance) =>
    <String, dynamic>{
      'job_post_id': instance.id,
      'status': instance.appliedFarmerStatus,
      'account': instance.farmer.toJson(),
      'attendances': instance.attendance.map((e) => e.toJson()).toList(),
    };
