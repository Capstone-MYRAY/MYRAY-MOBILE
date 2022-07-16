

import 'package:json_annotation/json_annotation.dart';
part 'farmer_post_attendance_request.g.dart';

@JsonSerializable(includeIfNull: false)
class FarmerPostAttendanceRequest{

@JsonKey(name: 'job_post_id')
int jobPostId;

@JsonKey(name: 'day_off')
DateTime dayOff;

@JsonKey(name: 'reason')
String reason;


FarmerPostAttendanceRequest({
required this.jobPostId,
required this.dayOff,
required this.reason
});

factory FarmerPostAttendanceRequest.fromJson(Map<String, dynamic> json) => _$FarmerPostAttendanceRequestFromJson(json);
Map<String, dynamic> toJson() => _$FarmerPostAttendanceRequestToJson(this);

}