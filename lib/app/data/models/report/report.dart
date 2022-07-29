import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

part 'report.g.dart';

@JsonSerializable(includeIfNull: false)
class Report {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'job_post_id')
  int? jobPostId;

  @JsonKey(name: 'job_post_title')
  String? jobPostTitle;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'resolve_content')
  String? resolveContent;

  @JsonKey(name: 'reported_id')
  int? reportedId;

  @JsonKey(name: 'reported_name')
  String? reportedName;

  @JsonKey(name: 'reported_phone')
  String? reportedPhone;

  @JsonKey(name: 'reported_avatar')
  String? reportedAvatar;

  @JsonKey(name: 'created_name')
  String? createdName;

  @JsonKey(name: 'created_by')
  int createdBy;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'resolved_date')
  DateTime? resolvedDate;

  @JsonKey(name: 'resolved_by')
  int? resolvedBy;

  @JsonKey(name: 'resolved_name')
  String? resolvedName;

  @JsonKey(name: 'status')
  int? status;

  Report({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.createdDate,
    required this.resolvedBy,
    this.status,
    this.jobPostId,
    this.resolveContent,
    this.reportedId,
    this.resolvedDate,
    this.resolvedName,
    this.reportedName,
    this.createdName,
    this.reportedAvatar,
    this.reportedPhone,
    this.jobPostTitle,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  String? get statusString => _statusString[status];
  Color? get statusColor => _statusColor[status];
}

Map<int, String> _statusString = {
  ReportStatus.pending.index: AppStrings.reportPending,
  ReportStatus.resolved.index: AppStrings.reportResolved,
};

Map<int, Color> _statusColor = {
  ReportStatus.pending.index: AppColors.warningColor,
  ReportStatus.resolved.index: AppColors.successColor,
};
