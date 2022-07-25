
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
part 'attendance_response.g.dart';

@JsonSerializable(includeIfNull: false)
class AttendanceResponse{
  
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'date')
  DateTime date;

  @JsonKey(name: 'salary')
  double salary;

  @JsonKey(name: 'bonus_point')
  int bonusPoint;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'applied_job_id')
  int appliedJobId;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'account_id')
  int accountId;

  @JsonKey(name: 'fullname')
  String fullName;

  @JsonKey(name: 'phone_number')
  String phoneNumber;

  AttendanceResponse({
    required this.id,
    required this.date,
    required this.salary,
    required this.bonusPoint,
    required this.appliedJobId,
    required this.status,
    required this.accountId,
    required this.fullName,
    required this.phoneNumber,
    this.reason
  });

  String get statusString => _statusString[status] ?? AppStrings.noAttendance;
  Color get statusColor => _statusColor[status] ?? AppColors.grey;

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) => _$AttendanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);

  final Map<int, String> _statusString = {
  AttendanceStatus.absent.index: AppStrings.absent,
  AttendanceStatus.dayOff.index: AppStrings.dayOff,
  AttendanceStatus.end.index: AppStrings.end,
  AttendanceStatus.present.index: AppStrings.present,
  AttendanceStatus.fired.index: AppStrings.fired,
};

final Map<int, Color> _statusColor = {
  AttendanceStatus.absent.index: AppColors.errorColor,
  AttendanceStatus.dayOff.index: AppColors.warningColor,
  AttendanceStatus.end.index: AppColors.primaryColor,
  AttendanceStatus.present.index: AppColors.primaryColor,
  AttendanceStatus.fired.index: AppColors.grey,
};
}
