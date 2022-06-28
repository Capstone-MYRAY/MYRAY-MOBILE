// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostType _$PostTypeFromJson(Map<String, dynamic> json) => PostType(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      color: json['color'] as String? ?? '000000',
      background: json['background'] as String? ?? '8E8EA1',
    );

Map<String, dynamic> _$PostTypeToJson(PostType instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['price'] = instance.price;
  val['color'] = instance.color;
  val['background'] = instance.background;
  return val;
}
