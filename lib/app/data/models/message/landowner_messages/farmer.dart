import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/message/landowner_messages/message_details.dart';

part 'farmer.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Farmer {
  int id;
  String name;

  @JsonKey(name: 'image')
  String? avatar;

  String conventionId;
  MessageDetails lastMessage;

  Farmer({
    required this.id,
    required this.name,
    required this.conventionId,
    required this.lastMessage,
    this.avatar,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}
