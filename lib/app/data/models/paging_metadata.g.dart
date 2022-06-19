// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingMetadata _$PagingMetadataFromJson(Map<String, dynamic> json) =>
    PagingMetadata(
      pageIndex: json['page_index'] as int? ?? 0,
      pageSize: json['page_size'] as int? ?? 0,
      totalCount: json['total_count'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      hasPreviousPage: json['has_previous_page'] as bool? ?? false,
      hasNextPage: json['has_next_page'] as bool? ?? false,
    );

Map<String, dynamic> _$PagingMetadataToJson(PagingMetadata instance) =>
    <String, dynamic>{
      'page_index': instance.pageIndex,
      'page_size': instance.pageSize,
      'total_count': instance.totalCount,
      'total_pages': instance.totalPages,
      'has_previous_page': instance.hasPreviousPage,
      'has_next_page': instance.hasNextPage,
    };
