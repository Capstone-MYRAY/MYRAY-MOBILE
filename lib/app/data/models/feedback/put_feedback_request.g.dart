// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutFeedbackRequest _$PutFeedbackRequestFromJson(Map<String, dynamic> json) =>
    PutFeedbackRequest(
      id: json['id'] as int,
      content: json['content'] as String,
      numStar: json['num_star'] as num,
      jobPostId: json['job_post_id'] as int,
      belongedId: json['belonged_id'] as int,
    );

Map<String, dynamic> _$PutFeedbackRequestToJson(PutFeedbackRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'num_star': instance.numStar,
      'job_post_id': instance.jobPostId,
      'belonged_id': instance.belongedId,
    };
