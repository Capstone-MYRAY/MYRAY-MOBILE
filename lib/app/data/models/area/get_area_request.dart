import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';

part 'get_area_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAreaRequest {
  @JsonKey(name: 'province')
  String? province;

  @JsonKey(name: 'district')
  String? district;

  @JsonKey(name: 'commune')
  String? commune;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'sort-column')
  AreaSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetAreaRequest({
    this.province,
    this.district,
    this.commune,
    this.status,
    this.sortColumn,
    this.orderBy,
    this.page = '1',
    this.pageSize = '20',
  });

  factory GetAreaRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAreaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAreaRequestToJson(this);
}
