import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

part 'applied_job_response.g.dart';

@JsonSerializable(includeIfNull: false)
class AppliedJobResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post')
  JobPost jobPost;

  @JsonKey(name: 'applied_date')
  DateTime appliedDate;

  @JsonKey(name: 'applied_by_navigation')
  Account appliedByNavigation;

  @JsonKey(name: 'status')
  int status;

  AppliedJobResponse(
      {required this.id,
      required this.jobPost,
      required this.appliedDate,
      required this.appliedByNavigation,
      required this.status});

  factory AppliedJobResponse.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppliedJobResponseToJson(this);

  String get statusString => _statusString[status] ?? 'Chờ duyệt';
  Color get statusColor => _statusColor[status] ?? AppColors.grey;

  final Map<int, String> _statusString = {
    AppliedFarmerStatus.pending.index: 'Chờ duyệt',
    AppliedFarmerStatus.approved.index: 'Đã nhận',
    AppliedFarmerStatus.rejected.index: 'Từ chối',
    AppliedFarmerStatus.end.index: 'Hoàn thành',
    AppliedFarmerStatus.fired.index: 'Sa thải',
  };
  final Map<int, Color> _statusColor = {
    AppliedFarmerStatus.pending.index: Colors.blue,
    AppliedFarmerStatus.approved.index: AppColors.primaryColor,
    AppliedFarmerStatus.rejected.index: AppColors.errorColor,
    AppliedFarmerStatus.end.index: AppColors.warningColor,
    AppliedFarmerStatus.fired.index: AppColors.grey,
  };
}
