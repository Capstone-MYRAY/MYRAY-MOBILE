
import 'package:json_annotation/json_annotation.dart';
part 'put_feedback_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PutFeedbackRequest{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'num_star')
  num numStar;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'belonged_id')
  int belongedId;

  PutFeedbackRequest({
    required this.id,
    required this.content,
    required this.numStar,
    required this.jobPostId,
    required this.belongedId
  });

  factory PutFeedbackRequest.fromJson(Map<String, dynamic> json) => _$PutFeedbackRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PutFeedbackRequestToJson(this);
}