// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_update_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutUpdateReportRequest _$PutUpdateReportRequestFromJson(
        Map<String, dynamic> json) =>
    PutUpdateReportRequest(
      id: json['id'] as int?,
      jobPostId: json['job_post_id'] as int,
      content: json['content'] as String,
      reportedId: json['reported_id'] as int,
    );

Map<String, dynamic> _$PutUpdateReportRequestToJson(
    PutUpdateReportRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['job_post_id'] = instance.jobPostId;
  val['content'] = instance.content;
  val['reported_id'] = instance.reportedId;
  return val;
}
