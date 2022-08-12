import 'package:json_annotation/json_annotation.dart';

part 'work_type.g.dart';

@JsonSerializable()
class WorkType {
  int id;
  String name;
  int status;

  WorkType({
    required this.id,
    required this.name,
    required this.status,
  });

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return other is WorkType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  factory WorkType.fromJson(Map<String, dynamic> json) =>
      _$WorkTypeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkTypeToJson(this);
}
