// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_work_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkTypeResponse _$GetWorkTypeResponseFromJson(Map<String, dynamic> json) =>
    GetWorkTypeResponse(
      workTypes: (json['list_object'] as List<dynamic>)
          .map((e) => WorkType.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: PagingMetadata.fromJson(
          json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetWorkTypeResponseToJson(
        GetWorkTypeResponse instance) =>
    <String, dynamic>{
      'list_object': instance.workTypes.map((e) => e.toJson()).toList(),
      'paging_metadata': instance.metadata.toJson(),
    };
