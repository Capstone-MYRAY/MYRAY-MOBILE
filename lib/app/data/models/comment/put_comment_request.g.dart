// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutCommentRequest _$PutCommentRequestFromJson(Map<String, dynamic> json) =>
    PutCommentRequest(
      id: json['id'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$PutCommentRequestToJson(PutCommentRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };
