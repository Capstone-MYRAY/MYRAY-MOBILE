import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance.dart';

part 'get_attendance_by_date_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetAttendanceByDateResponse {
  @JsonKey(name: 'job_post_id')
  int id;

  @JsonKey(name: 'account')
  Account farmer;

  @JsonKey(name: 'attendances')
  List<Attendance> attendance;

  GetAttendanceByDateResponse({
    required this.farmer,
    required this.id,
    required this.attendance,
  });

  factory GetAttendanceByDateResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceByDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceByDateResponseToJson(this);
}
