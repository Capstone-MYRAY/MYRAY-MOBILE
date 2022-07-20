// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_request_job_post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestJobPostList _$GetRequestJobPostListFromJson(
        Map<String, dynamic> json) =>
    GetRequestJobPostList(
      status: json['status'] as String?,
      workStatus: json['statusWork'] as String?,
      title: json['title'] as String?,
      sortColumn:
          $enumDecodeNullable(_$JobPostSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
      publishBy: json['publishBy'] as String?,
    );

Map<String, dynamic> _$GetRequestJobPostListToJson(
    GetRequestJobPostList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('status', instance.status);
  writeNotNull('statusWork', instance.workStatus);
  writeNotNull('sort-column', _$JobPostSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  writeNotNull('publishBy', instance.publishBy);
  return val;
}

const _$JobPostSortColumnEnumMap = {
  JobPostSortColumn.publishedDate: 'PublishedDate',
  JobPostSortColumn.createdDate: 'CreatedDate',
  JobPostSortColumn.approvedDate: 'ApprovedDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
