// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_guidepost_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGuidepostResponse _$GetGuidepostResponseFromJson(
        Map<String, dynamic> json) =>
    GetGuidepostResponse(
      listObject: (json['list_object'] as List<dynamic>?)
          ?.map((e) => Guidepost.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetGuidepostResponseToJson(
    GetGuidepostResponse instance) {
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
