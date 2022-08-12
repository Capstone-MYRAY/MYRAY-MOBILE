// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_max_pin_day_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMaxPinDayRequest _$GetMaxPinDayRequestFromJson(Map<String, dynamic> json) =>
    GetMaxPinDayRequest(
      pinDate: DateTime.parse(json['pinDate'] as String),
      postTypeId: json['postTypeId'] as String,
    );

Map<String, dynamic> _$GetMaxPinDayRequestToJson(
        GetMaxPinDayRequest instance) =>
    <String, dynamic>{
      'pinDate': instance.pinDate.toIso8601String(),
      'postTypeId': instance.postTypeId,
    };
