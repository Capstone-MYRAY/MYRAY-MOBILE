// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tree_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTreeTypeResponse _$GetTreeTypeResponseFromJson(Map<String, dynamic> json) =>
    GetTreeTypeResponse(
      treeTypes: (json['list_object'] as List<dynamic>?)
          ?.map((e) => TreeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTreeTypeResponseToJson(GetTreeTypeResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'list_object', instance.treeTypes?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
