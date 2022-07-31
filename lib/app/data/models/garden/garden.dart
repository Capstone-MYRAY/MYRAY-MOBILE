import 'package:json_annotation/json_annotation.dart';

part 'garden.g.dart';

@JsonSerializable(includeIfNull: false)
class Garden {
  @JsonKey(name: 'id')
  int id;

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

  @JsonKey(name: 'create_date')
  DateTime? createdDate;

  @JsonKey(name: 'update_date')
  DateTime? updatedDate;

  @JsonKey(name: 'status')
  int? status;

  Garden({
    required this.areaId,
    required this.accountId,
    required this.latitudes,
    required this.longitudes,
    required this.landArea,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.id,
    this.createdDate,
    this.status,
    this.updatedDate,
  });

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return other is Garden && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory Garden.fromJson(Map<String, dynamic> json) => _$GardenFromJson(json);
  Map<String, dynamic> toJson() => _$GardenToJson(this);
}
