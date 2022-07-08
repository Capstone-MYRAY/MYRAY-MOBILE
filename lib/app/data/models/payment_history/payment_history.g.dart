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
      createdBy: json['created_by'] as int?,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      earnedPoint: json['earned_point'] as int?,
      jobPostPrice: (json['job_post_price'] as num?)?.toDouble(),
      message: json['message'] as String?,
      pointPrice: (json['point_price'] as num?)?.toDouble(),
      status: json['status'] as int?,
      createdByName: json['create_by_name'] as String?,
      postTypePrice: (json['post_type_price'] as num?)?.toDouble(),
      totalPinDay: json['total_pin_day'] as int?,
      numOfPublishDay: json['number_published_day'] as int?,
    );

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
  writeNotNull('create_by_name', instance.createdByName);
  writeNotNull('created_date', instance.createdDate?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull('job_post_price', instance.jobPostPrice);
  writeNotNull('point_price', instance.pointPrice);
  writeNotNull('post_type_price', instance.postTypePrice);
  writeNotNull('total_pin_day', instance.totalPinDay);
  writeNotNull('number_published_day', instance.numOfPublishDay);
  return val;
}
