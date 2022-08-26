// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeedbackRequest _$GetFeedbackRequestFromJson(Map<String, dynamic> json) =>
    GetFeedbackRequest(
      numStar: json['numStar'] as String?,
      jobPostId: json['jobPostId'] as String?,
      createdBy: json['createdBy'] as String?,
      belongedId: json['belongedId'] as String?,
      sortColumn:
          $enumDecodeNullable(_$FeedbackSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
    );

Map<String, dynamic> _$GetFeedbackRequestToJson(GetFeedbackRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('numStar', instance.numStar);
  writeNotNull('jobPostId', instance.jobPostId);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('sort-column', _$FeedbackSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('belongedId', instance.belongedId);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  return val;
}

const _$FeedbackSortColumnEnumMap = {
  FeedbackSortColumn.belongedId: 'BelongedId',
  FeedbackSortColumn.jobPostId: 'JobPostId',
  FeedbackSortColumn.numStar: 'NumStar',
  FeedbackSortColumn.createdDate: 'CreatedDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
