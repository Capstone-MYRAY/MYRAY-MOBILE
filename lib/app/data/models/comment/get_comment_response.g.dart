// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCommentResponse _$GetCommentResponseFromJson(Map<String, dynamic> json) =>
    GetCommentResponse(
      listObject: (json['list_object'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCommentResponseToJson(GetCommentResponse instance) {
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
