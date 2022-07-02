import 'package:json_annotation/json_annotation.dart';

part 'tree_type.g.dart';

@JsonSerializable(includeIfNull: false)
class TreeType {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'status')
  int status;

  TreeType({
    this.id,
    this.type = '',
    this.description = '',
    this.status = 0,
  });

  factory TreeType.fromJson(Map<String, dynamic> json) =>
      _$TreeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TreeTypeToJson(this);
}
