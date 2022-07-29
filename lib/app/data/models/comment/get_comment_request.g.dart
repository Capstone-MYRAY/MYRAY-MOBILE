// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCommentRequest _$GetCommentRequestFromJson(Map<String, dynamic> json) =>
    GetCommentRequest(
      commentBy: json['commentBy'] as String?,
      content: json['content'] as String?,
      sortColumn:
          $enumDecodeNullable(_$CommentSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String?,
      pageSize: json['page-size'] as String?,
      guidepostId: json['guidepostId'] as String?,
    );

Map<String, dynamic> _$GetCommentRequestToJson(GetCommentRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commentBy', instance.commentBy);
  writeNotNull('content', instance.content);
  writeNotNull('sort-column', _$CommentSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('page', instance.page);
  writeNotNull('page-size', instance.pageSize);
  writeNotNull('guidepostId', instance.guidepostId);
  return val;
}

const _$CommentSortColumnEnumMap = {
  CommentSortColumn.commentBy: 'CommentBy',
  CommentSortColumn.createdDate: 'CreatedDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
