
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'get_extend_end_date_job_list_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetExtendEndDateJobList{

  @JsonKey(name: 'list_object')
  List<ExtendEndDateJob>? listObject;

  @JsonKey(name: 'second_object')
  List<ExtendEndDateJob>? secondObject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? pagingMetadata;

  GetExtendEndDateJobList({
    this.listObject,
    this.secondObject,
    this.pagingMetadata,
  });

  factory GetExtendEndDateJobList.fromJson(Map<String, dynamic> json) => _$GetExtendEndDateJobListFromJson(json);
  Map<String, dynamic> toJson() => _$GetExtendEndDateJobListToJson(this);
}