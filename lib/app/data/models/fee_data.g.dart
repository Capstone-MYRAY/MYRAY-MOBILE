// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeData _$FeeDataFromJson(Map<String, dynamic> json) => FeeData(
      postingFeePerDay: (json['job_post'] as num?)?.toDouble() ?? 0,
      payToHave1Point: (json['earn_point'] as num?)?.toDouble() ?? 0,
      pointToReduce1VND: (json['point'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$FeeDataToJson(FeeData instance) => <String, dynamic>{
      'job_post': instance.postingFeePerDay,
      'earn_point': instance.payToHave1Point,
      'point': instance.pointToReduce1VND,
    };
