// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landowner_get_job_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandownerGetJobPostResponse _$LandownerGetJobPostResponseFromJson(
        Map<String, dynamic> json) =>
    LandownerGetJobPostResponse(
      jobPosts: (json['list_object'] as List<dynamic>?)
          ?.map((e) => JobPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LandownerGetJobPostResponseToJson(
    LandownerGetJobPostResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'list_object', instance.jobPosts?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
