// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_extend_end_date_job_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExtendEndDateJobRequest _$GetExtendEndDateJobRequestFromJson(
        Map<String, dynamic> json) =>
    GetExtendEndDateJobRequest(
      requestBy: json['requestBy'] as String,
      status: json['status'] as String,
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
      sortColumn: $enumDecodeNullable(
          _$ExtendTaskJobSortColumnEnumMap, json['sort-column']),
      approvedBy: json['approvedBy'] as String?,
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
    );

Map<String, dynamic> _$GetExtendEndDateJobRequestToJson(
    GetExtendEndDateJobRequest instance) {
  final val = <String, dynamic>{
    'requestBy': instance.requestBy,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('approvedBy', instance.approvedBy);
  val['status'] = instance.status;
  writeNotNull(
      'sort-column', _$ExtendTaskJobSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  return val;
}

const _$ExtendTaskJobSortColumnEnumMap = {
  ExtendTaskJobSortColumn.createDate: 'CreatedDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
