
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
part 'get_comment_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetCommentRequest{

  @JsonKey(name: 'commentBy')
  String? commentBy;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'sort-column')
  CommentSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  @JsonKey(name: 'guidepostId')
  String? guidepostId;

  GetCommentRequest({
    this.commentBy,
    this.content,
    this.sortColumn,
    this.orderBy,
    this.page, 
    this.pageSize,
    this.guidepostId
  });


  factory GetCommentRequest.fromJson(Map<String, dynamic> json) => _$GetCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetCommentRequestToJson(this);
}