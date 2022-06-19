// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_area_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAreaRequest _$GetAreaRequestFromJson(Map<String, dynamic> json) =>
    GetAreaRequest(
      province: json['province'] as String?,
      district: json['district'] as String?,
      commune: json['commune'] as String?,
      status: json['status'] as String?,
      sortColumn:
          $enumDecodeNullable(_$AreaSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String? ?? '1',
      pageSize: json['page-size'] as String? ?? '20',
    );

Map<String, dynamic> _$GetAreaRequestToJson(GetAreaRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('province', instance.province);
  writeNotNull('district', instance.district);
  writeNotNull('commune', instance.commune);
  writeNotNull('status', instance.status);
  writeNotNull('sort-column', _$AreaSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$AreaSortColumnEnumMap = {
  AreaSortColumn.province: 'Province',
  AreaSortColumn.district: 'District',
  AreaSortColumn.commune: 'Commune',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
