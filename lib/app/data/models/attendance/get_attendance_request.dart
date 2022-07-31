
import 'package:json_annotation/json_annotation.dart';
part 'get_attendance_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAttendanceRequest{

  @JsonKey(name: 'jobPostId')
  String? jobPostId;

  @JsonKey(name: 'accountId')
  String? accountId;

  GetAttendanceRequest({
    required this.accountId,
    required this.jobPostId
  });

  factory GetAttendanceRequest.fromJson(Map<String, dynamic> json) => _$GetAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAttendanceRequestToJson(this);
}