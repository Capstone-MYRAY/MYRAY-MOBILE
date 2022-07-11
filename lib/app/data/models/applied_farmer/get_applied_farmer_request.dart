import 'package:json_annotation/json_annotation.dart';
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

  @JsonKey(name: 'startWork')
  String? jobPostId;

  GetAppliedFarmerRequest({
    required this.page,
    required this.pageSize,
    this.status,
    this.jobPostId,
  });

  factory GetAppliedFarmerRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAppliedFarmerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppliedFarmerRequestToJson(this);
}
