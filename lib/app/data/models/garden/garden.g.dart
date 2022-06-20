// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Garden _$GardenFromJson(Map<String, dynamic> json) => Garden(
      areaId: json['area_id'] as int,
      accountId: json['account_id'] as int,
      latitudes: (json['latitudes'] as num).toDouble(),
      longitudes: (json['longitudes'] as num).toDouble(),
      landArea: (json['land_area'] as num).toDouble(),
      address: json['address'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      name: json['name'] as String,
      createdDate: DateTime.parse(json['create_date'] as String),
      id: json['id'] as int,
      status: json['status'] as int,
      updatedDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$GardenToJson(Garden instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'area_id': instance.areaId,
    'account_id': instance.accountId,
    'name': instance.name,
    'latitudes': instance.latitudes,
    'longitudes': instance.longitudes,
    'address': instance.address,
    'land_area': instance.landArea,
    'image_url': instance.imageUrl,
    'description': instance.description,
    'create_date': instance.createdDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('update_date', instance.updatedDate?.toIso8601String());
  val['status'] = instance.status;
  return val;
}
