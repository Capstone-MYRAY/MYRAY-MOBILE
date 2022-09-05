import 'package:json_annotation/json_annotation.dart';

part 'extend_farmer_request.g.dart';

@JsonSerializable()
class ExtendFarmerRequest {
  @JsonKey(name: 'jobPostId')
  String jobPostId;

  @JsonKey(name: 'maxFarmer')
  String maxFarmer;

  ExtendFarmerRequest({required this.jobPostId, required this.maxFarmer});

  factory ExtendFarmerRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtendFarmerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendFarmerRequestToJson(this);
}
