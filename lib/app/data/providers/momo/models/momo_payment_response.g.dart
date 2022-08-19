// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momo_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomoPaymentResponse _$MomoPaymentResponseFromJson(Map<String, dynamic> json) =>
    MomoPaymentResponse(
      partnerCode: json['partnerCode'] as String,
      requestId: json['requestId'] as String,
      orderId: json['orderId'] as String,
      amount: json['amount'] as int,
      responseTime: json['responseTime'] as int,
      message: json['message'] as String,
      resultCode: json['resultCode'] as int,
      payUrl: json['payUrl'] as String,
    );

Map<String, dynamic> _$MomoPaymentResponseToJson(
        MomoPaymentResponse instance) =>
    <String, dynamic>{
      'partnerCode': instance.partnerCode,
      'requestId': instance.requestId,
      'orderId': instance.orderId,
      'amount': instance.amount,
      'responseTime': instance.responseTime,
      'message': instance.message,
      'resultCode': instance.resultCode,
      'payUrl': instance.payUrl,
    };
