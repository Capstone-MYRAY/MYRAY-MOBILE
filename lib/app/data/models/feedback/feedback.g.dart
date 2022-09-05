// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedBack _$FeedBackFromJson(Map<String, dynamic> json) => FeedBack(
      id: json['id'] as int,
      createdDate: DateTime.parse(json['created_date'] as String),
      createdBy: json['created_by'] as int,
      content: json['content'] as String?,
      numStar: json['num_star'] as num,
      jobPostId: json['job_post_id'] as int,
      belongedId: json['belonged_id'] as int,
    );

Map<String, dynamic> _$FeedBackToJson(FeedBack instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'created_date': instance.createdDate.toIso8601String(),
    'created_by': instance.createdBy,
  };

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
