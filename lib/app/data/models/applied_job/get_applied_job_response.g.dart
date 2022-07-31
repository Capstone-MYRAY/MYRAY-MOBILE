// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_applied_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppliedJobPostList _$GetAppliedJobPostListFromJson(
        Map<String, dynamic> json) =>
    GetAppliedJobPostList(
      listObject: (json['list_object'] as List<dynamic>?)
          ?.map((e) => AppliedJobResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAppliedJobPostListToJson(
    GetAppliedJobPostList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.listObject);
  writeNotNull('paging_metadata', instance.pagingMetadata);
  return val;
}
