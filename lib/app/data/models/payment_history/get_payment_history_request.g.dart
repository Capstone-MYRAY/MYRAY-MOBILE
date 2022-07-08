// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentHistoryRequest _$GetPaymentHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    GetPaymentHistoryRequest(
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
      jobPostId: json['jobPostId'] as String?,
      createdBy: json['createdBy'] as String?,
      status: json['status'] as String?,
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      sortColumn: $enumDecodeNullable(
          _$PaymentHistorySortColumnEnumMap, json['sort-column']),
    );

Map<String, dynamic> _$GetPaymentHistoryRequestToJson(
    GetPaymentHistoryRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('jobPostId', instance.jobPostId);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('status', instance.status);
  writeNotNull(
      'sort-column', _$PaymentHistorySortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};

const _$PaymentHistorySortColumnEnumMap = {
  PaymentHistorySortColumn.actualPrice: 'ActualPrice',
  PaymentHistorySortColumn.usedPoint: 'UsedPoint',
  PaymentHistorySortColumn.earnedPoint: 'EarnedPoint',
  PaymentHistorySortColumn.status: 'Status',
  PaymentHistorySortColumn.createdDate: 'CreatedDate',
};
