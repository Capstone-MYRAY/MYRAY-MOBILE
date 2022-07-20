import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_bookmark_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetBookmarkRequest {
  @JsonKey(name: 'sort-column')
  BookmarkSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  @JsonKey(name: 'accountId')
  String accountId;

  GetBookmarkRequest({
    this.sortColumn,
    this.orderBy,
    required this.page,
    required this.pageSize,
    required this.accountId,
  });

  factory GetBookmarkRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBookmarkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetBookmarkRequestToJson(this);
}
