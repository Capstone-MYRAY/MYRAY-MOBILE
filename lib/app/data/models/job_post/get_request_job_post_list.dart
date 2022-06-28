

import 'package:json_annotation/json_annotation.dart';
part 'get_request_job_post_list.g.dart';

@JsonSerializable(includeIfNull: false)
class GetRequestJobPostList{

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'sort-column')
  String? sortColumn;

  @JsonKey(name: 'order-by')
  String? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  @JsonKey(name: 'publish-by')
  String? publishBy;

  GetRequestJobPostList({
    this.status,
    this.title,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
    this.publishBy
  });

  factory GetRequestJobPostList.fromJson(Map<String, dynamic> json) => _$GetRequestJobPostListFromJson(json);
  Map<String, dynamic> toJson() => _$GetRequestJobPostListToJson(this);

}