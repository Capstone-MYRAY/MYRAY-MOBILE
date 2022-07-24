import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

part 'attendance.g.dart';

@JsonSerializable(includeIfNull: false)
class Attendance {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'date')
  DateTime? date;

  @JsonKey(name: 'salary')
  double? salary;

  @JsonKey(name: 'bonus_point')
  int? bonusPoint;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'applied_job_id')
  int appliedJobId;

  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'account_id')
  int accountId;

  Attendance({
    required this.appliedJobId,
    required this.accountId,
    this.id,
    this.date,
    this.salary,
    this.bonusPoint,
    this.reason,
    this.status,
    this.signature,
  });

  String get statusString => _statusString[status] ?? AppStrings.noAttendance;
  Color get statusColor => _statusColor[status] ?? AppColors.grey;

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}

Map<int, String> _statusString = {
  AttendanceStatus.absent.index: AppStrings.absent,
  AttendanceStatus.dayOff.index: AppStrings.dayOff,
  AttendanceStatus.end.index: AppStrings.end,
  AttendanceStatus.present.index: AppStrings.present,
  AttendanceStatus.fired.index: AppStrings.fired,
};

Map<int, Color> _statusColor = {
  AttendanceStatus.absent.index: AppColors.errorColor,
  AttendanceStatus.dayOff.index: AppColors.warningColor,
  AttendanceStatus.end.index: AppColors.primaryColor,
  AttendanceStatus.present.index: AppColors.primaryColor,
  AttendanceStatus.fired.index: AppColors.grey,
};
