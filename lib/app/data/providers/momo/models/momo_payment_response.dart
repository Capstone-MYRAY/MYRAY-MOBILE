import 'package:json_annotation/json_annotation.dart';

part 'momo_payment_response.g.dart';

@JsonSerializable(includeIfNull: false)
class MomoPaymentResponse {
  String partnerCode;
  String requestId;
  String orderId;
  int amount;
  int responseTime; //timestamp
  String message;
  int resultCode;
  String payUrl;

  MomoPaymentResponse({
    required this.partnerCode,
    required this.requestId,
    required this.orderId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
  });

  factory MomoPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$MomoPaymentResponseFromJson(json);
}
