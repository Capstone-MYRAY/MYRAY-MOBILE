import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/status.dart';

part 'check_attendance_request.g.dart';

@JsonSerializable(includeIfNull: false)
class CheckAttendanceRequest {
  @JsonKey(name: 'job_post_id')
  String jobPostId;

  @JsonKey(name: 'date_attendance')
  DateTime dateTime;

  @JsonKey(name: 'account_id')
  String accountId;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'status')
  AttendanceStatus? status;

  CheckAttendanceRequest({
    required this.jobPostId,
    required this.dateTime,
    required this.accountId,
    this.signature,
    this.reason,
    this.status,
  });

  factory CheckAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckAttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAttendanceRequestToJson(this);
}
