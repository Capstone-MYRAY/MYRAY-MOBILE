// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feedback_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeedBackResponse _$GetFeedBackResponseFromJson(Map<String, dynamic> json) =>
    GetFeedBackResponse(
      listobject: (json['list_object'] as List<dynamic>?)
          ?.map((e) => FeedBack.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetFeedBackResponseToJson(GetFeedBackResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.listobject);
  writeNotNull('paging_metadata', instance.pagingMetadata);
  return val;
}
