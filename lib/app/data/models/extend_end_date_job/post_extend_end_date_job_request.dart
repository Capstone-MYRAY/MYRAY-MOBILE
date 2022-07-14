
import 'package:json_annotation/json_annotation.dart';
part 'post_extend_end_date_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PostExtendEndDateJobRequest{

  @JsonKey(name:'job_post_id')
  int jobPostId;

  @JsonKey(name: 'extend_end_date')
  String extendEndDate;

  @JsonKey(name: 'reason')
  String reason;

  PostExtendEndDateJobRequest({
    required this.jobPostId,
    required this.extendEndDate,
    required this.reason,
  });

  factory PostExtendEndDateJobRequest.fromJson(Map<String, dynamic> json) => _$PostExtendEndDateJobRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostExtendEndDateJobRequestToJson(this);
}