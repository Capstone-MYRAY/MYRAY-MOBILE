// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReportRequest _$GetReportRequestFromJson(Map<String, dynamic> json) =>
    GetReportRequest(
      jobPostId: json['jobPostId'] as String?,
      content: json['content'] as String?,
      resolvedContent: json['resolveContent'] as String?,
      reportedId: json['reportedId'] as String?,
      createdBy: json['createdBy'] as String?,
      resolvedBy: json['resolvedBy'] as String?,
      sortColumn:
          $enumDecodeNullable(_$ReportSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GetReportRequestToJson(GetReportRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('jobPostId', instance.jobPostId);
  writeNotNull('content', instance.content);
  writeNotNull('resolveContent', instance.resolvedContent);
  writeNotNull('reportedId', instance.reportedId);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('resolvedBy', instance.resolvedBy);
  writeNotNull('status', instance.status);
  writeNotNull('sort-column', _$ReportSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$ReportSortColumnEnumMap = {
  ReportSortColumn.createdDate: 'CreatedDate',
  ReportSortColumn.reportedId: 'ReportedId',
  ReportSortColumn.jobPostId: 'JobPostId',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
