import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
part 'feedback.g.dart';

@JsonSerializable(includeIfNull: false)
class FeedBack {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'created_by')
  int createdBy;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'num_star')
  num numStar;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'belonged_id')
  int belongedId;

  FeedBack({
    required this.id,
    required this.createdDate,
    required this.createdBy,
    this.content,
    required this.numStar,
    required this.jobPostId,
    required this.belongedId,
  });

  factory FeedBack.fromJson(Map<String, dynamic> json) =>
      _$FeedBackFromJson(json);
}
