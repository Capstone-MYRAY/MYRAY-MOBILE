// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidepost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guidepost _$GuidepostFromJson(Map<String, dynamic> json) => Guidepost(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createDate: DateTime.parse(json['create_date'] as String),
      createBy: json['create_by'] as int,
      updateDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$GuidepostToJson(Guidepost instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'content': instance.content,
    'create_date': instance.createDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('update_date', instance.updateDate?.toIso8601String());
  val['create_by'] = instance.createBy;
  return val;
}
