// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_expired_date_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendExpiredDateRequest _$ExtendExpiredDateRequestFromJson(
        Map<String, dynamic> json) =>
    ExtendExpiredDateRequest(
      jobPostId: json['jobPostId'] as String,
      newExpiredDate: DateTime.parse(json['extendDate'] as String),
      usedPoint: json['usePoint'] as String?,
    );

Map<String, dynamic> _$ExtendExpiredDateRequestToJson(
    ExtendExpiredDateRequest instance) {
  final val = <String, dynamic>{
    'jobPostId': instance.jobPostId,
    'extendDate': instance.newExpiredDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('usePoint', instance.usedPoint);
  return val;
}
