import 'package:json_annotation/json_annotation.dart';

part 'area.g.dart';

@JsonSerializable(includeIfNull: false)
class Area {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'district')
  String district;

  @JsonKey(name: 'commune')
  String commune;

  @JsonKey(name: 'status')
  int status;

  Area({
    required this.id,
    required this.province,
    required this.district,
    required this.commune,
    required this.status,
  });

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);
}
