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

  @JsonKey(name: 'sort-column')
  JobPostSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  @JsonKey(name: 'publishBy')
  String? publishBy;

  GetRequestJobPostList({
    this.status,
    this.workStatus,
    this.title,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
    this.publishBy,
  });

  factory GetRequestJobPostList.fromJson(Map<String, dynamic> json) =>
      _$GetRequestJobPostListFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestJobPostListToJson(this);
}
