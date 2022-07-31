import 'package:json_annotation/json_annotation.dart';
part 'guidepost.g.dart';

@JsonSerializable(includeIfNull: false)
class Guidepost {

@JsonKey(name: 'id')
int id;

@JsonKey(name: 'title')
String title;

@JsonKey(name: 'content')
String content;

@JsonKey(name: 'created_date')
DateTime createdDate;

@JsonKey(name: 'updated_date')
DateTime? updatedDate;

@JsonKey(name: 'created_by')
int createdBy;

Guidepost({
  required this.id,
  required this.title,
  required this.content,
  required this.createdDate,
  required this.createdBy,
  this.updatedDate
});

factory Guidepost.fromJson(Map<String, dynamic> json) => _$GuidepostFromJson(json);
Map<String, dynamic> toJson() => _$GuidepostToJson(this);

}