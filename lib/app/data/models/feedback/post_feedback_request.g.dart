// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFeedbackRequest _$PostFeedbackRequestFromJson(Map<String, dynamic> json) =>
    PostFeedbackRequest(
      content: json['content'] as String?,
      numStar: json['num_star'] as num,
      jobPostId: json['job_post_id'] as int,
      belongedId: json['belonged_id'] as int,
    );

Map<String, dynamic> _$PostFeedbackRequestToJson(PostFeedbackRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.content);
  val['num_star'] = instance.numStar;
  val['job_post_id'] = instance.jobPostId;
  val['belonged_id'] = instance.belongedId;
  return val;
}
