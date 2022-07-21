
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'get_feedback_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetFeedBackResponse{

  @JsonKey(name: 'list_object')
  List<FeedBack>? listobject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? pagingMetadata;

  GetFeedBackResponse({
    this.listobject,
    this.pagingMetadata,
  });

  factory GetFeedBackResponse.fromJson(Map<String, dynamic> json) => _$GetFeedBackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetFeedBackResponseToJson(this);

}