
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'job_post_response.g.dart';

@JsonSerializable(includeIfNull: false)
class JobPostResponse{

  @JsonKey(name: 'list_object')
  List<JobPost> listJobPost;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata pagingMetadata;

  JobPostResponse({
    required this.listJobPost,
    required this.pagingMetadata  
  });

  factory JobPostResponse.fromJson(Map<String, dynamic> json) => _$JobPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JobPostResponseToJson(this);
}