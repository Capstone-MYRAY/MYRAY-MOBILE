// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_request_job_post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestJobPostList _$GetRequestJobPostListFromJson(
        Map<String, dynamic> json) =>
    GetRequestJobPostList(
      status: json['status'] as String?,
      title: json['title'] as String?,
      sortColumn: json['sort-column'] as String?,
      orderBy: json['order-by'] as String?,
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
      publishBy: json['publish-by'] as String?,
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
  writeNotNull('sort-column', instance.sortColumn);
  writeNotNull('order-by', instance.orderBy);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  writeNotNull('publish-by', instance.publishBy);
  return val;
}
