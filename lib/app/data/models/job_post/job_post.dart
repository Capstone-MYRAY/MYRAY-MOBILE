import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/tree_jobs/tree_jobs.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

part 'job_post.g.dart';

@JsonSerializable(includeIfNull: false)
class JobPost {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'garden_id')
  int gardenId;

  @JsonKey(name: 'garden_name')
  String? gardenName;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'tree_jobs')
  List<TreeJobs> treeJobs;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'start_job_date')
  DateTime jobStartDate;

  @JsonKey(name: 'end_job_date')
  DateTime? jobEndDate;

  @JsonKey(name: 'num_publish_day')
  int numOfPublishDay;

  @JsonKey(name: 'published_by')
  int publishedBy;

  @JsonKey(name: 'published_name')
  String? publishedName;

  @JsonKey(name: 'published_date')
  DateTime publishedDate;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'updated_date')
  DateTime? updatedDate;

  @JsonKey(name: 'approved_by')
  int? approvedBy;

  @JsonKey(name: 'approved_name')
  String? approvedName;

  @JsonKey(name: 'approved_date')
  DateTime? approvedDate;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'status_work')
  int? workStatus;

  @JsonKey(name: 'reason_reject')
  String? rejectedReason;

  @JsonKey(name: 'post_type_id')
  int? postTypeId;

  @JsonKey(name: 'post_type_name')
  String? postTypeName;

  @JsonKey(name: 'total_pin_day')
  int? totalPinDay;

  @JsonKey(name: 'start_pin_date')
  DateTime? pinStartDate;

  @JsonKey(name: 'color')
  String? foregroundColor;

  @JsonKey(name: 'background')
  String? backgroundColor;

  @JsonKey(name: 'pay_per_hour_job')
  PayPerHourJob? payPerHourJob;

  @JsonKey(name: 'pay_per_task_job')
  PayPerTaskJob? payPerTaskJob;

  JobPost({
    required this.id,
    required this.gardenId,
    required this.title,
    required this.type,
    required this.jobStartDate,
    required this.numOfPublishDay,
    required this.publishedBy,
    required this.publishedDate,
    required this.createdDate,
    required this.status,
    required this.treeJobs,
    this.publishedName,
    this.gardenName,
    this.address,
    this.approvedBy,
    this.approvedDate,
    this.updatedDate,
    this.description,
    this.payPerHourJob,
    this.payPerTaskJob,
    this.workStatus,
    this.rejectedReason,
    this.postTypeId,
    this.backgroundColor,
    this.foregroundColor,
    this.jobEndDate,
    this.postTypeName,
    this.approvedName,
    this.totalPinDay,
    this.pinStartDate,
  });

  @override
  bool operator ==(Object other) {
    return other is JobPost && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory JobPost.fromJson(Map<String, dynamic> json) =>
      _$JobPostFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostToJson(this);

  String get workType => _workTypeAlias[type] ?? '';

  Color get jobPostStatusColor =>
      _jobPostStatusColor[status] ?? Colors.transparent;

  String get jobPostStatusString => _jobPostStatusString[status] ?? '';

  Color get jobPostWorkStatusColor =>
      _jobPostWorkStatusColor[workStatus] ?? Colors.transparent;

  String get jobPostWorkStatusString =>
      _jobPostWorkStatusString[workStatus] ?? '';

  String get treeTypes {
    if (treeJobs.isEmpty) {
      return '';
    }

    if (treeJobs.length == 1) {
      return treeJobs.first.type ?? '';
    }

    final buffer = StringBuffer();

    for (int i = 0; i < treeJobs.length; i++) {
      buffer.write(treeJobs[i].type!);
      if (i < treeJobs.length - 1) {
        buffer.write(', ');
      }
    }

    return buffer.toString();
  }
}

Map<String, String> _workTypeAlias = {
  'PayPerHourJob': AppStrings.payPerHour,
  'PayPerTaskJob': AppStrings.payPerTask,
};

Map<int, Color> _jobPostStatusColor = {
  JobPostStatus.pending.index: AppColors.warningColor,
  JobPostStatus.posted.index: AppColors.successColor,
  JobPostStatus.rejected.index: AppColors.errorColor,
  JobPostStatus.expired.index: AppColors.cancelColor,
  JobPostStatus.outOfDate.index: AppColors.cancelColor,
  JobPostStatus.cancel.index: AppColors.cancelColor,
  JobPostStatus.approved.index: AppColors.successColor,
};

Map<int, String> _jobPostStatusString = {
  JobPostStatus.pending.index: AppStrings.jobPostStatusPending,
  JobPostStatus.posted.index: AppStrings.jobPostStatusPosted,
  JobPostStatus.rejected.index: AppStrings.jobPostStatusRejected,
  JobPostStatus.expired.index: AppStrings.jobPostStatusExpired,
  JobPostStatus.outOfDate.index: AppStrings.jobPostStatusOutOfDate,
  JobPostStatus.cancel.index: AppStrings.jobPostStatusCancel,
  JobPostStatus.approved.index: AppStrings.jobPostStatusApproved,
};

Map<int, Color> _jobPostWorkStatusColor = {
  JobPostWorkStatus.pending.index: AppColors.warningColor,
  JobPostWorkStatus.started.index: AppColors.successColor,
  JobPostWorkStatus.done.index: AppColors.grey,
};

Map<int, String> _jobPostWorkStatusString = {
  JobPostWorkStatus.pending.index: AppStrings.jobPostWorkStatusPending,
  JobPostWorkStatus.started.index: AppStrings.jobPostWorkStatusStarted,
  JobPostWorkStatus.done.index: AppStrings.jobPostWorkStatusDone,
};
