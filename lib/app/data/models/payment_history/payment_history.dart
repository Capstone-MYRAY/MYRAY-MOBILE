import 'package:json_annotation/json_annotation.dart';

part 'payment_history.g.dart';

@JsonSerializable(includeIfNull: false)
class PaymentHistory {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'job_post_id')
  int? jobPostId;

  @JsonKey(name: 'belonged_id')
  int? belongedId;

  @JsonKey(name: 'actual_price')
  double? actualPrice;

  @JsonKey(name: 'balance_fluctuation')
  double? balanceFluctuation;

  @JsonKey(name: 'balance')
  double? balance;

  @JsonKey(name: 'used_point')
  int? usedPoint;

  @JsonKey(name: 'earned_point')
  int? earnedPoint;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'job_post_price')
  double? jobPostPrice;

  @JsonKey(name: 'point_price')
  double? pointPrice;

  PaymentHistory({
    required this.id,
    this.jobPostId,
    this.belongedId,
    this.actualPrice,
    this.balance,
    this.balanceFluctuation,
    this.usedPoint,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryToJson(this);
}
