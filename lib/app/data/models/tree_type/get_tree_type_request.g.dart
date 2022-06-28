// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tree_type_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTreeTypeRequest _$GetTreeTypeRequestFromJson(Map<String, dynamic> json) =>
    GetTreeTypeRequest(
      type: json['type'] as String?,
      sortColumn:
          $enumDecodeNullable(_$TreeTypeSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
    );

Map<String, dynamic> _$GetTreeTypeRequestToJson(GetTreeTypeRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('sort-column', _$TreeTypeSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$TreeTypeSortColumnEnumMap = {
  TreeTypeSortColumn.type: 'Type',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
