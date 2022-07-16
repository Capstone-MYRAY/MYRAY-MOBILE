import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

part 'message.g.dart';

@JsonSerializable(includeIfNull: false)
class Message {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'from_id')
  int fromId;

  @JsonKey(name: 'to_id')
  int toId;

  @JsonKey(name: 'job_post_id')
  int jobPostId;

  @JsonKey(name: 'content')
  String? message;

  @JsonKey(name: 'convention_id')
  String? conventionId;

  @JsonKey(name: 'created_date')
  DateTime? createdDate;

  @JsonKey(name: 'image_url')
  String? imgUrl;

  @JsonKey(name: 'is_read')
  bool isRead;

  Message({
    this.id,
    required this.fromId,
    required this.toId,
    required this.jobPostId,
    this.createdDate,
    this.conventionId,
    this.isRead = true,
    this.imgUrl,
    this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  bool get isMe => AuthCredentials.instance.user!.id! == fromId;
}
