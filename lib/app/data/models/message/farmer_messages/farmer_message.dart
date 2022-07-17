import 'package:json_annotation/json_annotation.dart';

part 'farmer_message.g.dart';

@JsonSerializable(includeIfNull: false)
class FarmerMessage {
  @JsonKey(name: 'Id')
  int jobPostId;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'PublishedId')
  int publishedId;

  @JsonKey(name: 'PublishedBy')
  String publishedName;

  @JsonKey(name: 'AvatarUrl')
  String? avatar;

  @JsonKey(name: 'LastMessageTime')
  DateTime? createdDate;

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
