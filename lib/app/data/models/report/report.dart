import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(includeIfNull: false)
class Report{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post_id')
  int? jobPostId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'resolve_content')
  String? resolveContent;

  @JsonKey(name: 'reported_id')
  int? reportedId;

  @JsonKey(name: 'created_by')
  int createdby;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'resolved_date')
  DateTime? resolvedDate;

  @JsonKey(name: 'resolved_by')
  int resolvedBy;

  @JsonKey(name: 'status')
  int status;



  Report({
    required this.id,
    required this.content,
    required this.createdby,
    required this.createdDate,
    required this.resolvedBy,
    required this.status,
    this.jobPostId,
    this.resolveContent,
    this.reportedId,
    this.resolvedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

}

