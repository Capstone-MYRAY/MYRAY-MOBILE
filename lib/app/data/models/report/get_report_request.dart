import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_report_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetReportRequest {
  @JsonKey(name: 'jobPostId')
  String? jobPostId;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'resolveContent')
  String? resolvedContent;

  @JsonKey(name: 'reportedId')
  String? reportedId;

  @JsonKey(name: 'createdBy')
  String? createdBy;

  @JsonKey(name: 'resolvedBy')
  String? resolvedBy;

  @JsonKey(name: 'status')
  String? status;

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
    this.resolvedContent,
    this.reportedId,
    this.createdBy,
    this.resolvedBy,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
    this.status,
  });

  factory GetReportRequest.fromJson(Map<String, dynamic> json) =>
      _$GetReportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetReportRequestToJson(this);
}
