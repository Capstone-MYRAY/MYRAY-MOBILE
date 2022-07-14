import 'package:flutter/material.dart';
import 'package:myray_mobile/app/modules/message/widgets/message_bubble.dart';

class P2PMessages extends StatelessWidget {
  final List messages;
  const P2PMessages({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final messageInfo = messages[index];
        return MessageBubble(
          // key: to do later,
          message: messageInfo['content'],
          isMe: messageInfo['isMe'],
          avatar: messageInfo['avatar'],
        );
      },
    );
  }
}
