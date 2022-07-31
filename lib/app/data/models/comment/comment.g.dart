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
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'guidepost_id': instance.guidepostId,
      'comment_by': instance.commentBy,
      'content': instance.content,
      'create_date': instance.createDate.toIso8601String(),
    };
