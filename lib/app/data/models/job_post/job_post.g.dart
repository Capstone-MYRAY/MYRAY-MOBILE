// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPost _$JobPostFromJson(Map<String, dynamic> json) => JobPost(
      id: json['id'] as int,
      gardenId: json['garden_id'] as int,
      gardenName: json['garden_name'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      jobStartDate: DateTime.parse(json['start_job_date'] as String),
      jobEndDate: DateTime.parse(json['end_job_date'] as String),
      numOfPublishDay: json['num_publish_day'] as int,
      publishedBy: json['published_by'] as int,
      publishedName: json['published_name'] as String,
      publishedDate: DateTime.parse(json['published_date'] as String),
      createdDate: DateTime.parse(json['created_date'] as String),
      status: json['status'] as int,
      approvedBy: json['approved_by'] as int?,
      approvedDate: json['approved_date'] == null
          ? null
          : DateTime.parse(json['approved_date'] as String),
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
      description: json['description'] as String?,
      payPerHourJob: json['pay_per_hour_job'] == null
          ? null
          : PayPerHourJob.fromJson(
              json['pay_per_hour_job'] as Map<String, dynamic>),
      payPerTaskJob: json['pay_per_task_job'] == null
          ? null
          : PayPerTaskJob.fromJson(
              json['pay_per_task_job'] as Map<String, dynamic>),
      workStatus: json['status_work'] as int?,
      rejectedReason: json['reason_reject'] as String?,
      postTypeId: json['post_type_id'] as int?,
      backgroundColor: json['background'] as String?,
      foregroundColor: json['color'] as String?,
    );

Map<String, dynamic> _$JobPostToJson(JobPost instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'garden_id': instance.gardenId,
    'garden_name': instance.gardenName,
    'title': instance.title,
    'type': instance.type,
    'start_job_date': instance.jobStartDate.toIso8601String(),
    'end_job_date': instance.jobEndDate.toIso8601String(),
    'num_publish_day': instance.numOfPublishDay,
    'published_by': instance.publishedBy,
    'published_name': instance.publishedName,
    'published_date': instance.publishedDate.toIso8601String(),
    'created_date': instance.createdDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updated_date', instance.updatedDate?.toIso8601String());
  writeNotNull('approved_by', instance.approvedBy);
  writeNotNull('approved_date', instance.approvedDate?.toIso8601String());
  writeNotNull('description', instance.description);
  val['status'] = instance.status;
  writeNotNull('status_work', instance.workStatus);
  writeNotNull('reason_reject', instance.rejectedReason);
  writeNotNull('post_type_id', instance.postTypeId);
  writeNotNull('color', instance.foregroundColor);
  writeNotNull('background', instance.backgroundColor);
  writeNotNull('pay_per_hour_job', instance.payPerHourJob);
  writeNotNull('pay_per_task_job', instance.payPerTaskJob);
  return val;
}
