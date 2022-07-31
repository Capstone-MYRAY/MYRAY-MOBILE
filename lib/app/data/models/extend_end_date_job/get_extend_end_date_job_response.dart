import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'get_extend_end_date_job_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetExtendEndDateJobResponse {
  @JsonKey(name: 'list_object')
  List<ExtendEndDateJob>? extendRequests;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetExtendEndDateJobResponse({
    this.extendRequests,
    this.metadata,
  });

  factory GetExtendEndDateJobResponse.fromJson(Map<String, dynamic> json) =>
      _$GetExtendEndDateJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetExtendEndDateJobResponseToJson(this);
}
