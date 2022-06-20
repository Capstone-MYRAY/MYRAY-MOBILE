import 'package:json_annotation/json_annotation.dart';

part 'post_garden_request.g.dart';

@JsonSerializable()
class PostGardenRequest {
  @JsonKey(name: 'area_id')
  int areaId;

  @JsonKey(name: 'account_id')
  int accountId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'latitudes')
  double latitudes;

  @JsonKey(name: 'longitudes')
  double longitudes;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'land_area')
  double landArea;

  @JsonKey(name: 'image_url')
  String imageUrl;

  @JsonKey(name: 'description')
  String description;

  PostGardenRequest({
    required this.areaId,
    required this.accountId,
    required this.latitudes,
    required this.longitudes,
    required this.landArea,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.name,
  });

  factory PostGardenRequest.fromJson(Map<String, dynamic> json) =>
      _$PostGardenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostGardenRequestToJson(this);
}
