import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
part 'extend_end_date_job.g.dart';

@JsonSerializable(includeIfNull: false)
class ExtendEndDateJob {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'job_title')
  String? jobTitle;

  @JsonKey(name: 'request_by')
  int requestBy;

  @JsonKey(name: 'approved_by')
  int? approvedBy;

  @JsonKey(name: 'created_date')
  DateTime? createdDate;

  @JsonKey(name: 'approved_date')
  DateTime? approvedDate;

  @JsonKey(name: 'old_end_date')
  DateTime oldEndDate;

  @JsonKey(name: 'extend_end_date')
  DateTime extendEndDate;

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'fullname_request')
  String? requestedName;

  @JsonKey(name: 'phone_request')
  String? requestedPhone;

  @JsonKey(name: 'avatar_request')
  String? requestedAvatar;

  ExtendEndDateJob({
    required this.id,
    required this.jobPostId,
    required this.requestBy,
    required this.oldEndDate,
    required this.extendEndDate,
    required this.reason,
    required this.status,
    this.requestedName,
    this.requestedPhone,
    this.requestedAvatar,
    this.createdDate,
    this.jobTitle,
    this.approvedBy,
    this.approvedDate,
  });

  factory ExtendEndDateJob.fromJson(Map<String, dynamic> json) =>
      _$ExtendEndDateJobFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendEndDateJobToJson(this);

  String? get statusString => _statusString[status];
  Color? get statusColor => _statusColor[status];
}

Map<int, String> _statusString = {
  ExtendJobEndDateStatus.approved.index: 'Đã duyệt',
  ExtendJobEndDateStatus.rejected.index: 'Đã từ chối',
};

Map<int, Color> _statusColor = {
  ExtendJobEndDateStatus.approved.index: AppColors.successColor,
  ExtendJobEndDateStatus.rejected.index: AppColors.errorColor,
};
