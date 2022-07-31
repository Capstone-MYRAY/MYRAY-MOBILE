// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post_cru.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPostCru _$JobPostCruFromJson(Map<String, dynamic> json) => JobPostCru(
      gardenId: json['garden_id'] as int,
      title: json['title'] as String,
      treeJobs: (json['tree_jobs'] as List<dynamic>)
          .map((e) => TreeJobs.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobStartDate: DateTime.parse(json['start_job_date'] as String),
      numOfPublishDay: json['num_publish_day'] as int,
      publishedDate: DateTime.parse(json['published_date'] as String),
      jobEndDate: json['end_job_date'] == null
          ? null
          : DateTime.parse(json['end_job_date'] as String),
      description: json['description'] as String?,
      payPerHourJob: json['pay_per_hour_job'] == null
          ? null
          : PayPerHourJob.fromJson(
              json['pay_per_hour_job'] as Map<String, dynamic>),
      payPerTaskJob: json['pay_per_task_job'] == null
          ? null
          : PayPerTaskJob.fromJson(
              json['pay_per_task_job'] as Map<String, dynamic>),
      numberOfPinDay: json['number_pin_day'] as int?,
      pinDate: json['pin_date'] == null
          ? null
          : DateTime.parse(json['pin_date'] as String),
      postTypeId: json['post_type_id'] as int?,
      usedPoint: json['use_point'] as int?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$JobPostCruToJson(JobPostCru instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['garden_id'] = instance.gardenId;
  val['tree_jobs'] = instance.treeJobs.map((e) => e.toJson()).toList();
  val['title'] = instance.title;
  val['start_job_date'] = instance.jobStartDate.toIso8601String();
  writeNotNull('end_job_date', instance.jobEndDate?.toIso8601String());
  val['num_publish_day'] = instance.numOfPublishDay;
  writeNotNull('description', instance.description);
  val['published_date'] = instance.publishedDate.toIso8601String();
  writeNotNull('pay_per_hour_job', instance.payPerHourJob?.toJson());
  writeNotNull('pay_per_task_job', instance.payPerTaskJob?.toJson());
  writeNotNull('use_point', instance.usedPoint);
  writeNotNull('post_type_id', instance.postTypeId);
  writeNotNull('pin_date', instance.pinDate?.toIso8601String());
  writeNotNull('number_pin_day', instance.numberOfPinDay);
  return val;
}
