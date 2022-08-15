// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_farmer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendFarmerRequest _$ExtendFarmerRequestFromJson(Map<String, dynamic> json) =>
    ExtendFarmerRequest(
      jobPostId: json['jobPostId'] as String,
      maxFarmer: json['maxFarmer'] as String,
    );

Map<String, dynamic> _$ExtendFarmerRequestToJson(
        ExtendFarmerRequest instance) =>
    <String, dynamic>{
      'jobPostId': instance.jobPostId,
      'maxFarmer': instance.maxFarmer,
    };
