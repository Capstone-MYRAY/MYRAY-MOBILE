
import 'package:json_annotation/json_annotation.dart';
part 'post_report_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PostReportRequest{

  @JsonKey(name: 'job_post_id')
  int? jobPostId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'reported_id')
  int? reportedId;

  PostReportRequest({
    this.jobPostId,
    this.reportedId,
    required this.content,
  });

  factory PostReportRequest.fromJson(Map<String, dynamic> json) => _$PostReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostReportRequestToJson(this);

}