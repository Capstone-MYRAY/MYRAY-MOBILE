import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

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

  @JsonKey(name: 'create_by_name')
  String? createdByName;

  @JsonKey(name: 'created_date')
  DateTime? createdDate;

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
    this.createdBy,
    this.createdDate,
    this.earnedPoint,
    this.jobPostPrice,
    this.message,
    this.pointPrice,
    this.status,
    this.createdByName,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryToJson(this);

  Color get statusColor => _statusColor[status]!;

  String get statusString => _statusString[status]!;
}

Map<int, Color> _statusColor = {
  PaymentHistoryStatus.rejected.index: AppColors.errorColor,
  PaymentHistoryStatus.pending.index: AppColors.warningColor,
  PaymentHistoryStatus.paid.index: AppColors.successColor,
};

Map<int, String> _statusString = {
  PaymentHistoryStatus.rejected.index: AppStrings.paymentHistoryFailed,
  PaymentHistoryStatus.pending.index: AppStrings.paymentHistoryPending,
  PaymentHistoryStatus.paid.index: AppStrings.paymentHistorySuccess,
};
