
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_extend_end_date_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetExtendEndDateJobRequest{

  @JsonKey(name: 'requestBy')
  String requestBy;

  @JsonKey(name: 'approvedBy')
  String? approvedBy;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'sort-column')
  ExtendTaskJobSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;
  

  GetExtendEndDateJobRequest({
    required this.requestBy,
    required this.status,
    required this.page,
    required this.pageSize,
    this.sortColumn,
    this.approvedBy,
    this.orderBy
  });

  factory GetExtendEndDateJobRequest.fromJson(Map<String, dynamic> json) => _$GetExtendEndDateJobRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetExtendEndDateJobRequestToJson(this);
}