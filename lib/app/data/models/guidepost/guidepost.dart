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

@JsonKey(name: 'create_date')
DateTime createDate;

@JsonKey(name: 'update_date')
DateTime? updateDate;

@JsonKey(name: 'create_by')
int createBy;

Guidepost({
  required this.id,
  required this.title,
  required this.content,
  required this.createDate,
  required this.createBy,
  this.updateDate
});

factory Guidepost.fromJson(Map<String, dynamic> json) => _$GuidepostFromJson(json);
Map<String, dynamic> toJson() => _$GuidepostToJson(this);

}