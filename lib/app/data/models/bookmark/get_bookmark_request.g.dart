// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bookmark_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookmarkRequest _$GetBookmarkRequestFromJson(Map<String, dynamic> json) =>
    GetBookmarkRequest(
      sortColumn: json['sort-column'] as int?,
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
      accountId: json['accountId'] as String,
    );

Map<String, dynamic> _$GetBookmarkRequestToJson(GetBookmarkRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort-column', instance.sortColumn);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  val['accountId'] = instance.accountId;
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
