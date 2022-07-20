import 'package:json_annotation/json_annotation.dart';
part 'put_update_report_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PutUpdateReportRequest{

@JsonKey(name: 'id')
int? id;

@JsonKey(name: 'job_post_id')
int jobPostId;

@JsonKey(name: 'content')
String content;

@JsonKey(name: 'reported_id')
int reportedId;

PutUpdateReportRequest({
  required this.id,
  required this.jobPostId,
  required this.content,
  required this.reportedId,
});

factory PutUpdateReportRequest.fromJson(Map<String, dynamic> json) => _$PutUpdateReportRequestFromJson(json);
Map<String, dynamic> toJson() => _$PutUpdateReportRequestToJson(this);
}