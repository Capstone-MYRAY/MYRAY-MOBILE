// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostReportRequest _$PostReportRequestFromJson(Map<String, dynamic> json) =>
    PostReportRequest(
      jobPostId: json['job_post_id'] as int?,
      reportedId: json['reported_id'] as int?,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PostReportRequestToJson(PostReportRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_post_id', instance.jobPostId);
  val['content'] = instance.content;
  writeNotNull('reported_id', instance.reportedId);
  return val;
}
