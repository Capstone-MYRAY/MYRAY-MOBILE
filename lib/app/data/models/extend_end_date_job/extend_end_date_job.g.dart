// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_end_date_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendEndDateJob _$ExtendEndDateJobFromJson(Map<String, dynamic> json) =>
    ExtendEndDateJob(
      id: json['id'] as int,
      jobPostId: json['job_post_id'] as int,
      requestBy: json['request_by'] as int,
      oldEndDate: DateTime.parse(json['old_end_date'] as String),
      extendEndDate: DateTime.parse(json['extend_end_date'] as String),
      reason: json['reason'] as String,
      status: json['status'] as int,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      jobTitle: json['job_title'] as String?,
      approvedBy: json['approved_by'] as int?,
      approvedDate: json['approved_date'] == null
          ? null
          : DateTime.parse(json['approved_date'] as String),
    );

Map<String, dynamic> _$ExtendEndDateJobToJson(ExtendEndDateJob instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'job_post_id': instance.jobPostId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_title', instance.jobTitle);
  val['request_by'] = instance.requestBy;
  writeNotNull('approved_by', instance.approvedBy);
  writeNotNull('created_date', instance.createdDate?.toIso8601String());
  writeNotNull('approved_date', instance.approvedDate?.toIso8601String());
  val['old_end_date'] = instance.oldEndDate.toIso8601String();
  val['extend_end_date'] = instance.extendEndDate.toIso8601String();
  val['reason'] = instance.reason;
  val['status'] = instance.status;
  return val;
}
