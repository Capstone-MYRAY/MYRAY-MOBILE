import 'package:json_annotation/json_annotation.dart';

part 'get_specific_feedback_request.g.dart';

@JsonSerializable()
class GetSpecificFeedbackRequest {
  String jobPostId;
  String belongedId;
  String createdById;

  GetSpecificFeedbackRequest({
    required this.jobPostId,
    required this.belongedId,
    required this.createdById,
  });

  factory GetSpecificFeedbackRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSpecificFeedbackRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetSpecificFeedbackRequestToJson(this);
}
