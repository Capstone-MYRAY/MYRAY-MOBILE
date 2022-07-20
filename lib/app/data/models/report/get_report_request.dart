
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_report_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetReportRequest{

 @JsonKey(name: 'jobPostId')
 String? jobPostId;

 @JsonKey(name: 'content')
 String? content;

 @JsonKey(name: 'resolveConent')
 String? resolveConent;

 @JsonKey(name: 'reportedId')
 String? reportedId;

 @JsonKey(name: 'createdBy')
 String? createdBy;

 @JsonKey(name: 'resolveBy')
 String? resolveBy;

 @JsonKey(name: 'sort-column')
 ReportSortColumn? sortColumn;

 @JsonKey(name: 'order-by')
 SortOrder? orderBy;

 @JsonKey(name: 'page')
 String? page;

 @JsonKey(name: 'page-size')
 String? pageSize;

 GetReportRequest({
  this.jobPostId,
  this.content,
  this.resolveConent,
  this.reportedId,
  this.createdBy,
  this.resolveBy,
  this.sortColumn,
  this.orderBy,
  this.page,
  this.pageSize,
 });

 factory GetReportRequest.fromJson(Map<String, dynamic> json) => _$GetReportRequestFromJson(json);
 Map<String, dynamic> toJson() => _$GetReportRequestToJson(this);

}