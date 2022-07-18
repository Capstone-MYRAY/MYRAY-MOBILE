import 'package:json_annotation/json_annotation.dart';

part 'farmer_message.g.dart';

@JsonSerializable(includeIfNull: false)
class FarmerMessage {
  @JsonKey(name: 'id')
  int jobPostId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'publishedId')
  int publishedId;

  @JsonKey(name: 'publishedBy')
  String publishedName;

  @JsonKey(name: 'avatarUrl')
  String? avatar;

  @JsonKey(name: 'lastMessageTime')
  DateTime? createdDate;

  @JsonKey(name: 'isRead')
  bool isRead;

  FarmerMessage({
    required this.jobPostId,
    required this.title,
    required this.publishedId,
    required this.publishedName,
    this.avatar,
    this.createdDate,
    this.isRead = false,
  });

  factory FarmerMessage.fromJson(Map<String, dynamic> json) =>
      _$FarmerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerMessageToJson(this);
}
