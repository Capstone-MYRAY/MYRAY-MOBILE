
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_applied_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAppliedJobRequest{

  @JsonKey(name: 'status')
  AppliedFarmerStatus? status;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  @JsonKey(name: 'sort-column')
  AppliedFarmerSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'startWork')
  String? startWork;
   
   GetAppliedJobRequest({
    this.status,
    this.startWork,
    this.sortColumn,
    this.orderBy,
    required this.page,
    required this.pageSize,
   });

   factory GetAppliedJobRequest.fromJson(Map<String, dynamic> json) => _$GetAppliedJobRequestFromJson(json);
   Map<String, dynamic> toJson() => _$GetAppliedJobRequestToJson(this);
}