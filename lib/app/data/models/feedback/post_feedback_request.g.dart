// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFeedbackRequest _$PostFeedbackRequestFromJson(Map<String, dynamic> json) =>
    PostFeedbackRequest(
      content: json['content'] as String,
      numStart: json['num_star'] as int,
      jobPostId: json['job_post_id'] as int,
      belongedId: json['belonged_id'] as int,
    );

Map<String, dynamic> _$PostFeedbackRequestToJson(
        PostFeedbackRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'num_star': instance.numStart,
      'job_post_id': instance.jobPostId,
      'belonged_id': instance.belongedId,
    };
