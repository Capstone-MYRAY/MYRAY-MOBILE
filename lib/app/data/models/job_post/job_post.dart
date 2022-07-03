import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/tree_jobs/tree_jobs.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

part 'job_post.g.dart';

Map<String, String> _workTypeAlias = {
  'PayPerHourJob': AppStrings.payPerHour,
  'PayPerTaskJob': AppStrings.payPerTask,
};

@JsonSerializable(includeIfNull: false)
class JobPost {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'garden_id')
  int gardenId;

  @JsonKey(name: 'garden_name')
  String gardenName;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'tree_jobs')
  List<TreeJobs> treeJobs;

  @JsonKey(name: 'address')
  String address;

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
  String publishedName;

  @JsonKey(name: 'published_date')
  DateTime publishedDate;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'updated_date')
  DateTime? updatedDate;

  @JsonKey(name: 'approved_by')
  int? approvedBy;

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
    required this.gardenName,
    required this.title,
    required this.type,
    required this.jobStartDate,
    required this.numOfPublishDay,
    required this.publishedBy,
    required this.publishedName,
    required this.publishedDate,
    required this.createdDate,
    required this.status,
    required this.address,
    required this.treeJobs,
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
  });

  factory JobPost.fromJson(Map<String, dynamic> json) =>
      _$JobPostFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostToJson(this);

  String get workType => _workTypeAlias[type] ?? '';
}
