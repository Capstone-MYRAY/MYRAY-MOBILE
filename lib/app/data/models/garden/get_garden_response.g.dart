// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_garden_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGardenResponse _$GetGardenResponseFromJson(Map<String, dynamic> json) =>
    GetGardenResponse(
      gardens: (json['list_object'] as List<dynamic>?)
          ?.map((e) => Garden.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetGardenResponseToJson(GetGardenResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.gardens);
  writeNotNull('paging_metadata', instance.metadata);
  return val;
}
