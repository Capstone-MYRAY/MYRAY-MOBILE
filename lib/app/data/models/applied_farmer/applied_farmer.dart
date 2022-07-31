import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

part 'applied_farmer.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AppliedFarmer {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post')
  JobPost jobPost;

  @JsonKey(name: 'applied_date')
  DateTime appliedDate;

  @JsonKey(name: 'applied_by_navigation')
  Account userInfo;

  @JsonKey(name: 'status')
  int status;

  AppliedFarmer({
    required this.id,
    required this.jobPost,
    required this.userInfo,
    required this.appliedDate,
    required this.status,
  });

  @override
  bool operator ==(Object other) {
    return other is AppliedFarmer && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory AppliedFarmer.fromJson(Map<String, dynamic> json) =>
      _$AppliedFarmerFromJson(json);

  Map<String, dynamic> toJson() => _$AppliedFarmerToJson(this);

  String get statusString =>
      _appliedFarmerStatus[status] ?? AppStrings.appliedFarmerEnd;
  Color? get statusColor => _appliedFarmerColor[status];
}

Map<int, Color> _appliedFarmerColor = {
  AppliedFarmerStatus.pending.index: AppColors.warningColor,
  AppliedFarmerStatus.approved.index: AppColors.successColor,
  AppliedFarmerStatus.rejected.index: AppColors.errorColor,
  AppliedFarmerStatus.end.index: AppColors.grey,
  AppliedFarmerStatus.fired.index: AppColors.errorColor,
};

Map<int, String> _appliedFarmerStatus = {
  AppliedFarmerStatus.pending.index: AppStrings.appliedFarmerPending,
  AppliedFarmerStatus.approved.index: AppStrings.appliedFarmerApproved,
  AppliedFarmerStatus.rejected.index: AppStrings.appliedFarmerRejected,
  AppliedFarmerStatus.end.index: AppStrings.appliedFarmerEnd,
  AppliedFarmerStatus.fired.index: AppStrings.appliedFarmerFired,
};
