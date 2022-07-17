import 'package:flutter/material.dart';
import 'package:myray_mobile/app/data/models/message/message.dart';
import 'package:myray_mobile/app/modules/message/widgets/message_bubble.dart';

class P2PMessages extends StatelessWidget {
  final List<Message> messages;
  final String? toAvatar;
  const P2PMessages({
    Key? key,
    required this.messages,
    this.toAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final messageInfo = messages[index];
        return MessageBubble(
          key: UniqueKey(),
          message: messageInfo.message,
          isMe: messageInfo.isMe,
          avatar: toAvatar,
          imageUrl: messageInfo.imgUrl,
          createdDate: messageInfo.createdDate,
          // isSameTime: isSameTime,
        );
      },
    );
  }
}
