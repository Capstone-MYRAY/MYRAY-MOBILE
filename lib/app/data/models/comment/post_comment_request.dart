
import 'package:json_annotation/json_annotation.dart';
part 'post_comment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PostCommentRequest{
  @JsonKey(name: 'guidepost_id')
  int guidepostId;

  @JsonKey(name: 'content')
  String content;

  PostCommentRequest({
    required this.guidepostId,
    required this.content
  });

  factory PostCommentRequest.fromJson(Map<String, dynamic> json) => _$PostCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentRequestToJson(this);
}