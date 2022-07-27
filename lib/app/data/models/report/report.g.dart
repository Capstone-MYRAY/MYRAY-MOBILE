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
  val['content'] = instance.content;
  writeNotNull('resolve_content', instance.resolveContent);
  writeNotNull('reported_id', instance.reportedId);
  val['created_by'] = instance.createdBy;
  val['created_date'] = instance.createdDate.toIso8601String();
  writeNotNull('resolved_date', instance.resolvedDate?.toIso8601String());
  writeNotNull('resolved_by', instance.resolvedBy);
  writeNotNull('status', instance.status);
  return val;
}
