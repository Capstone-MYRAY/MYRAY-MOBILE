// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidepost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guidepost _$GuidepostFromJson(Map<String, dynamic> json) => Guidepost(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdDate: DateTime.parse(json['created_date'] as String),
      createdBy: json['created_by'] as int,
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
    );

Map<String, dynamic> _$GuidepostToJson(Guidepost instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
    'content': instance.content,
    'created_date': instance.createdDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updated_date', instance.updatedDate?.toIso8601String());
  val['created_by'] = instance.createdBy;
  return val;
}
