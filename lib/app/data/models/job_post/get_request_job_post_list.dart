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

  @JsonKey(name: 'gardenId')
  String? gardenId;

  @JsonKey(name: 'province')
  String? province;

  @JsonKey(name: 'district')
  String? district;

  @JsonKey(name: 'commune')
  String? commune;

  @JsonKey(name: 'workTypeId')
  String? workTypeId;

  @JsonKey(name: 'treeType')
  String? treeType;

  @JsonKey(name: 'startDateFrom')
  String? startDateFrom;

  @JsonKey(name: 'startDateTo')
  String? startDateTo;

  @JsonKey(name: 'salaryFrom')
  String? salaryFrom;

  @JsonKey(name: 'salaryTo')
  String? salaryTo;

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
    this.gardenId,
    this.commune,
    this.district,
    this.province,
    this.salaryFrom,
    this.salaryTo,
    this.startDateFrom,
    this.startDateTo,
    this.treeType,
    this.workTypeId
  });

  factory GetRequestJobPostList.fromJson(Map<String, dynamic> json) =>
      _$GetRequestJobPostListFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestJobPostListToJson(this);
}
