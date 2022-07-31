import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/enums/status.dart';

part 'get_applied_farmer_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAppliedFarmerRequest {
  @JsonKey(name: 'status')
  AppliedFarmerStatus? status;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  @JsonKey(name: 'jobPostId')
  String? jobPostId;

  @JsonKey(name: 'sort-column')
  AppliedFarmerSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  GetAppliedFarmerRequest({
    required this.page,
    required this.pageSize,
    this.status,
    this.jobPostId,
    this.sortColumn,
    this.orderBy,
  });

  factory GetAppliedFarmerRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAppliedFarmerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppliedFarmerRequestToJson(this);
}
