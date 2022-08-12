import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_work_type_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetWorkTypeRequest {
  String? name;

  @JsonKey(name: 'sort-column')
  WorkTypeSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'page-size')
  String pageSize;

  GetWorkTypeRequest({
    required this.page,
    required this.pageSize,
    this.name,
    this.sortColumn,
    this.orderBy,
  });

  factory GetWorkTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetWorkTypeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetWorkTypeRequestToJson(this);
}
