
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable(includeIfNull: false)
class Comment{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'guidepost_id')
  int guidepostId;

  @JsonKey(name: 'comment_by')
  int commentBy;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'create_date')
  DateTime createDate;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'fullname')
  String? fullname;

  Comment({
    required this.id,
    required this.guidepostId,
    required this.commentBy,
    required this.content,
    required this.createDate,
    required this.fullname,
    this.avatar
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
  
}