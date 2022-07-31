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
      secondObject: (json['second_object'] as List<dynamic>?)
          ?.map((e) => JobPost.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobPostResponseToJson(JobPostResponse instance) {
  final val = <String, dynamic>{
    'list_object': instance.listJobPost,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('second_object', instance.secondObject);
  val['paging_metadata'] = instance.pagingMetadata;
  return val;
}
