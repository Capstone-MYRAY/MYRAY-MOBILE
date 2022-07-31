import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history.dart';

part 'get_payment_history_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetPaymentHistoryResponse {
  @JsonKey(name: 'list_object')
  List<PaymentHistory>? paymentHistories;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetPaymentHistoryResponse({this.paymentHistories, this.metadata});

  factory GetPaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPaymentHistoryResponseToJson(this);
}
