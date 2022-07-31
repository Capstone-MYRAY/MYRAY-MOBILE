
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'get_applied_job_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetAppliedJobPostList {

  @JsonKey(name: 'list_object')
  List<AppliedJobResponse>? listObject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? pagingMetadata;

  GetAppliedJobPostList({
    this.listObject,
    this.pagingMetadata,
  });

  factory GetAppliedJobPostList.fromJson(Map<String, dynamic> json) => _$GetAppliedJobPostListFromJson(json);
  Map<String, dynamic> toJson() => _$GetAppliedJobPostListToJson(this);
}