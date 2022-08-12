// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_work_type_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkTypeRequest _$GetWorkTypeRequestFromJson(Map<String, dynamic> json) =>
    GetWorkTypeRequest(
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
      name: json['name'] as String?,
      sortColumn:
          $enumDecodeNullable(_$WorkTypeSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
    );

Map<String, dynamic> _$GetWorkTypeRequestToJson(GetWorkTypeRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('sort-column', _$WorkTypeSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  return val;
}

const _$WorkTypeSortColumnEnumMap = {
  WorkTypeSortColumn.name: 'Name',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
