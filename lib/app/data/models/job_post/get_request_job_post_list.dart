import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';

part 'get_request_job_post_list.g.dart';

@JsonSerializable(includeIfNull: false)
class GetRequestJobPostList {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'statusWork')
  String? workStatus;

  @JsonKey(name: 'isNotEndWork')
  String? isNotEndWork; //boolean

  @JsonKey(name: 'sort-column')
  JobPostSortColumn? sortColumn;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  @JsonKey(name: 'publishBy')
  String? publishBy;

  @JsonKey(name: 'postTypeId')
  String? postTypeId;

  GetRequestJobPostList({
    this.status,
    this.workStatus,
    this.title,
    this.sortColumn,
    this.type,
    this.orderBy,
    this.page,
    this.pageSize,
    this.publishBy,
    this.postTypeId,
    this.isNotEndWork,
  });

  factory GetRequestJobPostList.fromJson(Map<String, dynamic> json) =>
      _$GetRequestJobPostListFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestJobPostListToJson(this);
}
