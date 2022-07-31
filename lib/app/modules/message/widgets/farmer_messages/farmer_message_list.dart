import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/message/farmer_messages/farmer_message.dart';
import 'package:myray_mobile/app/modules/message/controllers/farmer_message_controller.dart';
import 'package:myray_mobile/app/modules/message/widgets/farmer_messages/farmer_message_item.dart';

class FarmerMessageList extends StatelessWidget {
  final List<FarmerMessage> messages;
  final void Function({
    required int toId,
    required int jobPostId,
    required String toName,
    required String jobTitle,
    String? avatar,
  }) onTap;
  const FarmerMessageList({
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
        return GetBuilder<FarmerMessageController>(
          id: message.jobPostId,
          builder: (_) => FarmerMessageItem(
            key: ValueKey(message.jobPostId),
            title: message.title,
            name: message.publishedName,
            isRead: message.isRead,
            createdDate: message.createdDate,
            onTap: () => onTap(
              toId: message.publishedId,
              jobPostId: message.jobPostId,
              avatar: message.avatar,
              toName: message.publishedName,
              jobTitle: message.title,
            ),
          ),
        );
      },
    );
  }
}
