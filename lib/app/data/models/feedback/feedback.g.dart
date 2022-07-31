// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedBack _$FeedBackFromJson(Map<String, dynamic> json) => FeedBack(
      id: json['id'] as int,
      createdDate: DateTime.parse(json['created_date'] as String),
      createdBy: json['created_by'] as int,
      content: json['content'] as String,
      numStar: json['num_star'] as int,
      jobPostId: json['job_post_id'] as int,
      belongedId: json['belonged_id'] as int,
    );

Map<String, dynamic> _$FeedBackToJson(FeedBack instance) => <String, dynamic>{
      'content': instance.content,
      'num_star': instance.numStar,
      'job_post_id': instance.jobPostId,
      'belonged_id': instance.belongedId,
      'id': instance.id,
      'created_date': instance.createdDate.toIso8601String(),
      'created_by': instance.createdBy,
    };
