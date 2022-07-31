import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/upload_file/image_response.dart';

part 'upload_image_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadImageResponse {
  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'list_file')
  List<ImageResponse> files;

  UploadImageResponse({required this.count, required this.files});

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}
