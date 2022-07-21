
import 'package:json_annotation/json_annotation.dart';
part 'post_feedback_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PostFeedbackRequest{

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'num_star')
  int numStar;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'belonged_id')
  int belongedId;

  PostFeedbackRequest({
    required this.content,
    required this.numStar,
    required this.jobPostId,
    required this.belongedId
  });

  factory PostFeedbackRequest.fromJson(Map<String, dynamic> json) => _$PostFeedbackRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostFeedbackRequestToJson(this);
  
}

// {
//   "content": "Chủ tốt, bao ăn đầy đủ",
//   "num_star": 5,
//   "job_post_id": 1051,
//   "belonged_id": 35
// }