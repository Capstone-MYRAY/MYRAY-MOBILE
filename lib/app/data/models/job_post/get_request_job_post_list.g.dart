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
      type: json['type'] as String?,
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
      publishBy: json['publishBy'] as String?,
      postTypeId: json['postTypeId'] as String?,
      isNotEndWork: json['isNotEndWork'] as String?,
      gardenId: json['gardenId'] as String?,
      commune: json['commune'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      salaryFrom: json['salaryFrom'] as String?,
      salaryTo: json['salaryTo'] as String?,
      startDateFrom: json['startDateFrom'] as String?,
      startDateTo: json['startDateTo'] as String?,
      treeType: json['treeType'] as String?,
      workTypeId: json['workTypeId'] as String?,
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
  writeNotNull('isNotEndWork', instance.isNotEndWork);
  writeNotNull('sort-column', _$JobPostSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('type', instance.type);
  writeNotNull('gardenId', instance.gardenId);
  writeNotNull('province', instance.province);
  writeNotNull('district', instance.district);
  writeNotNull('commune', instance.commune);
  writeNotNull('workTypeId', instance.workTypeId);
  writeNotNull('treeType', instance.treeType);
  writeNotNull('startDateFrom', instance.startDateFrom);
  writeNotNull('startDateTo', instance.startDateTo);
  writeNotNull('salaryFrom', instance.salaryFrom);
  writeNotNull('salaryTo', instance.salaryTo);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  writeNotNull('publishBy', instance.publishBy);
  writeNotNull('postTypeId', instance.postTypeId);
  return val;
}

const _$JobPostSortColumnEnumMap = {
  JobPostSortColumn.createdDate: 'CreatedDate',
  JobPostSortColumn.approvedDate: 'ApprovedDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
