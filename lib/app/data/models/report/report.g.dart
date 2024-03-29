// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as int?,
      content: json['content'] as String,
      createdBy: json['created_by'] as int,
      createdDate: DateTime.parse(json['created_date'] as String),
      resolvedBy: json['resolved_by'] as int?,
      status: json['status'] as int?,
      jobPostId: json['job_post_id'] as int?,
      resolveContent: json['resolve_content'] as String?,
      reportedId: json['reported_id'] as int?,
      resolvedDate: json['resolved_date'] == null
          ? null
          : DateTime.parse(json['resolved_date'] as String),
      resolvedName: json['resolved_name'] as String?,
      reportedName: json['reported_name'] as String?,
      createdName: json['created_name'] as String?,
      reportedAvatar: json['reported_avatar'] as String?,
      reportedPhone: json['reported_phone'] as String?,
      jobPostTitle: json['job_post_title'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('job_post_id', instance.jobPostId);
  writeNotNull('job_post_title', instance.jobPostTitle);
  val['content'] = instance.content;
  writeNotNull('resolve_content', instance.resolveContent);
  writeNotNull('reported_id', instance.reportedId);
  writeNotNull('reported_name', instance.reportedName);
  writeNotNull('reported_phone', instance.reportedPhone);
  writeNotNull('reported_avatar', instance.reportedAvatar);
  writeNotNull('created_name', instance.createdName);
  val['created_by'] = instance.createdBy;
  val['created_date'] = instance.createdDate.toIso8601String();
  writeNotNull('resolved_date', instance.resolvedDate?.toIso8601String());
  writeNotNull('resolved_by', instance.resolvedBy);
  writeNotNull('resolved_name', instance.resolvedName);
  writeNotNull('status', instance.status);
  return val;
}
