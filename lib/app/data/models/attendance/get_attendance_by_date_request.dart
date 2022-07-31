import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_attendance_by_date_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAttendanceByDateRequest {
  @JsonKey(name: 'jobPostId')
  String jobPostId;

  @JsonKey(name: 'dateTime')
  DateTime date;

  @JsonKey(name: 'status')
  AttendanceStatus? status;

  GetAttendanceByDateRequest({
    required this.jobPostId,
    required this.date,
    this.status,
  });

  factory GetAttendanceByDateRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceByDateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceByDateRequestToJson(this);
}
