
import 'package:json_annotation/json_annotation.dart';
part 'extend_end_date_job.g.dart';

@JsonSerializable(includeIfNull: false)
class ExtendEndDateJob{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'job_title')
  String? jobTitle;

  @JsonKey(name: 'request_by')
  int requestBy;

  @JsonKey(name: 'approved_by')
  int? approvedBy;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'approved_date')
  DateTime? approvedDate;

  @JsonKey(name: 'old_end_date')
  DateTime oldEndDate;

  @JsonKey(name: 'extend_end_date')
  DateTime extendEndDate;

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'status')
  int status;

  ExtendEndDateJob({
    required this.id,
    required this.jobPostId,
    required this.requestBy,
    required this.createdDate,
    required this.oldEndDate,
    required this.extendEndDate,
    required this.reason,
    required this.status,
    this.jobTitle,
    this.approvedBy,
    this.approvedDate,
  });

  factory ExtendEndDateJob.fromJson(Map<String, dynamic> json) => _$ExtendEndDateJobFromJson(json);
  Map<String, dynamic> toJson() => _$ExtendEndDateJobToJson(this);
}

// {
//   "id": 0,
//   "job_post_id": 0,
//   "request_by": 0,
//   "approved_by": 0,
//   "created_date": "2022-07-14T01:00:58.361Z",
//   "approved_date": "2022-07-14T01:00:58.362Z",
//   "old_end_date": "2022-07-14T01:00:58.362Z",
//   "extend_end_date": "2022-07-14T01:00:58.362Z",
//   "reason": "string",
//   "status": 0
// }