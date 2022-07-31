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

  String get _imgMsg {
    final msg = StringBuffer();
    if (lastMessage.message == null) {
      if (lastMessage.isMe) {
        msg.write('Bạn');
      } else {
        msg.write(name);
      }
      msg.write(' đã gửi 1 ảnh.');
    }
    return msg.toString();
  }

  String get msgDisplay {
    String msg = _imgMsg;
    if (_imgMsg.isNotEmpty) return msg;
    if (lastMessage.isMe) return 'Bạn: ${lastMessage.message}';
    return lastMessage.message ?? '';
  }

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);

  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}
