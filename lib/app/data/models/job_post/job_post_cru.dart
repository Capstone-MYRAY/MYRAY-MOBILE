import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/tree_jobs/tree_jobs.dart';

part 'job_post_cru.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class JobPostCru {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'garden_id')
  int gardenId;

  @JsonKey(name: 'tree_jobs')
  List<TreeJobs> treeJobs;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'start_job_date')
  DateTime jobStartDate;

  @JsonKey(name: 'end_job_date')
  DateTime? jobEndDate;

  // @JsonKey(name: 'num_publish_day')
  // int numOfPublishDay;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'published_date')
  DateTime publishedDate;

  @JsonKey(name: 'pay_per_hour_job')
  PayPerHourJob? payPerHourJob;

  @JsonKey(name: 'pay_per_task_job')
  PayPerTaskJob? payPerTaskJob;

  @JsonKey(name: 'use_point')
  int? usedPoint;

  @JsonKey(name: 'post_type_id')
  int? postTypeId;

  @JsonKey(name: 'pin_date')
  DateTime? pinDate;

  @JsonKey(name: 'number_pin_day')
  int? numberOfPinDay;

  JobPostCru({
    required this.gardenId,
    required this.title,
    required this.treeJobs,
    required this.jobStartDate,
    // required this.numOfPublishDay,
    required this.publishedDate,
    this.jobEndDate,
    this.description,
    this.payPerHourJob,
    this.payPerTaskJob,
    this.numberOfPinDay,
    this.pinDate,
    this.postTypeId,
    this.usedPoint,
    this.id,
  });

  factory JobPostCru.fromJson(Map<String, dynamic> json) =>
      _$JobPostCruFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostCruToJson(this);
}
