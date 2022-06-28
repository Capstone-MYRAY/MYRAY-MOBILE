// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_type_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostTypeRequest _$GetPostTypeRequestFromJson(Map<String, dynamic> json) =>
    GetPostTypeRequest(
      name: json['name'] as String,
    )
      ..description = json['description'] as String?
      ..sortColumn =
          $enumDecodeNullable(_$PostTypeSortColumnEnumMap, json['sort-column'])
      ..orderBy = $enumDecodeNullable(_$SortOrderEnumMap, json['order-by'])
      ..page = json['page'] as String?
      ..pageSize = json['page-size'] as String?;

Map<String, dynamic> _$GetPostTypeRequestToJson(GetPostTypeRequest instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('sort-column', _$PostTypeSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$PostTypeSortColumnEnumMap = {
  PostTypeSortColumn.name: 'Name',
  PostTypeSortColumn.price: 'Price',
  PostTypeSortColumn.color: 'Color',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
