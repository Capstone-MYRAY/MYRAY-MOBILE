
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_hour_job/pay_per_hour_job.dart';
import 'package:myray_mobile/app/data/models/job_post/pay_per_task_job/pay_per_task_job.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type.dart';
part 'farmer_job_post_detail_response.g.dart';

@JsonSerializable(includeIfNull: false)
class FarmerJobPostDetailResponse {

  @JsonKey(name : 'id')
  int id;

  @JsonKey(name: 'garden_id')
  int gardenId;

  @JsonKey(name: 'tree_jobs')
  TreeType? treeJobs;

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

  @JsonKey(name: 'approved_by')
  int approvedBy;

  @JsonKey(name: 'approved_date')
  DateTime approvedDate;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'status_work')
  int statusWork;

  @JsonKey(name: 'post_type_id')
  int? postTypeId;

  @JsonKey(name: 'pay_per_hour_job')
  PayPerHourJob? payPerHourJob;

  @JsonKey(name: 'pay_per_task_job')
  PayPerTaskJob? payPerTaskJob;



  FarmerJobPostDetailResponse({
    required this.id,
    required this.gardenId,
    required this.type,
    required this.startJobDate,
    required this.endJobDate,
    required this.numPublishDay,
    required this.publishedBy,
    required this.publishedDate,
    required this.createdDate,
    required this.approvedBy,
    required this.approvedDate,
    required this.status,
    required this.statusWork,
    required this.description,
    this.treeJobs,
    this.postTypeId,  
    this.payPerHourJob,
    this.payPerTaskJob,

  });

  factory FarmerJobPostDetailResponse.fromJson(Map<String, dynamic> json) => _$FarmerJobPostDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FarmerJobPostDetailResponseToJson(this);

}


