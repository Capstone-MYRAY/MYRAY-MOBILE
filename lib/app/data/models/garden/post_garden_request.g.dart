// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_garden_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostGardenRequest _$PostGardenRequestFromJson(Map<String, dynamic> json) =>
    PostGardenRequest(
      areaId: json['area_id'] as int,
      accountId: json['account_id'] as int,
      latitudes: json['latitudes'] as double,
      longitudes: json['longitudes'] as double,
      landArea: (json['land_area'] as num).toDouble(),
      address: json['address'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PostGardenRequestToJson(PostGardenRequest instance) =>
    <String, dynamic>{
      'area_id': instance.areaId,
      'account_id': instance.accountId,
      'name': instance.name,
      'latitudes': instance.latitudes,
      'longitudes': instance.longitudes,
      'address': instance.address,
      'land_area': instance.landArea,
      'image_url': instance.imageUrl,
      'description': instance.description,
    };
