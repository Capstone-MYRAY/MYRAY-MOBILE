// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeType _$TreeTypeFromJson(Map<String, dynamic> json) => TreeType(
      id: json['id'] as int?,
      type: json['type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as int? ?? 0,
    );

Map<String, dynamic> _$TreeTypeToJson(TreeType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['type'] = instance.type;
  val['description'] = instance.description;
  val['status'] = instance.status;
  return val;
}
