
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
part 'get_feedback_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GetFeedbackRequest {

  @JsonKey(name: 'numStar')
  String? numStar;

  @JsonKey(name: 'jobPostId')
  String? jobPostId;

  @JsonKey(name: 'createdBy')
  String? createdBy;

  @JsonKey(name: 'sort-column')
  FeedbackSortColumn? sortColumn;

  @JsonKey(name: 'order-by')
  SortOrder? orderBy;

  @JsonKey(name: 'page')
  String? page;

  @JsonKey(name: 'page-size')
  String? pageSize;

  GetFeedbackRequest({
    this.numStar,
    this.jobPostId,
    this.createdBy,
    this.sortColumn,
    this.orderBy,
    this.page,
    this.pageSize
  });

  factory GetFeedbackRequest.fromJson(Map<String, dynamic> json) => _$GetFeedbackRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetFeedbackRequestToJson(this);
}