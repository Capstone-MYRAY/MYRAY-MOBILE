import 'package:json_annotation/json_annotation.dart';

part 'message_details.g.dart';

@JsonSerializable(includeIfNull: false)
class MessageDetails {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'fromId')
  int fromId;

  @JsonKey(name: 'toId')
  int toId;

  @JsonKey(name: 'jobPostId')
  int jobPostId;

  @JsonKey(name: 'content')
  String? message;

  @JsonKey(name: 'conventionId')
  String? conventionId;

  @JsonKey(name: 'createdDate')
  DateTime? createdDate;

  @JsonKey(name: 'imageUrl')
  String? imgUrl;

  @JsonKey(name: 'isRead')
  bool isRead;

  MessageDetails({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.jobPostId,
    this.createdDate,
    this.conventionId,
    this.isRead = true,
    this.imgUrl,
    this.message,
  });

  factory MessageDetails.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailsToJson(this);
}
