// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int,
      guidepostId: json['guidepost_id'] as int,
      commentBy: json['comment_by'] as int,
      content: json['content'] as String,
      createDate: DateTime.parse(json['create_date'] as String),
      fullname: json['fullname'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'guidepost_id': instance.guidepostId,
    'comment_by': instance.commentBy,
    'content': instance.content,
    'create_date': instance.createDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  writeNotNull('fullname', instance.fullname);
  return val;
}
