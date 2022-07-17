import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/message/landowner_messages/farmer.dart';

part 'message_job_post.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageJobPost {
  @JsonKey(name: 'jobPostId')
  int id;

  @JsonKey(name: 'jobPostTitle')
  String title;

  List<Farmer> farmers;

  MessageJobPost({
    required this.id,
    required this.title,
    required this.farmers,
  });

  factory MessageJobPost.fromJson(Map<String, dynamic> json) =>
      _$MessageJobPostFromJson(json);

  Map<String, dynamic> toJson() => _$MessageJobPostToJson(this);
}
