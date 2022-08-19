import 'package:json_annotation/json_annotation.dart';

part 'momo_payment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class MomoPaymentRequest {
  String partnerCode;
  String? subPartnerCode;
  String? partnerName;
  String? storeId;
  String requestId;
  int amount;

  ///Regex: ^[0-9a-zA-Z]([-_.]*[0-9a-zA-Z]+)*$
  String orderId;
  String orderInfo;
  int? orderGroupId;
  String redirectUrl;
  String ipnUrl;
  String requestType;

  ///Encode base64 follow Json format: {"key": "value"}
  String extraData;
  bool? autoCapture;
  String? lang;

  ///Signature to confirm information. Secure transaction in Hmac_SHA256 with format: a String sort all key name of data field from a-z:
  // accessKey=$accessKey&amount=$amount&extraData=$extraData
  // &ipnUrl=$ipnUrl&orderId=$orderId&orderInfo=$orderInfo
  // &partnerCode=$partnerCode&redirectUrl=$redirectUrl
  // &requestId=$requestId&requestType=$requestType
  String signature;

  MomoPaymentRequest({
    required this.partnerCode,
    required this.requestId,
    required this.amount,
    required this.orderId,
    required this.orderInfo,
    required this.redirectUrl,
    required this.ipnUrl,
    required this.extraData,
    required this.signature,
    required this.requestType,
    this.subPartnerCode,
    this.partnerName,
    this.storeId,
    this.orderGroupId,
    this.lang = 'vi',
    this.autoCapture = true,
  });

  Map<String, dynamic> toJson() => _$MomoPaymentRequestToJson(this);
}
