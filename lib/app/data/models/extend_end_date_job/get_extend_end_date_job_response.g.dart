// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_extend_end_date_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExtendEndDateJobResponse _$GetExtendEndDateJobResponseFromJson(
        Map<String, dynamic> json) =>
    GetExtendEndDateJobResponse(
      extendRequests: (json['list_object'] as List<dynamic>?)
          ?.map((e) => ExtendEndDateJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetExtendEndDateJobResponseToJson(
    GetExtendEndDateJobResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.extendRequests);
  writeNotNull('paging_metadata', instance.metadata);
  return val;
}
