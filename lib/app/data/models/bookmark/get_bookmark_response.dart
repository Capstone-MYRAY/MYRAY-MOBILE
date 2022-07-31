import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/bookmark/bookmark.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'get_bookmark_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetBookmarkResponse {
  @JsonKey(name: 'list_object')
  List<Bookmark> listObject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata pagingMetadata;

  GetBookmarkResponse({required this.listObject, required this.pagingMetadata});

  factory GetBookmarkResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBookmarkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetBookmarkResponseToJson(this);
}
