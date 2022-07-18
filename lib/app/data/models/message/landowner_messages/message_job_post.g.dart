// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_job_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageJobPost _$MessageJobPostFromJson(Map<String, dynamic> json) =>
    MessageJobPost(
      id: json['jobPostId'] as int,
      title: json['jobPostTitle'] as String,
      farmers: (json['farmers'] as List<dynamic>)
          .map((e) => Farmer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageJobPostToJson(MessageJobPost instance) =>
    <String, dynamic>{
      'jobPostId': instance.id,
      'jobPostTitle': instance.title,
      'farmers': instance.farmers.map((e) => e.toJson()).toList(),
    };
