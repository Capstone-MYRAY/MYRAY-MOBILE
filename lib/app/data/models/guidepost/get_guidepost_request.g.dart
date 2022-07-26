// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_guidepost_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGuidepostRequest _$GetGuidepostRequestFromJson(Map<String, dynamic> json) =>
    GetGuidepostRequest(
      title: json['title'] as String?,
      content: json['content'] as String?,
      createBy: json['createBy'] as String?,
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      sortColumn: $enumDecodeNullable(
          _$GuidepostSortColumnEnumMap, json['sort-column']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
    );

Map<String, dynamic> _$GetGuidepostRequestToJson(GetGuidepostRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('createBy', instance.createBy);
  writeNotNull(
      'sort-column', _$GuidepostSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};

const _$GuidepostSortColumnEnumMap = {
  GuidepostSortColumn.title: 'Title',
  GuidepostSortColumn.content: 'Content',
  GuidepostSortColumn.createdDate: 'CreatedDate',
};
