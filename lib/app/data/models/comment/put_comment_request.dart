
import 'package:json_annotation/json_annotation.dart';
part 'put_comment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PutCommentRequest{
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'content')
  String content;

  PutCommentRequest({
    required this.id,
    required this.content
  });
factory PutCommentRequest.fromJson(Map<String, dynamic> json) => _$PutCommentRequestFromJson(json);
Map<String, dynamic> toJson() => _$PutCommentRequestToJson(this);

}