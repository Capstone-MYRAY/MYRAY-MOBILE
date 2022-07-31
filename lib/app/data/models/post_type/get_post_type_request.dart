import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_post_type_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetPostTypeRequest {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'sort-column')
  PostTypeSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetPostTypeRequest({
    this.name,
    this.description,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
  });

  factory GetPostTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPostTypeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostTypeRequestToJson(this);
}
