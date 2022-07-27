// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentRequest _$PostCommentRequestFromJson(Map<String, dynamic> json) =>
    PostCommentRequest(
      guidepostId: json['guidepost_id'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PostCommentRequestToJson(PostCommentRequest instance) =>
    <String, dynamic>{
      'guidepost_id': instance.guidepostId,
      'content': instance.content,
    };
