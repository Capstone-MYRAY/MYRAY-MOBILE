// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momo_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomoPaymentRequest _$MomoPaymentRequestFromJson(Map<String, dynamic> json) =>
    MomoPaymentRequest(
      partnerCode: json['partnerCode'] as String,
      requestId: json['requestId'] as String,
      amount: json['amount'] as int,
      orderId: json['orderId'] as String,
      orderInfo: json['orderInfo'] as String,
      redirectUrl: json['redirectUrl'] as String,
      ipnUrl: json['ipnUrl'] as String,
      extraData: json['extraData'] as String,
      signature: json['signature'] as String,
      requestType: json['requestType'] as String,
      subPartnerCode: json['subPartnerCode'] as String?,
      partnerName: json['partnerName'] as String?,
      storeId: json['storeId'] as String?,
      orderGroupId: json['orderGroupId'] as int?,
      lang: json['lang'] as String? ?? 'vi',
      autoCapture: json['autoCapture'] as bool? ?? true,
    );

Map<String, dynamic> _$MomoPaymentRequestToJson(MomoPaymentRequest instance) {
  final val = <String, dynamic>{
    'partnerCode': instance.partnerCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subPartnerCode', instance.subPartnerCode);
  writeNotNull('partnerName', instance.partnerName);
  writeNotNull('storeId', instance.storeId);
  val['requestId'] = instance.requestId;
  val['amount'] = instance.amount;
  val['orderId'] = instance.orderId;
  val['orderInfo'] = instance.orderInfo;
  writeNotNull('orderGroupId', instance.orderGroupId);
  val['redirectUrl'] = instance.redirectUrl;
  val['ipnUrl'] = instance.ipnUrl;
  val['requestType'] = instance.requestType;
  val['extraData'] = instance.extraData;
  writeNotNull('autoCapture', instance.autoCapture);
  writeNotNull('lang', instance.lang);
  val['signature'] = instance.signature;
  return val;
}
