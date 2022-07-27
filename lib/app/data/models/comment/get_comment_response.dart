
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/comment/comment.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'get_comment_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetCommentResponse{

  @JsonKey(name: 'list_object')
  List<Comment>? listObject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? pagingMetadata;

  GetCommentResponse({
    this.listObject,
    this.pagingMetadata
  });

  factory GetCommentResponse.fromJson(Map<String, dynamic> json) => _$GetCommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetCommentResponseToJson(this);
}