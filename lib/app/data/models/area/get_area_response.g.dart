// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_area_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAreaResponse _$GetAreaResponseFromJson(Map<String, dynamic> json) =>
    GetAreaResponse(
      areas: (json['list_object'] as List<dynamic>?)
          ?.map((e) => Area.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAreaResponseToJson(GetAreaResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.areas?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
