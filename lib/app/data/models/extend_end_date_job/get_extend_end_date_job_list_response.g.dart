// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_extend_end_date_job_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExtendEndDateJobList _$GetExtendEndDateJobListFromJson(
        Map<String, dynamic> json) =>
    GetExtendEndDateJobList(
      listObject: (json['list_object'] as List<dynamic>?)
          ?.map((e) => ExtendEndDateJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondObject: (json['second_object'] as List<dynamic>?)
          ?.map((e) => ExtendEndDateJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagingMetadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetExtendEndDateJobListToJson(
    GetExtendEndDateJobList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list_object', instance.listObject);
  writeNotNull('second_object', instance.secondObject);
  writeNotNull('paging_metadata', instance.pagingMetadata);
  return val;
}
