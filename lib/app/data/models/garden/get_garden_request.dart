import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_garden_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetGardenRequest {
  @JsonKey(name: 'AreaId')
  String? areaId;

  @JsonKey(name: 'AccountId')
  String? accountId;

  @JsonKey(name: 'Name')
  String? name;

  @JsonKey(name: 'Description')
  String? description;

  @JsonKey(name: 'sort-column')
  GardenSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetGardenRequest({
    this.areaId,
    this.accountId,
    this.name,
    this.description,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize,
  });

  factory GetGardenRequest.fromJson(Map<String, dynamic> json) =>
      _$GetGardenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetGardenRequestToJson(this);
}
