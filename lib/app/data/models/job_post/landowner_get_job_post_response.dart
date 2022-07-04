import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'landowner_get_job_post_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class LandownerGetJobPostResponse {
  @JsonKey(name: 'list_object')
  List<JobPost>? jobPosts;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  LandownerGetJobPostResponse({this.jobPosts, this.metadata});

  factory LandownerGetJobPostResponse.fromJson(Map<String, dynamic> json) =>
      _$LandownerGetJobPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LandownerGetJobPostResponseToJson(this);
}
