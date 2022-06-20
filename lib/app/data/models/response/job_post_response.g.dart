// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPostResponse _$JobPostResponseFromJson(Map<String, dynamic> json) =>
    JobPostResponse(
      listJobPost: (json['list_object'] as List<dynamic>)
          .map((e) => JobPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: PagingMetadata.fromJson(
          json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JobPostResponseToJson(JobPostResponse instance) =>
    <String, dynamic>{
      'list_object': instance.listJobPost,
      'paging_metadata': instance.pagingMetadata,
    };
