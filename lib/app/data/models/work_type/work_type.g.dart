// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkType _$WorkTypeFromJson(Map<String, dynamic> json) => WorkType(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$WorkTypeToJson(WorkType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
    };
