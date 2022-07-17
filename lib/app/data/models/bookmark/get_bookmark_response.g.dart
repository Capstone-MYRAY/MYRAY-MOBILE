// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bookmark_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookmarkResponse _$GetBookmarkResponseFromJson(Map<String, dynamic> json) =>
    GetBookmarkResponse(
      listObject: (json['list_object'] as List<dynamic>)
          .map((e) => BookmarkResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: PagingMetadata.fromJson(
          json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBookmarkResponseToJson(
        GetBookmarkResponse instance) =>
    <String, dynamic>{
      'list_object': instance.listObject,
      'paging_metadata': instance.pagingMetadata,
    };
