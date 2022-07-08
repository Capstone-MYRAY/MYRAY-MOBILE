// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_pin_date_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPinDateRequest _$CheckPinDateRequestFromJson(Map<String, dynamic> json) =>
    CheckPinDateRequest(
      publishedDate: DateTime.parse(json['PublishedDate'] as String),
      numOfPublishDay: json['numberOfDayPublish'] as String,
      postTypeId: json['postTypeId'] as String,
    );

Map<String, dynamic> _$CheckPinDateRequestToJson(
        CheckPinDateRequest instance) =>
    <String, dynamic>{
      'PublishedDate': instance.publishedDate.toIso8601String(),
      'numberOfDayPublish': instance.numOfPublishDay,
      'postTypeId': instance.postTypeId,
    };
