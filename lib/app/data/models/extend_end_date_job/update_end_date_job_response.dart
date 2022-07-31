
import 'package:json_annotation/json_annotation.dart';
part 'update_end_date_job_response.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateEndDateJobResponse{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'request_by')
  int requestBy;

  @JsonKey(name: 'extend_end_date')
  DateTime extendEndDate;

  @JsonKey(name: 'reason')
  String reason;

  UpdateEndDateJobResponse({
    required this.id,
    required this.jobPostId,
    required this.requestBy,
    required this.extendEndDate,
    required this.reason
  });

  factory UpdateEndDateJobResponse.fromJson(Map<String, dynamic> json) => _$UpdateEndDateJobResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateEndDateJobResponseToJson(this);

}