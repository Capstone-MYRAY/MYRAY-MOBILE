import 'package:json_annotation/json_annotation.dart';

part 'get_specific_report_request.g.dart';

@JsonSerializable()
class GetSpecificReportRequest {
  String jobPostId;
  String reportedId;

  @JsonKey(name: 'createById')
  String createdById;

  GetSpecificReportRequest({
    required this.jobPostId,
    required this.reportedId,
    required this.createdById,
  });

  factory GetSpecificReportRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSpecificReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetSpecificReportRequestToJson(this);
}
