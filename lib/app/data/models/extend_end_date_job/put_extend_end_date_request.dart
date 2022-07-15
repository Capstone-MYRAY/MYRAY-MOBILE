import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/post_extend_end_date_job_request.dart';
part 'put_extend_end_date_request.g.dart';

@JsonSerializable(includeIfNull: false)
class PutExtendEndDateRequest extends PostExtendEndDateJobRequest {
  @JsonKey(name: 'id')
  String id;

  PutExtendEndDateRequest({
    required this.id,
    required int jobPostId,
    required String extendEndDate,
    required String reason,
  }) : super(
          jobPostId: jobPostId,
          extendEndDate: extendEndDate,
          reason: reason,
        );
  factory PutExtendEndDateRequest.fromJson(Map<String, dynamic> json) => _$PutExtendEndDateRequestFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PutExtendEndDateRequestToJson(this);
}
