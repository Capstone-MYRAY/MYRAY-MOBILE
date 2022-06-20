import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';

part 'job_post.g.dart';
@JsonSerializable(includeIfNull: false)
class JobPost {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'garden_id')
  int gardenId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'start_job_date')
  DateTime startJobDate;

  @JsonKey(name: 'end_job_date')
  DateTime endJobDate;

  @JsonKey(name: 'num_publish_day')
  int numPublishDay;

  @JsonKey(name: 'published_by')
  int publishedBy;

  @JsonKey(name: 'published_date')
  DateTime publishedDate;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'pay_per_hour_job')
  PayPerHourJob? payPerHourJob;

  @JsonKey(name: 'pay_per_task_job')
  PayPerTaskJob? payPerTaskJob;

  JobPost(
      {required this.id,
      required this.gardenId,
      required this.title,
      required this.type,
      required this.startJobDate,
      required this.endJobDate,
      required this.numPublishDay,
      required this.publishedBy,
      required this.publishedDate,
      required this.createdDate,
      required this.status,
      this.payPerHourJob,
      this.payPerTaskJob});

  factory JobPost.fromJson(Map<String, dynamic> json) =>
      _$JobPostFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostToJson(this);
}
