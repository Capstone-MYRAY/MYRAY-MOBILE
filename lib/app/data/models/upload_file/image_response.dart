import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: 'filename')
  String fileName;

  @JsonKey(name: 'oldname')
  String oldName;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'size')
  String size;

  @JsonKey(name: 'type')
  String type;

  ImageResponse({
    required this.fileName,
    required this.oldName,
    required this.link,
    required this.size,
    required this.type,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
