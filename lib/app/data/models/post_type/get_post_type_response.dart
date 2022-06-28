import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
import 'package:myray_mobile/app/data/models/post_type/post_type.dart';

part 'get_post_type_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetPostTypeResponse {
  @JsonKey(name: 'list_object')
  List<PostType>? postTypes;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetPostTypeResponse({this.postTypes, this.metadata});

  factory GetPostTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostTypeResponseToJson(this);
}
