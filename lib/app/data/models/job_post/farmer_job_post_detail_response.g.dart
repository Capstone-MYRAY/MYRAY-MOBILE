// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_job_post_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerJobPostDetailResponse _$FarmerJobPostDetailResponseFromJson(
        Map<String, dynamic> json) =>
    FarmerJobPostDetailResponse(
      id: json['id'] as int,
      gardenId: json['garden_id'] as int,
      type: json['type'] as String,
      startJobDate: DateTime.parse(json['start_job_date'] as String),
      endJobDate: json['end_job_date'] == null
          ? null
          : DateTime.parse(json['end_job_date'] as String),
      numPublishDay: json['num_publish_day'] as int,
      publishedBy: json['published_by'] as int,
      publishedDate: DateTime.parse(json['published_date'] as String),
      createdDate: DateTime.parse(json['created_date'] as String),
      approvedBy: json['approved_by'] as int,
      approvedDate: DateTime.parse(json['approved_date'] as String),
      status: json['status'] as int,
      statusWork: json['status_work'] as int,
      description: json['description'] as String,
      title: json['title'] as String,
      treeJobs: (json['tree_jobs'] as List<dynamic>?)
          ?.map((e) => TreeJobs.fromJson(e as Map<String, dynamic>))
          .toList(),
      postTypeId: json['post_type_id'] as int?,
      payPerHourJob: json['pay_per_hour_job'] == null
          ? null
          : PayPerHourJob.fromJson(
              json['pay_per_hour_job'] as Map<String, dynamic>),
      payPerTaskJob: json['pay_per_task_job'] == null
          ? null
          : PayPerTaskJob.fromJson(
              json['pay_per_task_job'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FarmerJobPostDetailResponseToJson(
    FarmerJobPostDetailResponse instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'garden_id': instance.gardenId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tree_jobs', instance.treeJobs);
  val['title'] = instance.title;
  val['type'] = instance.type;
  val['start_job_date'] = instance.startJobDate.toIso8601String();
  writeNotNull('end_job_date', instance.endJobDate?.toIso8601String());
  val['num_publish_day'] = instance.numPublishDay;
  val['published_by'] = instance.publishedBy;
  val['published_date'] = instance.publishedDate.toIso8601String();
  val['created_date'] = instance.createdDate.toIso8601String();
  val['approved_by'] = instance.approvedBy;
  val['approved_date'] = instance.approvedDate.toIso8601String();
  val['description'] = instance.description;
  val['status'] = instance.status;
  val['status_work'] = instance.statusWork;
  writeNotNull('post_type_id', instance.postTypeId);
  writeNotNull('pay_per_hour_job', instance.payPerHourJob);
  writeNotNull('pay_per_task_job', instance.payPerTaskJob);
  return val;
}
