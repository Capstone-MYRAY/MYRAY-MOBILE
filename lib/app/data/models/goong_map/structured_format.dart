import 'package:json_annotation/json_annotation.dart';

part 'structured_format.g.dart';

@JsonSerializable(includeIfNull: false)
class StructuredFormat {
  @JsonKey(name: 'main_text')
  String mainText;

  @JsonKey(name: 'secondary_text')
  String secondaryText;

  StructuredFormat({required this.mainText, required this.secondaryText});

  factory StructuredFormat.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormatFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormatToJson(this);
}
