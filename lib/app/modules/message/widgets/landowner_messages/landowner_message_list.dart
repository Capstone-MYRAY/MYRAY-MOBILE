import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/landowner_messages/message_job_post.dart';
import 'package:myray_mobile/app/modules/message/controllers/landowner_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_item.dart';
import 'package:myray_mobile/app/modules/message/widgets/landowner_messages/landowner_message_job_post.dart';

class LandownerMessageList extends StatelessWidget {
  final List<MessageJobPost> messages;
  final void Function(
      {required int toId,
      required int jobPostId,
      required String conventionId,
      required String toName,
      required String jobTitle,
      String? avatar}) onTap;

  const LandownerMessageList({
    Key? key,
    required this.messages,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return LandownerMessageJobPost(
          key: ValueKey(message.id),
          tag: message.id.toString(),
          title: message.title,
          jobMessages: message.farmers.map(
            (farmerMsg) {
              final lastMessage = farmerMsg.lastMessage;
              final msg = lastMessage.message ?? '';
              final displayMsg = lastMessage.isMe ? 'Bạn: $msg' : msg;
              return GetBuilder<LandownerMessageController>(
                id: farmerMsg.conventionId,
                builder: (_) => LandownerMessageItem(
                  key: ValueKey(farmerMsg.conventionId),
                  name: farmerMsg.name,
                  message: displayMsg,
                  isRead: lastMessage.isRead,
                  createdDate: lastMessage.createdDate,
                  avatar: lastMessage.imgUrl,
                  onTap: () {
                    onTap(
                      toId: farmerMsg.id,
                      conventionId: farmerMsg.conventionId,
                      jobPostId: message.id,
                      toName: farmerMsg.name,
                      jobTitle: message.title,
                      avatar: farmerMsg.avatar,
                    );
                  },
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
