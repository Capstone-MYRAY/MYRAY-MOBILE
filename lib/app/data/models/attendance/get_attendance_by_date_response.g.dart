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
      attendances: (json['attendances'] as List<dynamic>)
          .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      appliedFarmerStatus: json['status'] as int,
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$GetAttendanceByDateResponseToJson(
    GetAttendanceByDateResponse instance) {
  final val = <String, dynamic>{
    'job_post_id': instance.id,
    'status': instance.appliedFarmerStatus,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('end_date', instance.endDate?.toIso8601String());
  val['account'] = instance.farmer.toJson();
  val['attendances'] = instance.attendances.map((e) => e.toJson()).toList();
  return val;
}
