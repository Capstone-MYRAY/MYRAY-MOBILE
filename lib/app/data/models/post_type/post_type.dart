import 'package:json_annotation/json_annotation.dart';

part 'post_type.g.dart';

@JsonSerializable(includeIfNull: false)
class PostType {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'color')
  String color;

  @JsonKey(name: 'background')
  String background;

  PostType({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.color = '000000',
    this.background = '8E8EA1',
  });

  @override
  String toString() {
    return name;
  }

  factory PostType.fromJson(Map<String, dynamic> json) =>
      _$PostTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PostTypeToJson(this);
}
