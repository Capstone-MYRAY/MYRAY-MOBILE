import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'get_applied_farmer_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetAppliedFarmerResponse {
  @JsonKey(name: 'list_object')
  List<AppliedFarmer>? appliedFarmers;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetAppliedFarmerResponse({this.appliedFarmers, this.metadata});

  factory GetAppliedFarmerResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAppliedFarmerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppliedFarmerResponseToJson(this);
}
