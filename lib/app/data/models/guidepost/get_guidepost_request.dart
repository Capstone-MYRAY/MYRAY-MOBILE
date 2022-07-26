
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
part 'get_guidepost_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetGuidepostRequest{

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'createBy')
  String? createBy;

  @JsonKey(name: 'sort-column')
  GuidepostSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetGuidepostRequest({
    this.title,
    this.content,
    this.createBy,
    this.orderBy,
    this.sortColumn,
    this.page,
    this.pageSize
  });
  factory GetGuidepostRequest.fromJson(Map<String, dynamic> json) => _$GetGuidepostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetGuidepostRequestToJson(this);
}