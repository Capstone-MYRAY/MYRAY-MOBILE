// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) =>
    PaymentHistory(
      id: json['id'] as int,
      jobPostId: json['job_post_id'] as int?,
      belongedId: json['belonged_id'] as int?,
      actualPrice: (json['actual_price'] as num?)?.toDouble(),
      balance: (json['balance'] as num?)?.toDouble(),
      balanceFluctuation: (json['balance_fluctuation'] as num?)?.toDouble(),
      usedPoint: json['used_point'] as int?,
    )
      ..earnedPoint = json['earned_point'] as int?
      ..message = json['message'] as String?
      ..createdBy = json['created_by'] as int?
      ..status = json['status'] as int?
      ..jobPostPrice = (json['job_post_price'] as num?)?.toDouble()
      ..pointPrice = (json['point_price'] as num?)?.toDouble();

Map<String, dynamic> _$PaymentHistoryToJson(PaymentHistory instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_post_id', instance.jobPostId);
  writeNotNull('belonged_id', instance.belongedId);
  writeNotNull('actual_price', instance.actualPrice);
  writeNotNull('balance_fluctuation', instance.balanceFluctuation);
  writeNotNull('balance', instance.balance);
  writeNotNull('used_point', instance.usedPoint);
  writeNotNull('earned_point', instance.earnedPoint);
  writeNotNull('message', instance.message);
  writeNotNull('created_by', instance.createdBy);
  writeNotNull('status', instance.status);
  writeNotNull('job_post_price', instance.jobPostPrice);
  writeNotNull('point_price', instance.pointPrice);
  return val;
}
