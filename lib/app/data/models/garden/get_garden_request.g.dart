// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_garden_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGardenRequest _$GetGardenRequestFromJson(Map<String, dynamic> json) =>
    GetGardenRequest(
      areaId: json['AreaId'] as String?,
      accountId: json['AccountId'] as String?,
      name: json['Name'] as String?,
      description: json['Description'] as String?,
      sortColumn:
          $enumDecodeNullable(_$GardenSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
    );

Map<String, dynamic> _$GetGardenRequestToJson(GetGardenRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AreaId', instance.areaId);
  writeNotNull('AccountId', instance.accountId);
  writeNotNull('Name', instance.name);
  writeNotNull('Description', instance.description);
  writeNotNull('sort-column', _$GardenSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$GardenSortColumnEnumMap = {
  GardenSortColumn.area: 'AreaId',
  GardenSortColumn.name: 'Name',
  GardenSortColumn.landArea: 'LandArea',
  GardenSortColumn.createdDate: 'CreateDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
