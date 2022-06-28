// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostTypeResponse _$GetPostTypeResponseFromJson(Map<String, dynamic> json) =>
    GetPostTypeResponse(
      postTypes: (json['list_object'] as List<dynamic>?)
          ?.map((e) => PostType.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPostTypeResponseToJson(GetPostTypeResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'list_object', instance.postTypes?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
