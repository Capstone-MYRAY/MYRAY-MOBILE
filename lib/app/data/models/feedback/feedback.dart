import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
part 'feedback.g.dart';

@JsonSerializable(includeIfNull: false)
class FeedBack extends PostFeedbackRequest {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'created_date')
  DateTime createdDate;

  @JsonKey(name: 'created_by')
  int createdBy;

  FeedBack({
    required this.id,
    required this.createdDate,
    required this.createdBy,
    required String content,
    required int numStar,
    required int jobPostId,
    required int belongedId,
  }) : super(
          content: content,
          numStar: numStar,
          jobPostId: jobPostId,
          belongedId: belongedId,
        );

  factory FeedBack.fromJson(Map<String, dynamic> json) =>
      _$FeedBackFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FeedBackToJson(this);
}
