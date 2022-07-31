import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';

part 'get_tree_type_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetTreeTypeRequest {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'sort-column')
  TreeTypeSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetTreeTypeRequest({
    this.type,
    this.status,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
  });

  factory GetTreeTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetTreeTypeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetTreeTypeRequestToJson(this);
}
