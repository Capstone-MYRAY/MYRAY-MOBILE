import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance.dart';

part 'get_attendance_by_date_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetAttendanceByDateResponse {
  @JsonKey(name: 'job_post_id')
  int id;

  @JsonKey(name: 'status')
  int appliedFarmerStatus;

  @JsonKey(name: 'end_date')
  DateTime? endDate;

  @JsonKey(name: 'account')
  Account farmer;

  @JsonKey(name: 'attendances')
  List<Attendance> attendances;

  GetAttendanceByDateResponse({
    required this.farmer,
    required this.id,
    required this.attendances,
    required this.appliedFarmerStatus,
    this.endDate,
  });

  factory GetAttendanceByDateResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceByDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceByDateResponseToJson(this);
}
