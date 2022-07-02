// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentHistoryResponse _$GetPaymentHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentHistoryResponse(
      paymentHistories: (json['list_object'] as List<dynamic>?)
          ?.map((e) => PaymentHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPaymentHistoryResponseToJson(
    GetPaymentHistoryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object',
      instance.paymentHistories?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
