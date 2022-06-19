// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      id: json['id'] as int,
      province: json['province'] as String,
      district: json['district'] as String,
      commune: json['commune'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'id': instance.id,
      'province': instance.province,
      'district': instance.district,
      'commune': instance.commune,
      'status': instance.status,
    };
